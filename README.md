# tallenpeli.nvim

![./img/logo.png](./img/logo.png)

This is a neovim configuration that uses Lazy.nvim. Primarily designed for my programming needs, but I will check issues and PRs for things people want to see.

This config is designed for full-stack development, from front-end to back-end with javascript/typescript, HTML, go, rust, and more.

[**Install instructions**](#Installation)

## What does tallenpeli.nvim include?

tallenpeli.nvim includes a suite of features for seamless programming without having to worry about setup. Here are some of the features preconfigured in this config.

### **LSPs (mason.nvim)**

<details>
    <summary>Click to expand</summary>
     <ul>
        <li>cssls (css)</li>
        <li>eslint (javascript/typescript/tsx/jsx)</li>
        <li>html (html)</li>
        <li>jsonls (json)</li>
        <li>ts_ls (typescript/tsx)</li>
        <li>pyright (python)</li>
        <li>clangd (c/cpp)</li>
        <li>rust_analyzer (rust)</li>
        <li>gopls (go)</li>
        <li>lua_ls (lua)</li>
    </ul>

</details>

### **Formatters/Linters (mason.nvim)**

- prettier (javascript/typescript/tsx/jsx)
- stylua (lua)
- isort
- black
- pylint (python)
- eslint_d (javascript/typescript/tsx/jsx)

### **Telescope**

- Telescope
- Telescope Grep
- Telescope File
- Telescope Buffers

### **Autocomplete**

- nvim-cmp
- nvim-cmp-buffer
- nvim-cmp-path
- nvim-cmp-nvim-lsp

### **Colorscheme**

- VSCode
- Adwaita
- Evergreen
- Catppuccin

### **Developer Tools**

- Live Preview (for HTML, markdown, svg, asciidoc)
- Render Markdown
- Supermaven (AI autocomplete)
- gitsigns

### **Quality of Life**

- autopairs/autotag
- barbar
- cmp
- colorizer
- lualine
- nvim-tree
- nvim-web-devicons
- nvim-lspconfig

### **Other**

- **Discord Rich Presence** (can be disabled by deleting `nvim/lua/tallenpeli/plugins/discord-rpc.lua`)

> [!TIP]
> You can find the full list of plugins in `nvim/lua/tallenpeli/plugins`
> Adding a plugin is as simple as adding it to the folder as `<plugin-name>.lua`.
> Neovim will automatically load the plugin when it is detected.
>
> Example plugin:
>
> ```lua
> return {
>    "example/plugin",
>    config = function()
>        -- plugin configuration
>    end,
> }
> ```
>
> `~/.config/nvim/lua/tallenpeli/plugins/example-plugin.lua`

## Installation

1. Install [Neovim](https://github.com/neovim/neovim) (v0.9.1+)
2. clone this repo

```bash
git clone https://github.com/tallenpeli/tallenpeli.nvim && cd tallenpeli.nvim
```

3. Run `install.sh` in the root of the repository

```bash
./install.sh
```

4. Run nvim and wait for lazyvim to install the plugins

```bash
nvim
```

## Keybinds

**Telescope**

You can open telescope and it's different search types by using the following keybinds.

- `<Space>g` Opens the grep search view
- `<Space>F` Opens the file search view
- `<Space>b` Opens the buffers search view

**Other Keybinds**

- `<Space>e` Opens the error/debug line
- `<Space>s` Toggles sidebar (neo-tree)
- `<Space>ai` Toggles Supermaven (AI autocomplete)

This configuration uses standard vim/neovim keybinds.

> [!TIP]
> Keybinds are configured in `nvim/lua/tallenpeli/maps.lua`

## Screenshots

![Telescope File](./img/telescope.png)
![Telescope Grep](./img/grep.png)
![Supermaven](./img/supermaven.png)
![Autocomplete](./img/autocomplete.png)

```

```
