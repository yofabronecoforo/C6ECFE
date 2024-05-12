--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedmainmenu.lua configuration script
	this file is a wrapper for the (Enhanced)MainMenu context
=========================================================================== ]]
print("[i]: Loading EnhancedMainMenu.lua UI wrapper . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported MainMenu.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) MainMenu_
			(B) mainmenu_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including MainMenu.lua from last imported source . . .");
include("MainMenu");
include("MainMenu_", true);
include("mainmenu_", true);

--[[ =========================================================================
	reset version string
=========================================================================== ]]
Controls.VersionLabel:SetText(ECFE.GetMainMenuVersionString(ECFE.Content.Version));

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedMainMenu.lua UI wrapper.");

--[[ =========================================================================
	end enhancedmainmenu.lua configuration script
=========================================================================== ]]
