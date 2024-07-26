-- → Lua.addonManager.enable             default: true
-- → Lua.codeLens.enable                 default: false
-- → Lua.completion.autoRequire          default: true
-- → Lua.completion.callSnippet          default: "Disable"
-- → Lua.completion.displayContext       default: 0
-- → Lua.completion.enable               default: true
-- → Lua.completion.keywordSnippet       default: "Replace"
-- → Lua.completion.postfix              default: "@"
-- → Lua.completion.requireSeparator     default: "."
-- → Lua.completion.showParams           default: true
-- → Lua.completion.showWord             default: "Fallback"
-- → Lua.completion.workspaceWord        default: true
-- → Lua.diagnostics.disable             default: []
-- → Lua.diagnostics.disableScheme       default: ["git"]
-- → Lua.diagnostics.enable              default: true
-- → Lua.diagnostics.globals             default: []
-- → Lua.diagnostics.globalsRegex        default: []
-- → Lua.diagnostics.groupFileStatus
-- → Lua.diagnostics.groupSeverity
-- → Lua.diagnostics.ignoredFiles        default: "Opened"
-- → Lua.diagnostics.libraryFiles        default: "Opened"
-- → Lua.diagnostics.neededFileStatus
-- → Lua.diagnostics.severity
-- → Lua.diagnostics.unusedLocalExclude  default: []
-- → Lua.diagnostics.workspaceDelay      default: 3000
-- → Lua.diagnostics.workspaceEvent      default: "OnSave"
-- → Lua.diagnostics.workspaceRate       default: 100
-- → Lua.doc.packageName                 default: []
-- → Lua.doc.privateName                 default: []
-- → Lua.doc.protectedName               default: []
-- → Lua.format.defaultConfig            default: {}
-- → Lua.format.enable                   default: true
-- → Lua.hint.arrayIndex                 default: "Auto"
-- → Lua.hint.await                      default: true
-- → Lua.hint.enable                     default: false
-- → Lua.hint.paramName                  default: "All"
-- → Lua.hint.paramType                  default: true
-- → Lua.hint.semicolon                  default: "SameLine"
-- → Lua.hint.setType                    default: false
-- → Lua.hover.enable                    default: true
-- → Lua.hover.enumsLimit                default: 5
-- → Lua.hover.expandAlias               default: true
-- → Lua.hover.previewFields             default: 50
-- → Lua.hover.viewNumber                default: true
-- → Lua.hover.viewString                default: true
-- → Lua.hover.viewStringMax             default: 1000
-- → Lua.misc.executablePath             default: ""
-- → Lua.misc.parameters                 default: []
-- → Lua.nameStyle.config                default: {}
-- → Lua.runtime.builtin
-- → Lua.runtime.fileEncoding            default: "utf8"
-- → Lua.runtime.meta                    default: "${version} ${language} ${encoding}"
-- → Lua.runtime.nonstandardSymbol       default: []
-- → Lua.runtime.path                    default: ["?.lua","?\/init.lua"]
-- → Lua.runtime.pathStrict              default: false
-- → Lua.runtime.plugin
-- → Lua.runtime.pluginArgs
-- → Lua.runtime.special                 default: {}
-- → Lua.runtime.unicodeName             default: false
-- → Lua.runtime.version                 default: "Lua 5.4"
-- → Lua.semantic.annotation             default: true
-- → Lua.semantic.enable                 default: true
-- → Lua.semantic.keyword                default: false
-- → Lua.semantic.variable               default: true
-- → Lua.signatureHelp.enable            default: true
-- → Lua.spell.dict                      default: []
-- → Lua.type.castNumberToInteger        default: true
-- → Lua.type.inferParamType             default: false
-- → Lua.type.weakNilCheck               default: false
-- → Lua.type.weakUnionCheck             default: false
-- → Lua.typeFormat.config
-- → Lua.window.progressBar              default: true
-- → Lua.window.statusBar                default: true
-- → Lua.workspace.checkThirdParty
-- → Lua.workspace.ignoreDir             default: [".vscode"]
-- → Lua.workspace.ignoreSubmodules      default: true
-- → Lua.workspace.library               default: []
-- → Lua.workspace.maxPreload            default: 5000
-- → Lua.workspace.preloadFileSize       default: 500
-- → Lua.workspace.useGitIgnore          default: true
-- → Lua.workspace.userThirdParty        default: []
return {
  settings = {
    Lua = {
      semantic = {
        enable = false,
      },
      hint = { enable = true },
      diagnostics = {
        globals = { "vim" },
        undefined_global = false,
        missing_parameters = false,
        -- disable = { "missing-parameters", "missing-fields" },
      },
      telemetry = { enable = false },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
        },
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
