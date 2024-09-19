local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("taskbuild_dotnet",
    fmt([[
{{
  "label": "build",
  "command": "dotnet",
  "type": "process",
  "args": [
      "build",
      "${{workspaceFolder}}/{1}/{1}.csproj",
      "/property:GenerateFullPaths=true",
      "/consoleloggerparameters:NoSummary"
  ],
  "problemMatcher": "$msCompile"
}},
]],
      {
        i(1, "project_name"),
      },
      {
        repeat_duplicates = true,
      })),

  s("launch_dotnet",
    fmt([[
{{
    "version": "0.2.0",
    "configurations": [
      {{
         "name": ".NET Core Launch (console)",
         "type": "coreclr",
         "request": "launch",
         "preLaunchTask": "build",
         // If you have changed target frameworks, make sure to update the program path.
         "program": "${{workspaceFolder}}/{1}/bin/Debug/{2}/{1}.dll",
         "args": [],
         "cwd": "${{workspaceFolder}}/{1}",
         "console": "internalConsole",
         "justMyCode": false,
         "stopAtEntry": false
      }}
   ]
}}
]],
      {
        i(1, "project_name"),
        i(2, "framework_version"),
      },
      {
        repeat_duplicates = true,
      })),
}

