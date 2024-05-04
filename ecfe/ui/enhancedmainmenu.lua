--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedmainmenu.lua configuration script
	this file is a wrapper for the (Enhanced)MainMenu context
=========================================================================== ]]
print("[i]: Loading EnhancedMainMenu UI script . . .");

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
-- print("[+]: Including any imported files matching pattern 'MainMenu_*.lua' . . .");
include("MainMenu_", true);
-- print("[+]: Including any imported files matching pattern 'mainmenu_*.lua' . . .");
include("mainmenu_", true);

--[[ =========================================================================
	reset version string
=========================================================================== ]]
Controls.VersionLabel:SetText(ExposedMembers.MainMenuVersionString and ExposedMembers.MainMenuVersionString or string.format("Game: %s", tostring(UI.GetAppVersion())));

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedMainMenu UI script, proceeding . . .");

--[[ =========================================================================
	end enhancedmainmenu.lua configuration script
=========================================================================== ]]
