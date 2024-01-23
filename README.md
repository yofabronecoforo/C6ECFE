# Enhanced Community FrontEnd (ECFE) for Civilization VI
A mod which allows interoperation of disparate Frontend mods.

# Overview
Of major note, ECFE allows multiple mods to make targeted changes to Frontend context script files, which allows mods that provide wholesale replacements to one or more Frontend scripts to work with other mods that only need to add to or replace small(er) portions of the same scripts.

What does this mean? To a player, not much. ECFE alone changes very little that affects game setup, and nothing that affects gameplay. To a mod developer, though, ECFE allows fine control over which existing files your mod must alter. For example, if your mod is named `YourMod`, and it requires changes to the `AdvancedSetup.lua` script, instead of providing a modified version of that file which may break compatibility with other mods, you can instead make ECFE a dependency of your mod, and put those changes in a file named `AdvancedSetup_YourMod.lua`, which will be automatically loaded by ECFE with no further action required. This provides the changes you need, while preserving the original script file.

Other mods in the author's "Enhanced" series have been redesigned with the above in mind, and now depend upon ECFE; this dependency will be noted in the individual mods' README if it applies.

Some limitations apply; see below for these and more comprehensive details.

# Translations
New Frontend text fully localized in the following languages:
- English (en_US)
- Spanish (es_ES)
- French (fr_FR)

# Features
ECFE does nothing to alter Ingame components; it only makes cosmetic and functional changes to Frontend components. These changes are described below.

## MainMenu XML Template
ECFE replaces the `MainMenu.xml` UI template file with a custom version that modifies the filenames for the AdvancedSetup and HostGame Lua contexts as follows:
- AdvancedSetup's new filename is `enhancedadvancedsetup`
- HostGame's new filename is `enhancedhostgame`

There are no other changes to this file.

## EnhancedAdvancedSetup
The Enhanced AdvancedSetup context is implemented as two files.

### File `enhancedadvancedsetup.lua`:
This is a script wrapper for the single-player AdvancedSetup context. It consists of the following:
1. A directive to include any new components that are shared by both this context and the HostGame context.
2. A directive to include the last-imported `AdvancedSetup.lua` script, whether this is the built-in version or one provided by another mod.
3. Directives to include any imported files matching the patterns `advancedsetup_*.lua` and `gamesetuplogic_*.lua` which can contain targeted changes to existing components of, and/or entirely new components specific to, this context.
4. Minor revisions to any existing components of, and/or any entirely new minor components specific to, this context, which must be loaded after all of the preceeding changes.

