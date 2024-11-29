# OPTIONS.NVIM

Define NeoVim options via `folke/neoconf.nvim` configuration file.

## Installation

> [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)
> ```lua
> return {
>     "PlumpAlbert/options.nvim",
>     dependencies = {
>         "folke/neoconf.nvim",
>         "xiyaowong/transparent.nvim",
>     },
>     config = true,
> }
> ```

## Usage

Create file `.neoconf.json` in your project's root. Populate key `options` with
values to configure your NeoVim setup.

> [!TIP]
> Example (default values):
> ```json
> {
>     "options": {
>         "theme": "retrobox",
>         "useTabs": true,
>         "indent": 4,
>         "rulers": [ 80 ],
>         "wrap": false,
>         "lineNumbers": "both",
>         "shell": "/bin/bash",
>         "transparent": false,
>     }
> }
> ```

Options will be applied automatically on configuration change.
