# harpbar.nvim
> A simple way to ensure you harpoon is on target

<div align="center">

![Neovim](https://img.shields.io/badge/neovim-%23019733.svg?style=for-the-badge&logo=neovim&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)
![GitHub stars](https://img.shields.io/github/stars/JamieLittle16/harpbar.nvim?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/JamieLittle16/harpbar.nvim?style=for-the-badge)

</div>

<div align="center">
<img src="https://github.com/JamieLittle16/harpbar.nvim/blob/main/assets/logo.png" alt="Harpoon on Target" width="400">
<br>
<strong>harpbar.nvim - Harpoon, Track, Relax</strong>
</div>

**harpbar.nvim** is a lightweight Neovim plugin that displays an informative tabline for Harpoon marks. It provides a visual bar at the top of your Neovim window, showing all your current Harpoon marks with clear highlighting for the active file. This makes it easier to track, navigate, and manage your marked files when using [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon).

## Installation
Install using your package manager of choice (Lazy is most throughly tested).

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "JamieLittle16/harpbar.nvim",
  dependencies = { "ThePrimeagen/harpoon" },
  config = function()
    require("harpbar").setup()
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "JamieLittle16/harpbar.nvim",
  requires = { "ThePrimeagen/harpoon" } -- Make sure harpoon is installed
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'ThePrimeagen/harpoon'
Plug 'JamieLittle16/harpbar.nvim'
```
## Screenshot
<div align="center">
<img src="https://github.com/JamieLittle16/harpbar.nvim/blob/main/assets/harpbar-screenshot.png", alt="Screenshot of harpbar", width=800>
</div>

---

## Bugs & Features
If you find any bugs or would like to request new features submit an issue.
Alternatively, pull requests are always welcome (and appreciated).

## Author
Jamie Little

---

<div align="center">
  
**Enjoy!**

Made by Jamie Little

[Report Bug](https://github.com/JamieLittle16/harpbar.nvim/issues) ·
[Request Feature](https://github.com/JamieLittle16/harpbar.nvim/issues) ·
[Contribute](https://github.com/JamieLittle16/harpbar.nvim/pulls)

</div>
