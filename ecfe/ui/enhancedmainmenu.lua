--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedmainmenu.lua configuration script
	this file is a wrapper for the (Enhanced)MainMenu context
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v2 (2024-05-02): Loading EnhancedMainMenu.lua UI implementation script . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported MainMenu.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) MainMenu_
			(B) mainmenu_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
print("[+]: Including MainMenu.lua from last imported source . . .");
include("MainMenu");
print("[+]: Including any imported files matching pattern 'MainMenu_' . . .");
include("MainMenu_", true);
print("[+]: Including any imported files matching pattern 'mainmenu_' . . .");
include("mainmenu_", true);

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[i]: Finished loading EnhancedMainMenu.lua UI implementation script, proceeding . . .");

--[[ =========================================================================
	end enhancedmainmenu.lua configuration script
=========================================================================== ]]
