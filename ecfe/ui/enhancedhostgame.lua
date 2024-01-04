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
		(3) any present additional modifications to the HostGame.lua script
		(4) ECFE modifications to the GameSetupLogic.lua script that apply to both this context and the (Enhanced)AdvancedSetup context
		(5) any present additional modifications to the GameSetupLogic.lua script
	any new ECFE modifications to HostGame, or overrides of existing code, should load after all of the above
		see the OnShow() override below for an example
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v1 (2024-01-02)");
print("[+]: Loading EnhancedHostGame.lua . . .");

--[[ =========================================================================
	include necessary original or modified file(s) here
=========================================================================== ]]
-- print("[+]: Including new common frontend components . . .");
include("commonfrontend");
-- print("[i]: Common frontend components successfully included; proceeding . . .");
print("[+]: Loading last imported HostGame.lua . . .");
include("HostGame");
print("[i]: Finished loading HostGame.lua from UI/FrontEnd/Multiplayer/ or last imported source; proceeding . . .");
-- print("[+]: Including any imported HostGame_*.lua file(s) . . .");
include("HostGame_", true);
include("hostgame_", true);
-- print("[i]: Imported HostGame_*.lua file(s) successfully included; proceeding . . .");
-- print("[+]: Including ECFE modifications to GameSetupLogic . . .");
include("enhancedgamesetuplogic");
-- print("[i]: ECFE modifications to GameSetupLogic successfully included; proceeding . . .");
-- print("[+]: Including any imported GameSetupLogic_*.lua file(s) . . .");
include("GameSetupLogic_", true);
include("gamesetuplogic_", true);
-- print("[i]: Imported GameSetupLogic_*.lua file(s) successfully included; proceeding . . .");

--[[ =========================================================================
	OVERRIDE: refresh active content tooltips and call original OnShow()
=========================================================================== ]]
BASE_OnShow = (BASE_OnShow ~= nil) and BASE_OnShow or OnShow;
function OnShow() 
    RefreshActiveContentTooltips();
    BASE_OnShow();
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
