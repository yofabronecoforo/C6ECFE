--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedhostgame.lua configuration script
	this file is a wrapper for the (Enhanced)HostGame context
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v2 (2024-05-02): Loading EnhancedHostGame.lua UI implementation script . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following:
		(I) new frontend components common to both this context and (Enhanced)AdvancedSetup
		(II) the last imported HostGame.lua UI implementation script
		(III) any files matching these patterns:
			(A) HostGame_
			(B) hostgame_
		(IV) the EnhancedGameSetupLogic.lua wrapper
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including HostGame.lua from last imported source . . .");
include("HostGame");
print("[+]: Including any imported files matching pattern 'HostGame_' . . .");
include("HostGame_", true);
print("[+]: Including any imported files matching pattern 'hostgame_' . . .");
include("hostgame_", true);
include("enhancedgamesetuplogic");

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
print("[i]: Finished loading EnhancedHostGame.lua UI implementation script, proceeding . . .");

--[[ =========================================================================
	end enhancedhostgame.lua configuration script
=========================================================================== ]]
