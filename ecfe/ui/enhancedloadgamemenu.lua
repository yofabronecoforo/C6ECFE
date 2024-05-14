--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedloadgamemenu.lua configuration script
	this file is a wrapper for the (Enhanced)LoadGameMenu context
=========================================================================== ]]
print("[i]: Loading EnhancedLoadGameMenu.lua UI wrapper . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported LoadGameMenu.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) LoadGameMenu_
			(B) loadgamemenu_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including LoadGameMenu.lua from last imported source . . .");
include("LoadGameMenu");
print("[i]: Including any imported files matching pattern '{L|l}oad{G|g}ame{M|m}enu_*.lua' . . .");
include("LoadGameMenu_", true);
include("loadgamemenu_", true);

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedLoadGameMenu.lua UI wrapper.");

--[[ =========================================================================
	end enhancedloadgamemenu.lua configuration script
=========================================================================== ]]
