--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedhostgame.lua configuration script
	this file is a wrapper for the (Enhanced)HostGame context
=========================================================================== ]]
print("[i]: Loading EnhancedHostGame.lua UI wrapper . . .");

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
print("[i]: Including any imported files matching pattern '{H|h}ost{G|g}ame_*.lua' . . .");
include("HostGame_", true);
include("hostgame_", true);
include("enhancedgamesetuplogic");

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedHostGame.lua UI wrapper.");

--[[ =========================================================================
	end enhancedhostgame.lua configuration script
=========================================================================== ]]
