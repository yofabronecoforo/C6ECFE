--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedgamesetuplogic.lua configuration script
	this file is a wrapper
	any ECFE modifications that affect GameSetupLogic.lua, and thus both AdvancedSetup and HostGame, should go here
	any additional modifications to GameSetupLogic will be included by directives at the end of this file
=========================================================================== ]]
print("[i]: Loading EnhancedGameSetupLogic.lua UI wrapper . . .");

--[[ =========================================================================
	NEW: this driver is for creating the picker window control indicated by parameter
	since there were only minor differences between the various original picker drivers, they have been condensed here
	picker button text is modified to reflect both the amount of selected items and the amount of available itemms
	picker button tooltip text is modified to reflect sources of available content
	the original drivers are found in AdvancedSetup and HostGame, and should still exist unless otherwise replaced
	this is going here to avoid duplicating code
=========================================================================== ]]
function CreatePickerDriverByParameter(o, parameter, parent) 
	if(parent == nil) then 
		parent = GetControlStack(parameter.GroupId);
	end
			
	-- Get the UI instance
	local c :object = g_ButtonParameterManager:GetInstance();	

	local parameterId = parameter.ParameterId;
	local button = c.Button;

	-- print(string.format("[+]: Creating driver for %s picker . . .", parameterId));

	-- define picker based on parameterId
	if (parameterId == "CityStates") then    -- built-in city-state picker
		button:RegisterCallback( Mouse.eLClick, function()
			LuaEvents.CityStatePicker_Initialize(o.Parameters[parameterId], g_GameParameters);
			Controls.CityStatePicker:SetHide(false);
		end);
	elseif (parameterId == "LeaderPool1" or parameterId == "LeaderPool2") then    -- built-in leader picker
		button:RegisterCallback( Mouse.eLClick, function()
			LuaEvents.LeaderPicker_Initialize(o.Parameters[parameterId], g_GameParameters);
			Controls.LeaderPicker:SetHide(false);
		end);
	else    -- fallback to generic multi-select window
		button:RegisterCallback( Mouse.eLClick, function()
			LuaEvents.MultiSelectWindow_Initialize(o.Parameters[parameterId]);
			Controls.MultiSelectWindow:SetHide(false);
		end);
	end
	button:SetToolTipString(parameter.Description .. ECFE.Content.Tooltips[GameConfiguration.GetValue("RULESET")][parameterId]);    -- show content sources in tooltip text

	-- Store the root control, NOT the instance table.
	g_SortingMap[tostring(c.ButtonRoot)] = parameter;

	c.ButtonRoot:ChangeParent(parent);
	if c.StringName ~= nil then
		c.StringName:SetText(parameter.Name);
	end

	local cache = {};

	local kDriver :table = {
		Control = c,
		Cache = cache,
		UpdateValue = function(value, p)
			local valueText = value and value.Name or nil;
			local valueAmount :number = 0;

			-- if this driver is for one of the leader pickers, remove random leaders from the Values table that is used to determine number of leaders selected
			if (parameterId == "LeaderPool1" or parameterId == "LeaderPool2") then 
				for i = #p.Values, 1, -1 do
					local kItem:table = p.Values[i];
					-- print(kItem.Value);
					if kItem.Value == "RANDOM" or kItem.Value == "RANDOM_POOL1" or kItem.Value == "RANDOM_POOL2" then
						table.remove(p.Values, i);
					end
				end
			end

			-- only amounts displayed by valueText change now so updates to it have been removed here; can this be further simplified?
			if(valueText == nil) then 
				if(value == nil) then 
					if (parameter.UxHint ~= nil and parameter.UxHint == "InvertSelection") then 
						valueAmount = #p.Values;    -- all available items
					end
				elseif(type(value) == "table") then 
					local count = #value;
					if (parameter.UxHint ~= nil and parameter.UxHint == "InvertSelection") then 
						if(count == 0) then 
							valueAmount = #p.Values;    -- all available items
						else 
							valueAmount = #p.Values - count;
						end
					else 
						if(count == #p.Values) then 
							valueAmount = #p.Values;    -- all available items
						else 
							valueAmount = count;
						end
					end
				end
			end

			-- update valueText here
			valueText = string.format("%s %d of %d", Locale.Lookup("LOC_PICKER_SELECTED_TEXT"), valueAmount, #p.Values);

			-- add update to tooltip text here
			if(cache.ValueText ~= valueText) or (cache.ValueAmount ~= valueAmount) then 
				local button = c.Button;
				button:LocalizeAndSetText(valueText);
				cache.ValueText = valueText;
				cache.ValueAmount = valueAmount;
				button:SetToolTipString(parameter.Description .. ECFE.Content.Tooltips[GameConfiguration.GetValue("RULESET")][parameterId]);    -- show content sources in tooltip text
			end
		end,
		UpdateValues = function(values, p) 
			-- Values are refreshed when the window is open.
		end,
		SetEnabled = function(enabled, p)
			c.Button:SetDisabled(not enabled or #p.Values <= 1);
		end,
		SetVisible = function(visible)
			c.ButtonRoot:SetHide(not visible);
		end,
		Destroy = function()
			g_ButtonParameterManager:ReleaseInstance(c);
		end,
	};	

	return kDriver;
end

--[[ =========================================================================
	OVERRIDE: the various picker drivers have been condensed into CreatePickerDriverByParameter()
    these drivers are no longer required, nor is the original GameParameters_UI_CreateParameterDriver()
	the original function is found in AdvancedSetup and HostGame, and should still exist unless otherwise replaced
	this is going here to avoid duplicating code
=========================================================================== ]]
function GameParameters_UI_CreateParameterDriver(o, parameter, ...) 
	if not parameter.Array then 
		return GameParameters_UI_DefaultCreateParameterDriver(o, parameter, ...);
	else 
		local parameterId = parameter.ParameterId;
		if parameterId == "NaturalWonders" then 
			return CreatePickerDriverByParameter(o, parameter);
		else 
			if not GameConfiguration.IsWorldBuilderEditor() then 
				return CreatePickerDriverByParameter(o, parameter);
			else 
				return nil;
			end
		end
	end
end

--[[ =========================================================================
	NEW/OVERRIDE: declare OnSetParameterValue() here if the loaded AdvancedSetup or HostGame script does not do so
	otherwise use the previously defined function
	this is going here to avoid duplicating code
=========================================================================== ]]
OnSetParameterValue = OnSetParameterValue or function (pid: string, value: number) 
	if (g_GameParameters) then 
		local kParameter: table = g_GameParameters.Parameters and g_GameParameters.Parameters[pid] or nil;
		if (kParameter and kParameter.Value ~= nil) then	
            g_GameParameters:SetParameterValue(kParameter, value);
			Network.BroadcastGameConfig();	
		end
	end	
end

--[[ =========================================================================
	include any additional modifications to GameSetupLogic
=========================================================================== ]]
print("[i]: Including any imported files matching pattern '{G|g}ame{S|s}etup{L|l}ogic_*.lua' . . .");
include("GameSetupLogic_", true);
include("gamesetuplogic_", true);

--[[ =========================================================================
	log successful loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedGameSetupLogic.lua UI wrapper.");

--[[ =========================================================================
	end enhancedgamesetuplogic.lua configuration script
=========================================================================== ]]
