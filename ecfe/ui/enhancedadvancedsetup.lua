--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedadvancedsetup.lua configuration script
	this file is a wrapper for the (Enhanced)AdvancedSetup context
=========================================================================== ]]
print("[i]: Loading EnhancedAdvancedSetup.lua UI wrapper . . .");

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
-- Better FrontEnd (UI) compatibility
if ECFE.Content.BFE.IsEnabled then 
	include("AdvancedSetupBFE");
	ContextPtr:LookUpControl("MainWindow"):SetHide(true);
else 
	include("AdvancedSetup");
end
print("[i]: Including any imported files matching pattern '{A|a}dvanced{S|s}setup_*.lua' . . .");
-- ignore the directive to include imported files matching the AdvancedSetup_* pattern if YnAMP is enabled, as it contains its own directive to do this
if not ECFE.Content.YNAMP.IsEnabled then 
	include("AdvancedSetup_", true);
end
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
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedAdvancedSetup.lua UI wrapper.");

--[[ =========================================================================
	end enhancedadvancedsetup.lua configuration script
=========================================================================== ]]
