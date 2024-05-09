--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin commonfrontend.lua configuration script
	this file contains new components that are used by both the (Enhanced)AdvancedSetup and (Enhanced)HostGame contexts
	it should be included by those contexts before any other files that are to be included
=========================================================================== ]]
print("[i]: Loading CommonFrontend.lua UI script . . .");

--[[ =========================================================================
	global content presence booleans
=========================================================================== ]]
-- g_bIsEnabledECSS  = Modding.IsModEnabled("772960cc-ddaf-4432-870c-e97d698d7011");    -- Enhanced City-States Selection
-- g_bIsEnabledEGHV  = Modding.IsModEnabled("a4b1fac6-8c9e-4873-a1c1-7ddf08dbbf11");    -- Enhanced Goodies and Hostile Villagers
-- g_bIsEnabledENWS  = Modding.IsModEnabled("d0afae5b-02f8-4d01-bd54-c2bbc3d89858");    -- Enhanced Natural Wonders Selection
-- g_bIsEnabledYnAMP = Modding.IsModEnabled("36e88483-48fe-4545-b85f-bafc50dde315");    -- Yet (not) Another Map Pack
-- g_bIsEnabledGCM   = Modding.IsModEnabled("c185a48b-75d0-4897-9134-83308c5fe5ae");    -- Game Config Manager

--[[ =========================================================================
	global picker tooltip tables; these will be indexed by ruleset
=========================================================================== ]]
-- g_tCityStatesTooltip     = {};
-- g_tGoodyHutsTooltip      = {};
-- g_tLeadersTooltip        = {};
-- g_tNaturalWondersTooltip = {};

--[[ =========================================================================
	global strings
=========================================================================== ]]
g_sRowOfDashes = "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";

--[[ =========================================================================
	NEW: append localized text to picker tooltips
=========================================================================== ]]
-- function UpdateTooltipText( r, s, t ) 
-- 	if t.CityStates then g_tCityStatesTooltip[r] = string.format("%s%s", g_tCityStatesTooltip[r], s); end
-- 	if t.GoodyHuts then g_tGoodyHutsTooltip[r] = string.format("%s%s", g_tGoodyHutsTooltip[r], s); end
-- 	if t.Leaders then g_tLeadersTooltip[r] = string.format("%s%s", g_tLeadersTooltip[r], s); end
-- 	if t.NaturalWonders then g_tNaturalWondersTooltip[r] = string.format("%s%s", g_tNaturalWondersTooltip[r], s); end
-- end

--[[ =========================================================================
	NEW: validate active content and set tooltip strings
	Modding.IsModActive() does not appear to work in Frontend context, so we're using IsModInstalled() and IsModEnabled() instead
=========================================================================== ]]
-- function RefreshActiveContentTooltips() 
-- 	-- known and active recognized items, and the default picker tooltip string
-- 	local iKnownItems, iActiveItems = 0, 0;
-- 	local sStandard                 = Locale.Lookup("LOC_STANDARD_TT");
-- 	-- (re)set tooltip string tables
--     g_tCityStatesTooltip     = { ["RULESET_STANDARD"] = sStandard, ["RULESET_EXPANSION_1"] = sStandard, ["RULESET_EXPANSION_2"] = sStandard };
--     g_tGoodyHutsTooltip      = { ["RULESET_STANDARD"] = sStandard, ["RULESET_EXPANSION_1"] = sStandard, ["RULESET_EXPANSION_2"] = sStandard };
--     g_tLeadersTooltip        = { ["RULESET_STANDARD"] = sStandard, ["RULESET_EXPANSION_1"] = sStandard, ["RULESET_EXPANSION_2"] = sStandard };
--     g_tNaturalWondersTooltip = { ["RULESET_STANDARD"] = sStandard, ["RULESET_EXPANSION_1"] = sStandard, ["RULESET_EXPANSION_2"] = sStandard };
-- 	-- query ContentFlags and parse results for active content
-- 	print("[i]: Querying Configuration table ContentFlags for known content . . .");
-- 	local tContent = DB.ConfigurationQuery("SELECT DISTINCT * from ContentFlags");
-- 	if tContent and #tContent > 0 then 
-- 		iKnownItems = #tContent;
-- 		local sItems = (iKnownItems ~= 1) and "items" or "item";
-- 		print(string.format("[i]: Identified %d known %s; parsing for active content and updating picker tooltip text accordingly . . .", iKnownItems, sItems));
-- 		for _, item in ipairs(tContent) do 
-- 			if (Modding.IsModInstalled(item.GUID) and Modding.IsModEnabled(item.GUID)) then 
-- 				iActiveItems   = iActiveItems + 1;
-- 				local sTooltip = Locale.Lookup(item.Tooltip);
-- 				if item.Base then UpdateTooltipText("RULESET_STANDARD", sTooltip, item); end
-- 				if item.XP1 then UpdateTooltipText("RULESET_EXPANSION_1", sTooltip, item); end
-- 				if item.XP2 then UpdateTooltipText("RULESET_EXPANSION_2", sTooltip, item); end
-- 			end
-- 		end
-- 		print(string.format("[i]: Picker tooltip text updated to reflect %d active of %d known %s; proceeding . . .", iActiveItems, iKnownItems, sItems));
-- 	else
-- 		print("[i]: Configuration table ContentFlags is empty or undefined; proceeding without parsing content flags . . .");
-- 	end
-- end

