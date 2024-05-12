--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin enhancedmods.lua configuration script
	this file is a wrapper for the (Enhanced)Mods context
=========================================================================== ]]
print("[i]: Loading EnhancedMods.lua UI wrapper . . .");

--[[ =========================================================================
	here is where the wrapper magic happens; in order, load the following: 
		(I) the last imported Mods.lua UI implementation script
		(II) the contents of any files matching these patterns:
			(A) Mods_
			(B) mods_
	this should catch all changes to this context provided by ECFE and other mods that utilize this framework
=========================================================================== ]]
include("commonfrontend");
print("[+]: Including Mods.lua from last imported source . . .");
include("Mods");
print("[i]: Including any imported files matching pattern '{M|m}ods_*.lua' . . .");
include("Mods_", true);
include("mods_", true);

--[[ =========================================================================
	
=========================================================================== ]]
Pre_ECFE_HandleExitRequest = HandleExitRequest;
function HandleExitRequest() 
	Pre_ECFE_HandleExitRequest();
	local installed = ECFE.GetInstalledMods();
	if #installed ~= #ECFE.Content.Installed then 
		print(string.format("[!]: Installed content count has changed from %d item%s; queueing content refresh.", #ECFE.Content.Installed, (#ECFE.Content.Installed ~= 1) and "s" or ""));
		ECFE.Content = ECFE.RefreshActiveContent();
		return;
	else 
		for _, mod in ipairs(installed) do 
			local modWasInstalled = ECFE.Content.IsInstalled[mod.Id] or false;
			if not modWasInstalled then 
				print(string.format("[!]: Item %s was not previously installed; queueing content refresh.", mod.Id));
				ECFE.Content = ECFE.RefreshActiveContent();
				return;
			end
		end
		for _, mod in ipairs(ECFE.Content.Installed) do 
			local modIsInstalled = Modding.IsModInstalled(mod.Id);
			if not modIsInstalled then 
				print(string.format("[!]: Item %s has been removed; queueing content refresh.", mod.Id));
				ECFE.Content = ECFE.RefreshActiveContent();
				return;
			end
		end
	end
	local enabled = ECFE.GetEnabledMods();
	if #enabled ~= #ECFE.Content.Enabled then 
		print(string.format("[!]: Enabled content count has changed from %d item%s; queueing content refresh.", #ECFE.Content.Enabled, (#ECFE.Content.Enabled ~= 1) and "s" or ""));
		ECFE.Content = ECFE.RefreshActiveContent();
		return;
	else 
		for _, mod in ipairs(enabled) do 
			local modWasEnabled = ECFE.Content.IsEnabled[mod.Id] or false;
			if not modWasEnabled then 
				print(string.format("[!]: Item %s was not previously enabled; queueing content refresh.", mod.Id));
				ECFE.Content = ECFE.RefreshActiveContent();
				return;
			end
		end
		for _, mod in ipairs(ECFE.Content.Enabled) do 
			local modIsEnabled = Modding.IsModEnabled(mod.Id);
			if not modIsEnabled then 
				print(string.format("[!]: Item %s has been disabled; queueing content refresh.", mod.Id));
				ECFE.Content = ECFE.RefreshActiveContent();
				return;
			end
		end
	end
	print("[i]: No changes to installed or enabled content detected.");
end

--[[ =========================================================================
	log successful completed loading of this component
=========================================================================== ]]
print("[!]: Finished loading EnhancedMods.lua UI wrapper.");

--[[ =========================================================================
	end enhancedmods.lua configuration script
=========================================================================== ]]
