[h1]Enhanced Community FrontEnd (ECFE) for Civilization VI[/h1]

A mod which allows interoperation of disparate Frontend mods.

Of major note, ECFE allows multiple mods to make targeted changes to Frontend context script files, which allows mods that provide wholesale replacements to one or more Frontend scripts to work with other mods that only need to add to or replace small(er) portions of the same scripts.

What does this mean? To a player, not much. ECFE alone changes very little that affects game setup, and nothing that affects gameplay. To a mod developer, though, ECFE allows fine control over which existing files your mod must alter. For example, if your mod is named
[code]YourMod[/code]
and it requires changes to the script
[code]AdvancedSetup.lua[/code]
instead of providing a modified version of that file which may break compatibility with other mods, you can instead make ECFE a dependency of your mod, and put those changes in a file named
[code]AdvancedSetup_YourMod.lua[/code]
which will be automatically loaded by ECFE with no further action required. This provides the changes you need, while preserving the original script file.

Other mods in the author's "Enhanced" series have been redesigned with the above in mind, and now depend upon ECFE; this dependency will be noted in the individual mods' README if it applies.

Some limitations apply; please refer to the project's [url=https://github.com/zzragnar0kzz/C6ECFE#readme]README file[/url] for these and more comprehensive details. This file is also included with ECFE, and can be found where it is installed.

New Frontend and Ingame text fully localized in the following languages:
[list]
[*]English (en_US)
[*]Spanish (es_ES)
[*]French (fr_FR)
[/list]

ECFE is compatible with YnAMP.

Prefer a manual installation? Wish to contribute? [url=https://github.com/zzragnar0kzz/C6ECFE]Visit ECFE on Github.[/url]
