--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedmods.lua configuration script
	this file is a wrapper for the (Enhanced)Mods context
=========================================================================== ]]
print("[i]: Loading EnhancedMods UI script . . .");

--[[ =========================================================================
	pre-init
=========================================================================== ]]
ExposedMembers.ContentHandles = ExposedMembers.ContentHandles or {};
-- ContentHandles = ExposedMembers.ContentHandles;
local tMods = Modding.GetInstalledMods();
if (tMods and #tMods > 0) then 
	for _, mod in ipairs(tMods) do 
		-- print(mod.Id);
		ExposedMembers.ContentHandles[mod.Id] = mod.Handle;
	end
end
tMods = nil;

ExposedMembers.RecognizedContent = ExposedMembers.RecognizedContent or {};
-- RecognizedContent = ExposedMembers.RecognizedContent;
if (#ExposedMembers.RecognizedContent < 1) then 
	local tContent = DB.ConfigurationQuery("SELECT DISTINCT * from ContentFlags");
	if tContent and #tContent > 0 then 
		for _, mod in ipairs(tContent) do 
			ExposedMembers.RecognizedContent[mod.Id] = ExposedMembers.RecognizedContent[mod.Id] or {};
			ExposedMembers.RecognizedContent[mod.Id].IsEnabled = (Modding.IsModInstalled(mod.GUID) and Modding.IsModEnabled(mod.GUID));
			ExposedMembers.RecognizedContent[mod.Id].Version =  Modding.GetModProperty(ExposedMembers.ContentHandles[mod.GUID], "Version") or nil;
			-- print(string.format("%s %s %s Version %s %s", tostring(ExposedMembers.RecognizedContent[mod.Id].IsEnabled), mod.Id, mod.Name, tostring(ExposedMembers.RecognizedContent[mod.Id].Version), mod.GUID));
		end
	end
end
ExposedMembers.MainMenuVersionString = string.format("Game: %s%s%s", tostring(UI.GetAppVersion()), ExposedMembers.RecognizedContent.ECFE.IsEnabled and string.format("  |  [COLOR:Green]ECFE: %s[ENDCOLOR]", ExposedMembers.RecognizedContent.ECFE.Version) or "", ExposedMembers.RecognizedContent.MPH.IsEnabled and string.format("  |  [COLOR_LIGHTBLUE]MPH: %s[ENDCOLOR]", ExposedMembers.RecognizedContent.MPH.Version) or "");

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
-- print("[+]: Including any imported files matching pattern 'Mods_*.lua' . . .");
include("Mods_", true);
-- print("[+]: Including any imported files matching pattern 'mods_*.lua' . . .");
include("mods_", true);

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedMods UI script, proceeding . . .");

--[[ =========================================================================
	end enhancedmods.lua configuration script
=========================================================================== ]]
