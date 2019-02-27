# vimrc - vim and gvim

* [Requirements](#requirements)
* [Setup](#setup)
* [Supports](#supports)
* [Plugins](#plugins)
* [Windows](#windows)
* [Linux](#linux)

### Requirements
- Vim 8.0 or above with +package

### Setup
- When opening vim for the first time, the *minpac* plugin will attempt to download
- Run `:PackInstall`
- Exit and reopen vim...enjoy!

### Supports
- Rust
- Powershell
- C#
- Documentation (markdown, toml, yaml)
- HTML / CSS
- Javascript / Typescript
- Docker
- Database access
- ...Any more. See rc/plugins directory

### Plugin:
- Some plugins attempt to install their dependencies. When those cannot be downloaded you should receive warnings in the `:message`
- Tag plugins need https://github.com/universal-ctags/ctags
- Git plugins need [git](https://git-scm.com/downloads)

### Windows
- `git clone https://github.com/jmzagorski/vimrc.git %USERPROFILE%\vimfiles`
- ConEmu: Make sure to set the CONEMU variable to any value before opening vim. There are a few ui settings that need to take place, but will mess up the default powershell and command prompt

### Linux
- `git clone https://github.com/jmzagorski/vimrc.git $HOME/.vim`
- For Omnisharp: If using with WSL, my [config-linux](https://github.com/jmzagorski/config-linux) sets the $USERNAME variable to try and find your exe
