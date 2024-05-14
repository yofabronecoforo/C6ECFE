--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedstagingroom.lua configuration script
	this file is a wrapper for the (Enhanced)StagingRoom context
=========================================================================== ]]
print("[i]: Loading EnhancedStagingRoom.lua UI wrapper . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported StagingRoom.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) StagingRoom_
			(B) stagingroom_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including StagingRoom.lua from last imported source . . .");
include("StagingRoom");
print("[i]: Including any imported files matching pattern '{S|s}taging{R|r}oom_*.lua' . . .");
include("StagingRoom_", true);
include("stagingroom_", true);

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedStagingRoom.lua UI wrapper.");

--[[ =========================================================================
	end enhancedstagingroom.lua configuration script
=========================================================================== ]]