--[[ =========================================================================
	NEW: update a specific picker's tooltip text based on selected ruleset
=========================================================================== ]]
-- function UpdateButtonToolTip(parameterId) 
--     local sRuleset = GameConfiguration.GetValue("RULESET");
-- 	if (parameterId == "CityStates") then return g_tCityStatesTooltip[sRuleset];
-- 	elseif (parameterId == "LeaderPool1" or parameterId == "LeaderPool2") then return g_tLeadersTooltip[sRuleset];
-- 	elseif (parameterId == "GoodyHutConfig") then return g_tGoodyHutsTooltip[sRuleset];
-- 	elseif (parameterId == "NaturalWonders" or parameterId == "StartWonders") then return g_tNaturalWondersTooltip[sRuleset];
-- 	else return "";    -- return empty string here to prevent attempts to concatenate nil
-- 	end
-- end

--[[ =========================================================================
	NEW: this driver is for launching the picker indicated by parameter in a separate window
	since there were only 2 lines that differed between the various original picker drivers, they have been condensed here
	picker button text is modified to reflect both the amount of selected items and the amount of available itemms
	tooltip text is modified to reflect sources of available content
	any new picker(s) can be handled by adding new and/or modifying existing (else)if statement(s) below
	the original drivers that this driver replaces should still exist in an unmodified state
=========================================================================== ]]
function CreatePickerDriverByParameter(o, parameter, parent) 

	if(parent == nil) then
		parent = GetControlStack(parameter.GroupId);
	end
			
	-- Get the UI instance
	local c :object = g_ButtonParameterManager:GetInstance();	

	local parameterId = parameter.ParameterId;
	local button = c.Button;

	print(string.format("[+]: Creating driver for %s picker . . .", parameterId));

	-- define picker based on parameterId
	if (parameterId == "CityStates") then												-- built-in city-state picker
		button:RegisterCallback( Mouse.eLClick, function()
			LuaEvents.CityStatePicker_Initialize(o.Parameters[parameterId], g_GameParameters);
			Controls.CityStatePicker:SetHide(false);
		end);
	elseif (parameterId == "LeaderPool1" or parameterId == "LeaderPool2") then			-- built-in leader picker
		button:RegisterCallback( Mouse.eLClick, function()
			LuaEvents.LeaderPicker_Initialize(o.Parameters[parameterId], g_GameParameters);
			Controls.LeaderPicker:SetHide(false);
		end);
	-- elseif (parameterId == "GoodyHutConfig" and g_bIsEnabledEGHV) then					-- EGHV : Goody Hut picker
	-- 	button:RegisterCallback( Mouse.eLClick, function()
	-- 		LuaEvents.GoodyHutPicker_Initialize(o.Parameters[parameterId]);
	-- 		Controls.GoodyHutPicker:SetHide(false);
	-- 	end);
	-- elseif (parameterId == "NaturalWonders" and g_bIsEnabledENWS) then					-- ENWS : Natural Wonder picker
	-- 	button:RegisterCallback( Mouse.eLClick, function()
	-- 		LuaEvents.NaturalWonderPicker_Initialize(o.Parameters[parameterId]);
	-- 		Controls.NaturalWonderPicker:SetHide(false);
	-- 	end);
	else																				-- fallback to generic multi-select window
		button:RegisterCallback( Mouse.eLClick, function()
			LuaEvents.MultiSelectWindow_Initialize(o.Parameters[parameterId]);
			Controls.MultiSelectWindow:SetHide(false);
		end);
	end
	-- button:SetToolTipString(parameter.Description .. UpdateButtonToolTip(parameterId));		-- update button tooltip text
	button:SetToolTipString(parameter.Description .. ECFE.Content.Tooltips[GameConfiguration.GetValue("RULESET")][parameterId]);		-- update button tooltip text

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

			-- local priorityAmount :number = 0;
			-- if (parameterId == "CityStates" and g_bIsEnabledECSS) then 
			-- 	priorityAmount = GameConfiguration.GetValue("PRIORITY_CITY_STATES_COUNT") or 0;
			-- elseif (parameterId == "NaturalWonders" and g_bIsEnabledENWS) then 
			-- 	priorityAmount = GameConfiguration.GetValue("PRIORITY_NATURAL_WONDERS_COUNT") or 0;
			-- end
			-- local priorityText = (priorityAmount > 0) and string.format(", %s %d", Locale.Lookup("LOC_PICKER_PRIORITIZED_TEXT"), priorityAmount) or "";

			if(valueText == nil) then
				if(value == nil) then
					if (parameter.UxHint ~= nil and parameter.UxHint == "InvertSelection") then
						valueText = "LOC_SELECTION_EVERYTHING";
						valueAmount = #p.Values; 	-- display count for selections of "everything"
					else
						valueText = "LOC_SELECTION_NOTHING";
					end
				elseif(type(value) == "table") then
					local count = #value;
					if (parameter.UxHint ~= nil and parameter.UxHint == "InvertSelection") then
						if(count == 0) then
							valueText = "LOC_SELECTION_EVERYTHING";
							valueAmount = #p.Values; 	-- display count for selections of "everything"
						elseif(count == #p.Values) then
							valueText = "LOC_SELECTION_NOTHING";
						else
							valueText = "LOC_SELECTION_CUSTOM";
							valueAmount = #p.Values - count;
						end
					else
						if(count == 0) then
							valueText = "LOC_SELECTION_NOTHING";
						elseif(count == #p.Values) then
							valueText = "LOC_SELECTION_EVERYTHING";
							valueAmount = #p.Values; 	-- display count for selections of "everything"
						else
							valueText = "LOC_SELECTION_CUSTOM";
							valueAmount = count;
						end
					end
				end
			end

			-- if(cache.ValueText ~= valueText) or (cache.ValueAmount ~= valueAmount) or (cache.PriorityAmount ~= priorityAmount) then
			-- 	local button = c.Button;
			-- 	valueText = string.format("%s %d of %d%s", Locale.Lookup("LOC_PICKER_SELECTED_TEXT"), valueAmount, #p.Values, priorityText);
			-- 	button:LocalizeAndSetText(valueText);
			-- 	cache.ValueText = valueText;
			-- 	cache.ValueAmount = valueAmount;
			-- 	cache.PriorityAmount = priorityAmount;
			-- 	button:SetToolTipString(parameter.Description .. UpdateButtonToolTip(parameterId)); 	-- update button tooltip text
			-- end
			if(cache.ValueText ~= valueText) or (cache.ValueAmount ~= valueAmount) then
				local button = c.Button;			
				button:LocalizeAndSetText(valueText, valueAmount);
				cache.ValueText = valueText;
				cache.ValueAmount = valueAmount;
				-- button:SetToolTipString(parameter.Description .. UpdateButtonToolTip(parameterId)); 	-- update button tooltip text
				button:SetToolTipString(parameter.Description .. ECFE.Content.Tooltips[GameConfiguration.GetValue("RULESET")][parameterId]);		-- update button tooltip text
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
	end commonfrontend.lua configuration script
=========================================================================== ]]
