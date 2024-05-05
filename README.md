# Enhanced Community FrontEnd (ECFE) for Civilization VI
A mod which allows interoperation of disparate Frontend mods.

# Overview 
ECFE replaces several existing Frontend contexts. Replaced contexts are implemented via new Lua and XML wrapper files. These wrappers load the last-imported versions of the original files for replaced contexts, while also enabling targeted changes to these contexts by additional code contained in any of the following:
- Files whose names match any explicitly specified names (Lua and XML) or defined patterns (Lua only)
- The wrapper files themselves

What does this mean? To a player, not much. ECFE alone changes very little that affects game setup, and nothing that affects gameplay. To a mod developer, though, [ECFE allows fine(r) control](CONTEXTS.md#replacing-contexts) over exactly which existing files a mod must alter.

Other mods which rely upon ECFE behavior can explicitly define ECFE as a dependency, which will help ensure that ECFE loads before any such mods.

[Some limitations apply](#limitations). Continue reading for comprehensive details.

# Translations 
New Frontend text fully localized in the following languages:
- English (en_US)
- Spanish (es_ES)
- French (fr_FR)

# Features 
ECFE replaces the following Frontend context files:
- `FrontEnd.xml`

ECFE replaces the following Frontend contexts:
- AdvancedSetup
- HostGame
- MainMenu
- Mods

## `FrontEnd.xml` 
This UI template file is a custom version which provides the `EnhancedMainMenu` context by [modifying the LuaContext node](CONTEXTS.md#replacing-contexts) for the `MainMenu` context. There are no other differences between this file and the built-in version.

## EnhancedMainMenu 
This context replaces the MainMenu context.

This context is a parent of the following replaced contexts:
- `AdvancedSetup` --> `EnhancedAdvancedSetup`
- `HostGame` --> `EnhancedHostGame`
- `Mods` --> `EnhancedMods`

## EnhancedAdvancedSetup 
This context replaces the AdvancedSetup context.

This context is a parent of the following new contexts:
- `GoodyHutPicker` used by [Enhanced Goodies and Hostile Villagers (EGHV)](https://steamcommunity.com/sharedfiles/filedetails/?id=2474051781)
- `NaturalWondersPicker` used by [Enhanced Natural Wonders Selection (ENWS)](https://steamcommunity.com/sharedfiles/filedetails/?id=2273495829)

## EnhancedHostGame 
This context replaces the HostGame context.

This context is a parent of the following replaced contexts:
- `Mods` --> `EnhancedMods`

This context is a parent of the following new contexts:
- `GoodyHutPicker` used by [Enhanced Goodies and Hostile Villagers (EGHV)](https://steamcommunity.com/sharedfiles/filedetails/?id=2474051781)
- `NaturalWondersPicker` used by [Enhanced Natural Wonders Selection (ENWS)](https://steamcommunity.com/sharedfiles/filedetails/?id=2273495829)

## EnhancedMods 
This context replaces the Mods context.

This context is a child of the following replaced contexts:
- `AdvancedSetup` --> `EnhancedAdvancedSetup`
- `HostGame` --> `EnhancedHostGame`

## `CommonFrontend.lua` 
This file contains additions that affect both the (Enhanced)AdvancedSetup and (Enhanced)HostGame contexts, and which generally should be loaded before any other files in those contexts.

## `EnhancedGameSetupLogic.lua` 
This Lua wrapper consists of changes to the `GameSetupLogic.lua` script used by both the (Enhanced)AdvancedSetup and (Enhanced)HostGame contexts. It contains the following components:
1. Directives to include files matching the following patterns:
    - `GameSetupLogic_*.lua`
    - `gamesetuplogic_*.lua`
2. Any additional changes to `GameSetupLogic.lua` that should be loaded after the files listed above.

## New Picker Button Text 
ECFE modifies the text of picker buttons to reflect the number of selected items and the number of available items at all times.

## New Picker Button Tooltip Text 
ECFE modifies the tooltip text of picker buttons to reflect the sources of available content if such sources are recognized by ECFE. These sources will vary depending on the particular picker button and will dynamically update when a recognized source is enabled or disabled via the mod manager.

## Ingame Logging Verbosity 
Though it does not directly affect any Ingame components, ECFE does provide an option that can be used to adjust Ingame logging verbosity by mods that support it.

# Limitations 
ECFE is not a panacea. It cannot alter core game behavior, so when multiple versions of any file with the same name have been imported, the game will still only retain and use the last-imported version of that file. This means that mods which are incompatible with each other because they replace the same file(s) will continue to be incompatible with each other.

Unlike Lua, XML does not support the use of wildcards in Include nodes. ECFE is therefore unable to dynamically load XML content through the use of pattern-matching. This makes it harder, though not impossible, for multiple mods to make changes to existing controls within a given context, or to add new controls therein.

The dynamic content tooltip feature will only apply to picker types that are recognized by ECFE. Currently, these include:
- All built-in pickers (City-States, Leaders, Natural Wonders)
- Any other picker which initializes by reusing components of any of the above pickers
- The Goody Hut picker provided by Enhanced Goodies and Hostile Villagers (EGHV)
- The modified Natural Wonders Picker used by Enhanced Natural Wonders Selection (ENWS)

# Compatibility 
ECFE is compatible with single- and multi-player setups.

ECFE is compatible with all official rulesets.

As it does not directly affect any Ingame content, ECFE *should* be compatible with any game mode, whether official or provided by a mod. However, this has not been thoroughly tested.

## Known Mod Compatibility 
ECFE is compatible with other mods that replace Frontend context files, but [due to limitations](#limitations), for each context below in which files are replaced, it can only interoperate with any one of the listed mods at a time:
- AdvancedSetup:
    - Sukritact's Civ Selection Screen
    - Yet (not) Another Maps Pack
- HostGame:
    - Multiplayer Helper
- MainMenu:
    - Multiplayer Helper
- Mods
    - Enhanced Mod Manager

ECFE was developed with the following mods enabled, and is thus known to be compatible with them:
- Better Civilization Icons
- Better Coastal Cities and Water Tiles
- Better Report Screen (UI)
- Civilizations Expanded
- CIVITAS City-States
- Colorized Historic Moments
- Extended Policy Cards
- More Barbarian EXP
- More Maritime: Seaside Sectors
- Ophidy's Start by Wonders
- Real Great People
- Religion Expanded
- Removable Districts
- Sailor Cat's Wondrous Goody Huts
- Tomatekh's Historical Religions

# Installation 
ECFE can be installed via the Steam Workshop or GitHub.

## Automatic 
[Subscribe to ECFE in the Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3145434774) to automatically download and install the latest published release, and to automatically receive any updates as they are published to the Workshop.

## Manual 
Download the [latest release](https://github.com/zzragnar0kzz/C6ECFE/releases/latest) and extract it into the game's local mods folder. Alternately, clone the repository into a new folder within the game's local mods folder using your preferred tools. To update to a newer release, clone or download the latest release as described above, overwriting any existing items in the destination folder. The local mods folder varies.

### Windows 
`"$userprofile\Documents\My Games\Sid Meier's Civilization VI\Mods"`

### Linux 
`"~/.local/share/aspyr-media/Sid Meier's Civilization VI/Mods"`

-or-

`"~/.steam/steam/steamapps/compatdata/289070/pfx/drive_c/users/steamuser/Documents/My Games/Sid Meier's Civilization VI/Mods"`

Which of these is correct depends on whether you are using the native Linux client or the Windows client via Proton Experimental.

# Conflicts 
Following is a non-comprehensive list of items that may potentially cause conflicts with other content.

## Configuration Database 
ECFE adds the following custom table(s) to the game's Configuration database:
- ContentFlags

If your mod uses any similarly-named custom tables in this database, compatibility issues *MAY* arise.

## Frontend Context 
ECFE replaces the following existing Frontend context file(s):
- `FrontEnd.xml`

ECFE adds the following new Frontend context file(s):
- `EnhancedAdvancedSetup.lua` and `EnhancedAdvancedSetup.xml`
- `EnhancedHostGame.lua` and `EnhancedHostGame.xml`
- `EnhancedMainMenu.lua` and `EnhancedMainMenu.xml`
- `EnhancedMods.lua` and `EnhancedMods.xml`

ECFE adds the following new Frontend Lua script file(s):
- `CommonFrontend.lua`
- `EnhancedGameSetupLogic.lua`

If your mod replaces any of these files, compatibility issues **WILL** arise.
