local linters = {
    shellcheck = {
        command = "shellcheck",
        debounce = 100,
        args = { "--format", "json", "--external-sources", "-" },
        sourceName = "shellcheck",
        parseJson = {
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${code}]",
            security = "level",
        },
        securities = {
            error = "error",
            warning = "warning",
            info = "info",
            style = "hint",
        },
    },
}

return linters


