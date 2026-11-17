local state_dir = vim.fn.stdpath("state") .. "/tallenpeli.nvim"
local state_file = state_dir .. "/settings.json"

local M = {}

-- Add any new sections/settings here and they automatically appear in the UI
local defaults = {
    updates = {
        autoupdate = true,
        notify = true,
    },
    ui = {
        animations = false,
    }
}

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

function M.save(settings)
    vim.fn.mkdir(state_dir, "p")
    local file = assert(io.open(state_file, "w"))
    file:write(vim.json.encode(settings))
    file:close()
end

-- Interactive Snacks Picker Settings Menu
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

            local icon = item.value and "󰄲 " or "󰄱 "
            local status = item.value and "ON" or "OFF"
            local hl = item.value and "DiagnosticOk" or "Comment"

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
