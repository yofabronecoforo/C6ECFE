# Understanding Enhanced Contexts 
ECFE replaces Frontend contexts by following the guidelines herein to implement new "enhanced" contexts.

This document utilizes the following conventions:
- "Old context" refers to a context that is being or has been replaced by an enhanced version.
- "New context" refers to the enhanced version of an old context.
- "Parent context" refers to a context that defines another context via a LuaContext node in its UI controls file.
- "Child context" refers to a context that is defined via a LuaContext node in the UI controls file of another context.

# Implementing Enhanced Contexts 
The process of replacing an old context with a new context is literally as easy as 1-2-3:
1. Identify the [parent context(s)](#parent-contexts) of the old context, and change the appropriate LuaContext nodes within the corresponding UI controls file(s).
2. Provide a new [UI controls wrapper](#ui-controls-wrapper) file for the new context which loads the old context's controls.
3. Provide a new [UI script wrapper](#ui-script-wrapper) file for the new context which loads the old context's script.

Once complete, the new context will immediately function as if it were the old context, because it will be utilizing the last-imported versions of the old context's controls template and implementation script. When fully implemented as detailed below, the new context will also have the ability to dynamically extend its Lua functionality by using appropriately-named new script files to add new content or replace existing content. Since these files are independent of the core script, any content in them will also be applied to the new context when any mod that replaces the old context's script is enabled, although some [limitations](README.md#limitations) apply.

## Parent Contexts 
To create a new context, ECFE simply prepends the string `Enhanced` to the value of the FileName attribute in all applicable LuaContext nodes which define the old context. Other defined attributes, particularly the ID attribute, should be left unchanged, or breakage will likely occur.

This change must be made to all applicable parent contexts. For a parent context that is not a replacement, a copy of its UI controls file must be provided, in which this change will then be made. A parent context that is also a replacement must instead make this change by adding a new LuaContext node to its [UI controls wrapper](#ui-controls-wrapper) file.

## UI Controls Wrapper 
A new XML file must be provided which operates as a UI controls wrapper. This file's name must match the value of the new context's FileName attribute as defined in the appropriate LuaContext node(s) within the UI controls file(s) of its [parent context(s)](#parent-contexts), but for non-Windows OS compatibility, all letters in it should be lowercase, regardless of the case of those letters within the FileName attribute's value.

The top-level node definition of this wrapper must match that of the old context's UI controls file. Within this node, in order, this wrapper may/must contain the following components:
1. (Required) An Include node which references the original value of the old context's FileName attribute. This loads the controls defined in the old context's last-imported UI controls file into the new context.
2. (Optional) Additional Include nodes which reference the exact filenames of any other UI controls files which contain explicitly defined controls that will be used by the new context. Omit extensions.
3. (Optional) If the new context is or will be a parent context of any new or otherwise undefined contexts, a properly-formatted LuaContext node for each such context.
4. (Optional) Additional explicitly defined controls that will be used by the new context, which are not provided by (1) or (2), or that will overwrite any previously imported controls.

## UI Script Wrapper 
A new LUA file must be provided which operates as a UI script wrapper. This file's name must match the value of the new context's FileName attribute as defined in the appropriate LuaContext node(s) within the UI controls(s) of its [parent context(s)](#parent-contexts), but for non-Windows OS compatibility, all letters in it should be lowercase, regardless of the case of those letters within the FileName attribute's value.

In order, this wrapper may/must contain the following components:
1. (Optional) Include statements which reference any UI script files which contain components that will be used by the new context, and that should be loaded before any other components. Lua Include statements support wildcards, so either individual filenames or case-sensitive patterns can be provided; for patterns, all imported files with names matching the pattern will be included. Omit extensions.
2. (Optional) Any additional Lua components which should be loaded before any other components and are not provided by (1).
3. (Required) An Include statement which references the original value of the old context's FileName attribute. This loads the contents of the old context's last-imported UI script file into the new context.
4. (Optional) Additional Include statements which reference any other UI script files which contain components that will be used by the new context. Lua Include statements support wildcards, so either individual filenames or case-sensitive patterns can be provided; for patterns, all imported files with names matching the pattern will be included. Omit extensions.
5. (Optional) Additional Lua components that will be used by the new context, which are not provided by any of (1) through (4), or that will overwrite any previously imported components.

# Examples 
Below are examples and links that demonstrate:
- How to provide a new enhanced context, and
- How to utilize an existing enhanced context

## Providing a New Enhanced Context 
Consider the aptly named ExampleContext:
- ExampleContext has a single parent context named ParentContext.
- Within `ParentContext.xml`, the LuaContext node which defines ExampleContext specifies `ExampleContext` as the value of its FileName attribute, and contains additional attributes which defer loading and hide it by default.
- ExampleContext has a single child context named ChildContext.
- Within `ExampleContext.xml`, the LuaContext node which defines ChildContext specifies `ChildContext` as the value of its FileName attribute.

To replace ExampleContext with EnhancedExampleContext:
1. A copy of `ParentContext.xml` must be provided, and its LuaContext node which defines ExampleContext must be changed to `<LuaContext ID="ExampleContext" DeferLoad="1" FileName="EnhancedExampleContext" Hidden="1" />`.
2. The UI controls wrapper file for EnhancedExampleContext will be named `enhancedexamplecontext.xml`, and its top-level node must match that of `ExampleContext.xml`. Within this wrapper's top-level node, add `<Include File="ExampleContext"/>`.
3. The UI script wrapper file for EnhancedExampleContext will be named `enhancedexamplecontext.lua`. At the top of this wrapper, add `include("ExampleContext");`.
4. To also include Lua components from any imported script files whose names match the patterns `ExampleContext_*.lua` and `examplecontext_*.lua`, add the following lines to `enhancedexamplecontext.lua` just below the line added in (3):
    - `include("ExampleContext_", true);`
    - `include("examplecontext_", true);`
5. If ChildContext is not being replaced, no further actions are required. To also replace ChildContext, add `<LuaContext ID="ChildContext" FileName="EnhancedChildContext" />` to `enhancedexamplecontext.xml`'s top-level node, and repeat (2) and (3), substituting ChildContext for ExampleContext. To also load additional Lua content by pattern-matching, also repeat (4) with the same substitutions.

## Utilizing an Existing Enhanced Context 
Once an enhanced context has been created, it is trivially simple to extend it by adding additional or modifying existing Lua components without altering any of the core context files. Refer to ECFE's [EnhancedAdvancedSetup.lua](./ecfe/ui/enhancedadvancedsetup.lua) and [EnhancedHostGame.lua](./ecfe/ui/enhancedhostgame.lua) files and the files they use for real working examples of how this can be achieved.

However, unlike Lua, XML does not support the use of wildcards in Include nodes. It is therefore not possible to dynamically load XML content through the use of pattern-matching. This makes it harder to make changes to existing controls within a context, or to add new controls therein, although (tedious) workarounds may exist:
- An existing control can be modified within a script, assuming its ID attribute is properly defined.
- A new control can be added by utilizing dynamic instances in a script, assuming the UI controls file has defined the appropriate instance.
