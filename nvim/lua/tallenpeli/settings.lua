local state_dir = vim.fn.stdpath("state") .. "/tallenpeli.nvim"
local state_file = state_dir .. "/settings.json"

---@class tallenpeli.Settings.Updates
---@field updatecheck boolean
---@field notify boolean

---@class tallenpeli.Settings.UI
---@field animations boolean
---@field colorscheme string

---@class tallenpeli.Settings.AI
---@field supermaven boolean
---@field copilot boolean

---@class tallenpeli.Settings
---@field updates tallenpeli.Settings.Updates
---@field ui tallenpeli.Settings.UI
---@field ai tallenpeli.Settings.AI

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
		colorscheme = "vscode",
	},
	ai = {
		supermaven = false,
		copilot = false,
	},
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
			table.insert(items, {
				text = section,
				is_header = true,
				section = section,
			})

			local keys = vim.tbl_keys(current[section])
			table.sort(keys)

			for _, key in ipairs(keys) do
				table.insert(items, {
					text = section .. " " .. key,
					is_header = false,
					section = section,
					key = key,
					value = current[section][key],
				})
			end
		end
		return items
	end

	local function refresh(picker)
		picker:find({ refresh = true })
		-- Return focus to the picker after a vim.ui.input prompt
		vim.schedule(function()
			pcall(function()
				picker:focus()
			end)
		end)
	end

	local function confirm(picker, item)
		if not item or item.is_header then
			return
		end

		local current = M.load()
		local val = current[item.section][item.key]

		-- Booleans: toggle in place
		if type(val) == "boolean" then
			current[item.section][item.key] = not val
			M.save(current)
			refresh(picker)
			return
		end

		-- Strings / numbers: open a text field
		if type(val) == "string" or type(val) == "number" then
			vim.ui.input({
				prompt = item.section .. "." .. item.key .. ": ",
				default = tostring(val),
			}, function(input)
				if input == nil then -- cancelled
					refresh(picker)
					return
				end

				local new_value = input
				if type(val) == "number" then
					new_value = tonumber(input)
					if new_value == nil then
						vim.notify(("tallenpeli: '%s' is not a valid number"):format(input), vim.log.levels.ERROR)
						refresh(picker)
						return
					end
				end

				local updated = M.load()
				updated[item.section][item.key] = new_value
				M.save(updated)
				refresh(picker)
			end)
		end
	end

	Snacks.picker({
		title = "tallenpeli.nvim Settings (Enter to toggle/edit)",
		layout = { preset = "select", preview = false },
		finder = build_items,
		format = function(item)
			if item.is_header then
				return {
					{ "── " .. item.section:upper() .. " ──", "SnacksPickerLabel" },
				}
			end

			local icon, status, hl

			if type(item.value) == "boolean" then
				icon = item.value and "󰄲 " or "󰄱 "
				status = item.value and "ON" or "OFF"
				hl = item.value and "DiagnosticOk" or "Comment"
			elseif type(item.value) == "string" then
				icon = "󰏫 "
				status = item.value
				hl = "String"
			elseif type(item.value) == "number" then
				icon = "󰎠 "
				status = tostring(item.value)
				hl = "Number"
			else
				icon = "X "
				status = tostring(item.value)
				hl = "Error"
			end

			return {
				{ "  " .. icon, hl },
				{ string.format("%-20s", item.key), "Normal" },
				{ status, hl },
			}
		end,
		confirm = confirm,
	})
end

return M