### File `enhancedadvancedsetup.xml`:
This is the UI template for this context. It is essentially unchanged from the built-in `AdvancedSetup.xml` template, except for the following:
1. UI controls specific to [Yet (not) Another Maps Pack (YnAMP)](https://steamcommunity.com/sharedfiles/filedetails/?id=871861883) are provided. If YnAMP is present and enabled, and its `AdvancedSetup.lua` script was the last or only one that was imported, these controls will provide their normal functionality as defined by that script. If YnAMP is not present or is disabled, these controls will be hidden; if another mod replaces `AdvancedSetup.lua` after YnAMP replaces it, these controls will be present, but may not function as intended.
2. Lua contexts are defined for the following mods that provide customized content pickers:
    - [Enhanced Goodies and Hostile Villagers (EGHV)](https://steamcommunity.com/sharedfiles/filedetails/?id=2474051781)
    - [Enhanced Natural Wonders Selection (ENWS)](https://steamcommunity.com/sharedfiles/filedetails/?id=2273495829)
3. The compass image used by the slider parameter has been widened slightly, and the size of the font used for that parameter's value has been reduced slightly.

For each Lua context defined per (2) above, ECFE provides a dummy script file that serves only to suppress error messages in the Lua.log file when the corresponding mod is not present or is disabled.

## EnhancedHostGame
The Enhanced HostGame context is implemented as two files.

### File `enhancedhostgame.lua`:
This is a script wrapper for the multi-player HostGame context. It consists of the following:
1. A directive to include any new components that are shared by both this context and the AdvancedSetup context.
2. A directive to include the last-imported `HostGame.lua` script, whether this is the built-in version or one provided by another mod.
3. Directives to include any imported files matching the patterns `hostgame_*.lua` and `gamesetuplogic_*.lua` which can contain targeted changes to existing components of, and/or entirely new components specific to, this context.
4. Minor revisions to any existing components of, and/or any entirely new minor components specific to, this context, which must be loaded after all of the preceeding changes.

### File `enhancedhostgame.xml`:
This is the UI template for this context. It is essentially unchanged from the built-in `HostGame.xml` template, except for the following:
1. Lua contexts are defined for the following mods that provide customized content pickers:
    - [Enhanced Goodies and Hostile Villagers (EGHV)](https://steamcommunity.com/sharedfiles/filedetails/?id=2474051781)
    - [Enhanced Natural Wonders Selection (ENWS)](https://steamcommunity.com/sharedfiles/filedetails/?id=2273495829)
2. The compass image used by the slider parameter has been widened slightly, and the size of the font used for that parameter's value has been reduced slightly.

For each Lua context defined per (1) above, ECFE provides a dummy script file that serves only to suppress error messages in the Lua.log file when the corresponding mod is not present or is disabled.

## New Picker Button Text
ECFE modifies the text of picker buttons to reflect the number of selected items and the number of available items at all times.

## New Picker Button Tooltip Text
ECFE modifies the tooltip text of picker buttons to reflect the sources of available content if such sources are recognized by ECFE. These sources will vary depending on the particular picker button and will dynamically update when a recognized source is enabled or disabled via the mod manager.

## CityStatePicker XML Template:
ECFE makes cosmetic changes to the `CityStatePicker.xml` file so that its slider compass and font size align with other ECFE changes.

# Limitations 
ECFE simulates the behavior of the Ingame "ReplaceUIScript" modinfo tag, which does nothing in the Frontend. This removes the need to overwrite the aforementioned original scripts with new versions containing any necessary changes, and allows for such changes to be placed in separate files that are loaded as needed after the existing scripts are loaded. When care is exercised, this allows multiple mods to make precision changes to these scripts and interoperate with one another. Crucially, since ECFE's load order generally makes it one of the last mods loaded, it also allows ECFE to function alongside other mods that **DO** replace the original scripts, without resorting to a Frankenstein's monster of a single script containing changes from different mods. This functionality has been tested with YnAMP, but with some exceptions, it *should* work with any mod that replaces the AdvancedSetup, GameSetupLogic, and/or HostGame script(s).

ECFE cannot make the game retain multiple versions of a script with the same name, so only the last imported version of each of these files will be used. This means other mods that overwrite one or more of these scripts will likely continue to conflict with each other.

Mods that make extensive changes to the AdvancedSetup and/or HostGame XML templates are not supported by ECFE. Notably, this applies to Sukritact's Civ Selection Screen.

# Compatibility
ECFE is compatible with single- and multi-player setups.

ECFE is compatible with all official rulesets.

As it does not directly affect any Ingame content, ECFE *should* be compatible with any game mode, whether official or provided by a mod. However, this has not been tested.

## Mod Compatibility
ECFE was developed with the following mods enabled, and is thus known to be compatible with them:
- Better Civilization Icons
- Better Coastal Cities and Water Tiles
- Better Report Screen (UI)
- Civilizations Expanded
- CIVITAS City-States
- Colorized Historic Moments
- Enhanced Mod Manager
- Extended Policy Cards
- More Barbarian EXP
- More Maritime: Seaside Sectors
- Ophidy's Start by Wonders
- Real Great People
- Religion Expanded
- Removable Districts
- Sailor Cat's Wondrous Goody Huts
- Tomatekh's Historical Religions
- Yet (not) Another Maps Pack

ECFE is compatible with mods that replace the AdvancedSetup, GameSetupLogic, and HostGame Frontend Lua context script files. See "Limitations" above for more details.

The dynamic content tooltip feature will only apply to pickers that are recognized by ECFE. If you have such a picker that you would like to see supported, please make a request.

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
- `MainMenu.xml`
- `CityStatePicker.xml`

ECFE adds the following new Frontend context file(s):
- `CommonFrontend.lua`
- `EnhancedAdvancedSetup.lua` and `EnhancedAdvancedSetup.xml`
- `EnhancedGameSetupLogic.lua`
- `EnhancedHostGame.lua` and `EnhancedHostGame.xml`

If your mod replaces any of these files, compatibility issues **WILL** arise.
