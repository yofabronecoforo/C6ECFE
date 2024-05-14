--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedsavegamemenu.lua configuration script
	this file is a wrapper for the (Enhanced)SaveGameMenu context
=========================================================================== ]]
print("[i]: Loading EnhancedSaveGameMenu.lua UI wrapper . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported SaveGameMenu.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) SaveGameMenu_
			(B) savegamemenu_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including SaveGameMenu.lua from last imported source . . .");
include("SaveGameMenu");
print("[i]: Including any imported files matching pattern '{S|s}ave{G|g}ame{M|m}enu_*.lua' . . .");
include("SaveGameMenu_", true);
include("savegamemenu_", true);

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedSaveGameMenu.lua UI wrapper.");

--[[ =========================================================================
	end enhancedsavegamemenu.lua configuration script
=========================================================================== ]]
