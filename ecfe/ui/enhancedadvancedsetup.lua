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
		(3) ECFE modifications to the GameSetupLogic.lua script that apply to both this context and the (Enhanced)HostGame context
		(4) any additional modifications to the AdvancedSetup.lua script
	any new ECFE modifications to AdvancedSetup, or overrides of existing code, should load after all of the above
		see the OnShow() override below for an example
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v1 (2024-01-02)");
print("[+]: Loading EnhancedAdvancedSetup.lua . . .");

--[[ =========================================================================
	include necessary original or modified file(s) here
=========================================================================== ]]
include("commonfrontend");
print("[+]: Loading last imported AdvancedSetup.lua . . .");
include("AdvancedSetup");
local sAdvancedSetupSource = g_bIsEnabledYnAMP and "YnAMP" or "UI/FrontEnd/ or last imported source";
print(string.format("[i]: Finished loading AdvancedSetup.lua from %s, proceeding . . .", sAdvancedSetupSource));
include("enhancedgamesetuplogic");
if not g_bIsEnabledYnAMP then 
	include("AdvancedSetup_", true);
	-- include("advancedsetup_", true);
end
include("advancedsetup_", true);

--[[ =========================================================================
	
=========================================================================== ]]
Pre_ECFE_RefreshPlayerSlots = RefreshPlayerSlots;
function RefreshPlayerSlots()
	Pre_ECFE_RefreshPlayerSlots();
	local player_ids = GameConfiguration.GetParticipatingPlayerIDs();
	Controls.MajorPlayerCount:SetText(Locale.Lookup("LOC_PLAYERS") .. ": " .. #player_ids);
end

--[[ =========================================================================
	OVERRIDE: refresh active content tooltips and call original OnShow()
=========================================================================== ]]
Pre_ECFE_OnShow = OnShow;
function OnShow()
	if not g_bIsEnabledYnAMP then 	-- hide YnAMP buttons if it is not enabled
		Controls.LoadDataYnAMP:SetHide(true);
		Controls.IgnoreWarning:SetHide(true);
	else 
		Controls.LoadDataYnAMP:SetHide(false);
		Controls.IgnoreWarning:SetHide(false);
	end
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
print("[i]: Finished loading EnhancedAdvancedSetup.lua, proceeding . . .");

--[[ =========================================================================
	end enhancedadvancedsetup.lua configuration script
=========================================================================== ]]
