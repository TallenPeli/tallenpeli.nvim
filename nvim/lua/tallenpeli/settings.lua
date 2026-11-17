local state_dir = vim.fn.stdpath("state") .. "/tallenpeli.nvim"
local state_file = state_dir .. "/settings.json"

---@class tallenpeli.Settings.Updates
---@field updatecheck boolean
---@field notify boolean

---@class tallenpeli.Settings.UI
---@field animations boolean
---@field colorscheme string

---@class tallenpeli.Settings
---@field updates tallenpeli.Settings.Updates
---@field ui tallenpeli.Settings.UI

local M = {}

---@type tallenpeli.Settings
-- Add any new sections/settings here and they automatically appear in the UI
local defaults = {
    updates = {
        updatecheck = true,
        notify = true,
    },
    ui = {
        animations = false,
        colorscheme = "vscode"
    }
}

---@return tallenpeli.Settings
function M.load()
    local file = io.open(state_file, "r")
    if not file then
        return vim.deepcopy(defaults)
    end
    local content = file:read("*a")
    file:close()

    local ok, data = pcall(vim.json.decode, content, { luanil = { object = true } })
    if ok and type(data) == "table" then
        return vim.tbl_deep_extend("force", vim.deepcopy(defaults), data)
    end
    return vim.deepcopy(defaults)
end

---@param settings tallenpeli.Settings
function M.save(settings)
    vim.fn.mkdir(state_dir, "p")
    local file = assert(io.open(state_file, "w"))
    file:write(vim.json.encode(settings))
    file:close()
end

---Interactive Snacks Picker Settings Menu
function M.open_menu()
    local function build_items()
        local current = M.load()
        local items = {}

        local sections = vim.tbl_keys(current)
        table.sort(sections)

        for _, section in ipairs(sections) do
            -- Section Header row
            table.insert(items, {
                text = section,
                is_header = true,
                section = section,
            })

            local keys = vim.tbl_keys(current[section])
            table.sort(keys)

            for _, key in ipairs(keys) do
                local val = current[section][key]
                table.insert(items, {
                    text = section .. " " .. key,
                    is_header = false,
                    section = section,
                    key = key,
                    value = val,
                })
            end
        end
        return items
    end

    local function toggle_selected(picker, item)
        if not item or item.is_header then
            return
        end
        local current = M.load()
        current[item.section][item.key] = not current[item.section][item.key]
        M.save(current)

        -- Refresh the list in-place so the checkbox updates immediately without closing
        picker:find({ refresh = true })
    end

    Snacks.picker({
        title = "tallenpeli.nvim Settings (Enter to toggle)",
        layout = { preset = "select", preview = false },
        finder = function()
            return build_items()
        end,
        format = function(item)
            if item.is_header then
                return {
                    { "── " .. item.section:upper() .. " ──", "SnacksPickerLabel" },
                }
            end

            local icon = ""
            local status = "OFF"
            local hl = ""

            if type(item.value) == "boolean" then
                icon = item.value and "󰄲 " or "󰄱 "
                status = item.value and "ON" or "OFF"
                hl = item.value and "DiagnosticOk" or "Comment"
            elseif type(item.value) == "string" then
                vim.ui.input({ prompt = item.key .. ": ", default = val }, function(input)
                    if input ~= nil then
                        local updated = M.load()
                        updated[item.section][item.key] = input
                        M.save(updated)
                        picker:find({ refresh = true })
                    end
                end)
            else
                icon = "X "
                status = tostring(item.value)
                hl = "Error"
            end

            return {
                { "  " .. icon,                     hl },
                { string.format("%-20s", item.key), "Normal" },
                { status,                           hl },
            }
        end,
        confirm = toggle_selected,
    })
end

return M
