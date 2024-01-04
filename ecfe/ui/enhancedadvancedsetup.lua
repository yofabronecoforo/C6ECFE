--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedadvancedsetup.lua configuration script
	this file is a wrapper for the EnhancedAdvancedSetup context
	its job is to load, in order: 
		(1) new common frontend components
		(2) the last imported AdvancedSetup.lua script
		(3) any present additional modifications to the AdvancedSetup.lua script
		(4) ECFE modifications to the GameSetupLogic.lua script that apply to both this context and the (Enhanced)HostGame context
		(5) any present additional modifications to the GameSetupLogic.lua script
	any new ECFE modifications to AdvancedSetup, or overrides of existing code, should load after all of the above
		see the OnShow() override below for an example
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v1 (2024-01-02)");
print("[+]: Loading EnhancedAdvancedSetup.lua . . .");

--[[ =========================================================================
	include necessary original or modified file(s) here
=========================================================================== ]]
-- print("[+]: Including new common frontend components . . .");
include("commonfrontend");
-- print("[i]: Common frontend components successfully included; proceeding . . .");
print("[+]: Loading last imported AdvancedSetup.lua . . .");
include("AdvancedSetup");
local sAdvancedSetupSource = g_bIsEnabledYnAMP and "YnAMP" or "UI/FrontEnd/ or last imported source";
print(string.format("[i]: Finished loading AdvancedSetup.lua from %s, proceeding . . .", sAdvancedSetupSource));
-- if g_bIsEnabledYnAMP then 
-- 	print("[i]: YnAMP AdvancedSetup.lua and any imported AdvancedSetup_*.lua file(s) successfully included; proceeding . . .");
-- else 
-- 	print("[i]: AdvancedSetup.lua successfully included from UI/FrontEnd/ or last imported source; proceeding . . .");
-- end
if not g_bIsEnabledYnAMP then 
	-- print("[+]: Including any imported AdvancedSetup_*.lua file(s) . . .");
	include("AdvancedSetup_", true);
	include("advancedsetup_", true);
	-- print("[i]: Imported AdvancedSetup_*.lua file(s) successfully included; proceeding . . .");
end
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
	if not g_bIsEnabledYnAMP then 	-- hide YnAMP buttons if it is not enabled
		Controls.LoadDataYnAMP:SetHide(true);
		Controls.IgnoreWarning:SetHide(true);
	else 
		Controls.LoadDataYnAMP:SetHide(false);
		Controls.IgnoreWarning:SetHide(false);
	end
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
print("[i]: Finished loading EnhancedAdvancedSetup.lua, proceeding . . .");

--[[ =========================================================================
	end enhancedadvancedsetup.lua configuration script
=========================================================================== ]]
