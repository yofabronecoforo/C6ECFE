--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
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
	OVERRIDE: the various picker drivers have been condensed into CreatePickerDriverByParameter()
    these drivers are preserved but are no longer required, nor is the original GameParameters_UI_CreateParameterDriver()
	the original pickers are found in AdvancedSetup and HostGame, but this is going here to avoid duplicating code
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
	OVERRIDE: call original OnShutdown() and remove LuaEvent listeners for the modified Goody Hut and Natural Wonder pickers
=========================================================================== ]]
-- Pre_ECFE_OnShutdown = OnShutdown;
-- function OnShutdown() 
-- 	Pre_ECFE_OnShutdown();
--     LuaEvents.GoodyHutPicker_SetParameterValues.Remove(OnSetParameterValues);         -- EGHV
-- 	LuaEvents.NaturalWonderPicker_SetParameterValues.Remove(OnSetParameterValues);    -- ENWS
-- end

--[[ =========================================================================
	reset context pointer handlers with modified functions
=========================================================================== ]]
-- ContextPtr:SetShutdown( OnShutdown );

--[[ =========================================================================
	add new LuaEvent listeners for the modified Goody Hut and Natural Wonder pickers
=========================================================================== ]]
-- LuaEvents.GoodyHutPicker_SetParameterValues.Add(OnSetParameterValues);         -- EGHV
-- LuaEvents.NaturalWonderPicker_SetParameterValues.Add(OnSetParameterValues);    -- ENWS

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
