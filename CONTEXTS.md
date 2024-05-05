# Replacing Contexts 
Replaced contexts are implemented as follows:
- In the XML template of any parent context which references the replaced context, the FileName attribute of the LuaContext node must be changed by prepending the string `Enhanced` to it. For parent contexts that are not replaced by ECFE, this requires replacing the context's XML template file. Parent contexts that are themselves replacement contexts should include a LuaContext node with the required changes in their XML template wrapper file as detailed below.
- An XML template wrapper file must be provided. This file's name must match the FileName attribute as defined above, with a `.xml` extension. For compatibility with Linux this file's actual name should be fully lowercase, even if the context's FileName attribute is otherwise expressed within any LuaContext nodes that define it. The top-level node must match that of the original context's XML template file, and within that node, in order, this wrapper must contain the following components:
    1. (Required) An Include node which references the original context's exact original FileName attribute. This loads the controls defined in the original context's last-imported XML template file.
    2. (Optional) Additional Include nodes which reference the exact filenames of any other XML template files which contain explicitly defined controls that will be used by this context. Omit extensions.
    3. (Optional) If this context is a parent context of any new or replaced contexts, a properly-formatted LuaContext node for each new or replaced child context.
    4. (Optional) Additional explicitly defined controls that will be used by this context, which are not provided by any files imported via defined Include nodes, or that will overwrite any previously imported controls.
- A Lua script wrapper file must be provided. This file's name must match the FileName attribute as defined above, with a `.lua` extension. For compatibility with Linux the file's actual name should be fully lowercase, even if the context's FileName attribute is otherwise expressed within any LuaContext nodes that define it. In order, this wrapper must contain the following components:
    1. (Optional) Include statements which reference any Lua script files which contain components that will be used by this context, and that should be loaded before any other components. Lua Include statements support wildcards, so either explicit filenames or patterns can be provided; for patterns, all files with names matching the pattern will be included. Omit extensions.
    2. (Optional) Any additional Lua components which should be loaded before any other components and are not provided by any files included via (1) above.
    3. (Required) An Include statement which references the original context's exact original FileName attribute. This loads the contents of the original context's last-imported Lua script file.
    4. (Optional) Additional Include statements which reference any other Lua script files which contain components that will be used by this context. Lua Include statements support wildcards, so either explicit filenames or patterns can be provided; for patterns, all files with names matching the pattern will be included. Omit extensions.
    5. (Optional) Additional Lua components that will be used by this context, which are not provided by any of (1) through (4) above, or that will overwrite any previously imported components.

As an example, for an aptly named ExampleContext:
- A copy of any XML template belonging to a context that is a parent of ExampleContext must be provided, and the LuaContext node(s) therein which define(s) ExampleContext must be changed to the following:
    - `<LuaContext ID="ExampleContext" FileName="EnhancedExampleContext" />`
        - Add additional attributes to the LuaContext node as required
- The XML template wrapper for the new context will be `enhancedexamplecontext.xml`. At a minimum, this file must contain the following within its top-level node:
    - `<Include File="ExampleContext"/>`
- To include controls defined in the `newcontrols.xml` template, add the following to the XML wrapper's top-level node:
    - `<Include File="newcontrols"/>`
- To replace a child context named ChildContext which ExampleContext is a parent of, add the following to the XML wrapper's top-level node:
    - `<LuaContext ID="ChildContext" FileName="EnhancedChildContext" />`
        - Add additional attributes to the LuaContext node as required
- The Lua script wrapper for the new context will be `enhancedexamplecontext.lua`. At a minimum, this file must contain the following:
    - `include("ExampleContext");`
- To include components defined in the `newcomponents.lua` script, add the following to the Lua wrapper:
    - `include("newcomponents");`
- To include components defined in any script whose filename matches the pattern `newcomponents_*.lua`, add the following to the Lua wrapper:
    - `include("newcomponents_", true);`
