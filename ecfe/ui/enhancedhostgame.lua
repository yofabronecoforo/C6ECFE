--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedhostgame.lua configuration script
	this file is a wrapper for the EnhancedHostGame context
	its job is to load, in order: 
		(1) new common frontend components
		(2) the last imported HostGame.lua script
		(3) ECFE modifications to the GameSetupLogic.lua script that apply to both this context and the (Enhanced)AdvancedSetup context
		(4) any additional modifications to the HostGame.lua script
	any new ECFE modifications to HostGame, or overrides of existing code, should load after all of the above
		see the OnShow() override below for an example
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v1 (2024-01-02)");
print("[+]: Loading EnhancedHostGame.lua . . .");

--[[ =========================================================================
	include necessary original or modified file(s) here
=========================================================================== ]]
include("commonfrontend");
print("[+]: Loading last imported HostGame.lua . . .");
include("HostGame");
print("[i]: Finished loading HostGame.lua from UI/FrontEnd/Multiplayer/ or last imported source; proceeding . . .");
include("enhancedgamesetuplogic");
include("HostGame_", true);
include("hostgame_", true);

--[[ =========================================================================
	OVERRIDE: refresh active content tooltips and call original OnShow()
=========================================================================== ]]
Pre_ECFE_OnShow = OnShow;
function OnShow() 
    RefreshActiveContentTooltips();
	Pre_ECFE_OnShow();
end

--[[ =========================================================================
	reset context pointer handlers with modified functions
=========================================================================== ]]
ContextPtr:SetShowHandler( OnShow );

--[[ =========================================================================
	log successful loading of this component
=========================================================================== ]]
print("[i]: Finished loading EnhancedHostGame.lua, proceeding . . .");

--[[ =========================================================================
	end enhancedhostgame.lua configuration script
=========================================================================== ]]
