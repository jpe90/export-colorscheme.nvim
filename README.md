# export-colorscheme.nvim

A neovim plugin that generates a colorscheme for an another CLI program based on your currently enabled vim colorscheme.

The user is prompted to select a supported CLI program, and a colorscheme is generated in the CWD.

This is alpha quality and you may need to tweak the generated colorscheme.

## Currently Supported 

- [Vis](https://github.com/martanne/vis)
- [Kakoune](https://github.com/mawww/kakoune)

## Planned

- [Clp](https://github.com/jpe90/clp)
- [Helix](https://helix-editor.com/)

# Installation

## Packer

[vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'jpe90/export-colorscheme.nvim'
```

[packer](https://github.com/wbthomason/packer.nvim)

```lua
use 'jpe90/export-colorscheme.nvim'

require('export-colorscheme')
```

# Usage

- Enter `Ecs` at the command prompt
- Hit `<Space>` followed by `<Tab>` to cycle through output options
- Select an option with `<Return>`

# Motivation

Vim has accumulated over a decade of colorschemes which include color information for highlighting lexical tokens. Smaller CLI programs which make use of lexical tokens (e.g. for syntax highlighting) often have far fewer colorschemes, and generating them by hand can be tedious. This project aims to make it easier to customize these programs.
