--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedmods.lua configuration script
	this file is a wrapper for the (Enhanced)Mods context
=========================================================================== ]]
print("[i]: Enhanced Community FrontEnd v2 (2024-05-02): Loading EnhancedMods.lua UI implementation script . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported Mods.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) Mods_
			(B) mods_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
print("[+]: Including Mods.lua from last imported source . . .");
include("Mods");
print("[+]: Including any imported files matching pattern 'Mods_' . . .");
include("Mods_", true);
print("[+]: Including any imported files matching pattern 'mods_' . . .");
include("mods_", true);

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[i]: Finished loading EnhancedMods.lua UI implementation script, proceeding . . .");

--[[ =========================================================================
	end enhancedmods.lua configuration script
=========================================================================== ]]
