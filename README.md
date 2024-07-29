# NEOVIM

This is my neovim configuration.

I started using neovim after a long time using vim followed by a short time using emacs.

## IDEA

I try to avoid dependencies as far as possible using neovims own features where possible.

If I have to use soe 3rd party stuff, I try to use it with git submodules instead of a pluginmanager like /lazy/.

*Why?* idk. for fun.

## STRUCTURE

`~/.config/nvim/`  home of this.

`~/.config/nvim/tools/`  3rd party tools (not systemwide but for neovim, like language servers).

`~/.config/nvim/init.lua`  config entry point.

`~/.config/nvim/lua/`  rest of the configuration.



