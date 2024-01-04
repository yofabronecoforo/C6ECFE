--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedgamesetuplogic.lua configuration script
=========================================================================== ]]
print("[+]: Loading EnhancedGameSetupLogic.lua . . .");

--[[ =========================================================================
	OVERRIDE: the various picker drivers have been condensed into CreatePickerDriverByParameter()
    these drivers are preserved but are no longer required, nor is the original GameParameters_UI_CreateParameterDriver()
	the original pickers are found in AdvancedSetup and HostGame, but this is going here to avoid duplicating code
=========================================================================== ]]
function GameParameters_UI_CreateParameterDriver(o, parameter, ...) 
	local parameterId = parameter.ParameterId;
	if(parameterId == "CityStates" or parameterId == "LeaderPool1" or parameterId == "LeaderPool2" or (parameterId == "GoodyHutConfig" and g_bIsEnabledEGHV) or (parameterId == "NaturalWonders" and g_bIsEnabledENWS)) then 
		if GameConfiguration.IsWorldBuilderEditor() then
			return nil;
		end
		return CreatePickerDriverByParameter(o, parameter);
	elseif(parameter.Array) then								-- fallback for generic multi-select window; no WorldBuilder check
		return CreatePickerDriverByParameter(o, parameter);
	else
		return GameParameters_UI_DefaultCreateParameterDriver(o, parameter, ...);
	end
end

--[[ =========================================================================
	log successful loading of this component
=========================================================================== ]]
print("[i]: Finished loading EnhancedGameSetupLogic.lua, proceeding . . .");

--[[ =========================================================================
	end enhancedgamesetuplogic.lua configuration script
=========================================================================== ]]
