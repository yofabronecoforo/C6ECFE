--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedadvancedsetup.lua configuration script
	this file is a wrapper for the (Enhanced)AdvancedSetup context
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v2 (2024-05-02): Loading EnhancedAdvancedSetup.lua UI implementation script . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following:
		(I) new frontend components common to both this context and (Enhanced)HostGame
		(II) the last imported AdvancedSetup.lua UI implementation script
		(III) any files matching these patterns:
			(A) AdvancedSetup_
			(B) advancedsetup_
		(IV) the EnhancedGameSetupLogic.lua wrapper
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including AdvancedSetup.lua from last imported source . . .");
include("AdvancedSetup");
-- ignore the directive to include imported files matching the AdvancedSetup_ pattern if YnAMP is enabled, as it contains its own directive to do this
if not g_bIsEnabledYnAMP then 
	print("[+]: Including any imported files matching pattern 'AdvancedSetup_' . . .");
	include("AdvancedSetup_", true);
end
print("[+]: Including any imported files matching pattern 'advancedsetup_' . . .");
include("advancedsetup_", true);
include("enhancedgamesetuplogic");

--[[ =========================================================================
	
=========================================================================== ]]
-- Pre_ECFE_RefreshPlayerSlots = RefreshPlayerSlots;
-- function RefreshPlayerSlots()
-- 	Pre_ECFE_RefreshPlayerSlots();
-- 	local player_ids = GameConfiguration.GetParticipatingPlayerIDs();
-- 	Controls.MajorPlayerCount:SetText(Locale.Lookup("LOC_PLAYERS") .. ": " .. #player_ids);
-- end

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
	log successful completed loading of this component
=========================================================================== ]]
print("[i]: Finished loading EnhancedAdvancedSetup.lua UI implementation script, proceeding . . .");

--[[ =========================================================================
	end enhancedadvancedsetup.lua configuration script
=========================================================================== ]]
