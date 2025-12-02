--  #     #  #   #
--  #     #      #      ###
--  #     #  #   ###   #   #
--   #   #   #   #  #  ####
--    # #    #   #  #  #
--     #     #   ###    ###
local M = {}

-- Where your dictionaries live
local dict_dir = vim.fn.expand("~/.ltex-dicts")

local function ensure_dir()
    if vim.fn.isdirectory(dict_dir) == 0 then
        vim.fn.mkdir(dict_dir, "p")
    end
end

local function dict_file(lang)
    return dict_dir .. "/dictionary-" .. lang .. ".txt"
end

-- Load dictionary into ltex settings
function M.load_dictionaries(client)
    local settings = client.config.settings or {}
    settings.ltex = settings.ltex or {}

    local langs = settings.ltex.language or {}
    if type(langs) == "string" then langs = { langs } end

    for _, lang in ipairs(langs) do
        local file = dict_file(lang)
        if vim.fn.filereadable(file) == 1 then
            settings.ltex.dictionary = settings.ltex.dictionary or {}
            settings.ltex.dictionary[lang] = vim.fn.readfile(file)
        end
    end

    client.notify("workspace/didChangeConfiguration", { settings = settings })
end

-- Add a new word to the dictionary
function M.add_word(word)
    ensure_dir()

    local client = vim.lsp.get_clients({ name = "ltex" })[1]
    if not client then return end

    local lang = client.config.settings.ltex.language or "en-US"
    local file = dict_file(lang)

    local f = io.open(file, "a+")
    if f then
        f:write(word .. "\n")
        f:close()
    end

    print("Added to LTeX dictionary:", word)

    -- tell LTeX to reload settings
    M.load_dictionaries(client)
end

-- Disable a rule
function M.disable_rule(rule)
    local client = vim.lsp.get_clients({ name = "ltex" })[1]
    if not client then return end

    client.notify("workspace/executeCommand", {
        command = "_ltex.disableRule",
        arguments = { rule }
    })

    print("Disabled LTeX rule:", rule)
end

-- Register user commands
function M.setup_commands()
    vim.api.nvim_create_user_command("LTeXAddWord", function(opts)
        M.add_word(opts.args)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("LTeXDisableRule", function(opts)
        M.disable_rule(opts.args)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("LTeXShowConfig", function()
        print(vim.inspect(vim.lsp.get_clients({ name = "ltex" })[1].config.settings))
    end, {})
end

return M
