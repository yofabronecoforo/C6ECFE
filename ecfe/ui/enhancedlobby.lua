--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 yofabronecoforo
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedlobby.lua configuration script
	this file is a wrapper for the (Enhanced)Lobby context
=========================================================================== ]]
print("[i]: Loading EnhancedLobby.lua UI wrapper . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported Lobby.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) Lobby_
			(B) lobby_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including Lobby.lua from last imported source . . .");
include("Lobby");
print("[i]: Including any imported files matching pattern '{L|l}obby_*.lua' . . .");
include("Lobby_", true);
include("lobby_", true);

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedLobby.lua UI wrapper.");

--[[ =========================================================================
	end enhancedlobby.lua configuration script
=========================================================================== ]]
