--[[ =========================================================================
	C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
	All rights reserved
=========================================================================== ]]

--[[ =========================================================================
	begin exposedmembers.lua configuration script
	this file contains new components that are immediately available to any context via the ExposedMembers table
	it should be included by any contexts that will use these components before any other files that are to be included
=========================================================================== ]]
print("[i]: Loading ExposedMembers.lua UI script . . .");

--[[ =========================================================================
	we DO want the first context that loads this file to make the declarations below
	we DON'T want every other context that loads this file to redeclare these commponents
=========================================================================== ]]
ExposedMembers.MembersDefinedAtStartup = ExposedMembers.MembersDefinedAtStartup or false;

if not ExposedMembers.MembersDefinedAtStartup then 
	print("[i]: Configuring required exposed members at startup . . .");

	ExposedMembers.StrangeThings = "Strange things are afoot at the Circle K."

	ExposedMembers.GetInstalledMods = Modding.GetInstalledMods;

	function ExposedMembers.GetMainMenuVersionString( t ) 
		local version = string.format("Game: %s", tostring(UI.GetAppVersion()));
		if not t or #t == 0 then return version; end
		for _, item in ipairs(t) do 
			if ExposedMembers.Content[item.Name].IsEnabled then 
				version = string.format("%s[NEWLINE][COLOR%s]%s: %s[ENDCOLOR]", version, (item.Name == "MPH") and "_LIGHTBLUE" or ":Green", item.Name, item.Version);
			end
		end
		return version;
	end

	function ExposedMembers.GetEnabledMods() 
		local t = {};
		for _, mod in ipairs(Modding.GetInstalledMods()) do 
			if Modding.IsModEnabled(mod.Id) then 
				t[(#t + 1)] = mod;
			end
		end
		return t;
	end

	function ExposedMembers.ParseMods( m )
		if not m or #m == 0 then return {}; end
		local t = {};
		for _, mod in ipairs(m) do 
			t[mod.Id] = true;
		end
		return t;
	end

	function ExposedMembers.GetHandles( m ) 
		if not m or #m == 0 then return {}; end
		local t = {};
		for _, mod in ipairs(m) do 
			t[mod.Id] = mod.Handle;
		end
		return t;
	end

	function ExposedMembers.GetAvailableContent() 
		local installed = ExposedMembers.GetInstalledMods();
		if not installed or #installed == 0 then return nil; end
		local i = ExposedMembers.ParseMods(installed);
		local enabled = ExposedMembers.GetEnabledMods();
		if not enabled or #enabled == 0 then return nil; end
		local e = ExposedMembers.ParseMods(enabled);
		local handles = ExposedMembers.GetHandles(installed);
		return { Installed = installed, IsInstalled = i, Enabled = enabled, IsEnabled = e, Handles = handles };
	end

	function ExposedMembers.GetContentFlags() 
		local f = DB.ConfigurationQuery("SELECT DISTINCT * from ContentFlags");
		if not f or #f == 0 then return {}; end
		return f;
	end

	function ExposedMembers.GetValidContent() 
		local available = ExposedMembers.GetAvailableContent();
		if not available then return nil; end
		local flags = ExposedMembers.GetContentFlags();
		if not flags then return nil; end
		local content = { Active = {}, Version = {} };
		for _, item in ipairs(flags) do 
			item.LeaderPool1 = item.Leaders;
			item.LeaderPool2 = item.Leaders;
			item.StartWonders = item.NaturalWonders;
			local bIsEnabled = available.IsEnabled[item.Id] or false;
			if bIsEnabled then content.Active[(#content.Active + 1)] = item; end
			item.IsEnabled = bIsEnabled;
			item.Handle = available.Handles[item.Id];
			item.Version = item.Handle and Modding.GetModProperty(item.Handle, "Version") or nil;
			content[item.Name] = item;
			if item.Version then content.Version[(#content.Version + 1)] = { Name = item.Name, Version = item.Version }; end
			-- print(string.format("[+]: %-9sId %-40s%-9sVersion %s", tostring(item.IsEnabled), item.Id, item.Name, tostring(item.Version)));
		end
		content.Installed = available.Installed;
		content.IsInstalled = available.IsInstalled;
		content.Enabled = available.Enabled;
		content.IsEnabled = available.IsEnabled;
		content.Handles = available.Handles;
		content.Flags = flags;
		return content;
	end

	function ExposedMembers.RefreshActiveContent() 
		print("[i]: Refreshing available content and content flags . . .");
		local content = ExposedMembers.GetValidContent();
		if not content then 
			print(string.format("[!]: GetValidContent() returned nil. %s", ExposedMembers.StrangeThings));
			return nil;
		elseif not content.Installed or #content.Installed == 0 then 
			print("[!]: There is no installed additional content.");
			return nil;
		elseif not content.Enabled or #content.Enabled == 0 then 
			print("[!]: There is no enabled additional content.");
			return nil;
		elseif not content.Flags or #content.Flags == 0 then 
			print("[!]: There are no defined content flags.");
			return nil;
		end
		print(string.format("[!]: Found %d installed item%s (%d enabled).", #content.Installed, (#content.Installed ~= 1) and "s" or "", #content.Enabled));
		print(string.format("[!]: Found content flags for %d item%s (%d enabled).", #content.Flags, (#content.Flags ~= 1) and "s" or "", #content.Active));
		local rulesets = DB.ConfigurationQuery("SELECT DISTINCT Key2 AS 'Ruleset' FROM Parameters WHERE Array = 1");
		local parameters = DB.ConfigurationQuery("SELECT DISTINCT ParameterId FROM Parameters WHERE Array = 1");
		tooltips = ExposedMembers.GetDefaultPickerTooltipText(rulesets, parameters);
		tooltips = ExposedMembers.UpdatePickerTooltipText(content.Active, tooltips, rulesets, parameters);
		content.Tooltips = tooltips;
		return content;
	end

	function ExposedMembers.GetDefaultPickerTooltipText( rulesets, parameters ) 
		local standard = Locale.Lookup("LOC_STANDARD_TT");
		local t = {};
		for _, r in ipairs(rulesets) do 
			t[r.Ruleset] = {};
			for _, p in ipairs(parameters) do 
				t[r.Ruleset][p.ParameterId] = standard;
			end
		end
		return t;
	end

	function ExposedMembers.UpdatePickerTooltipText( content, tooltips, rulesets, parameters ) 
		print("[i]: Updating picker tooltip text to reflect active content . . .");
		if content and #content > 0 then 
			for _, item in ipairs(content) do 
				local current = Locale.Lookup(item.Tooltip);
				for _, r in ipairs(rulesets) do 
					if item[r.Ruleset] then 
						for _, p in ipairs(parameters) do 
							if item[p.ParameterId] then tooltips[r.Ruleset][p.ParameterId] = string.format("%s%s", tooltips[r.Ruleset][p.ParameterId], current); end
						end
					end
				end
			end
		end
		print(string.format("[!]: Tooltip text updated for %d picker%s", #parameters, (#parameters ~= 1) and "s" or ""));
		return tooltips;
	end

	ExposedMembers.Content = ExposedMembers.RefreshActiveContent();
	ExposedMembers.MembersDefinedAtStartup = true;
end

--[[ =========================================================================
	we DO want every context that loads this file to utilize the table below to conserve keystrokes
=========================================================================== ]]
ECFE = ExposedMembers;

--[[ =========================================================================
	include any additional modifications to ExposedMembers
=========================================================================== ]]
print("[i]: Including any imported files matching pattern '{E|e}xposed{M|m}embers_*.lua' . . .");
include("ExposedMembers_", true);
include("exposedmembers_", true);

--[[ =========================================================================
	end exposedmembers.lua configuration script
=========================================================================== ]]
