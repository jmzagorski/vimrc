# vimrc - Inititaion files for vim and gvim

* [Requirements](#requirements)
* [Plugins](#plugins)
* [Windows](#windows)
* [Linux](#linux)

### Requirements
- Vim 8.0 or above
- Plugin manager [dein](https://github.com/Shougo/dein.vim)

### Plugins
- Support for database development
- Support for server development - c#, rust, powershell
- Support for client development -  html/css/less/javascript/typescript

Plugin requirements are below:
- Tag plugins need https://github.com/universal-ctags/ctags
- C# needs Omnisharp-Roslyn server. See [omnisharp-vim](https://github.com/OmniSharp/omnisharp-vim)
- Typscript needs `npm install -g typescript`
- fzf.vim needs [ripgrep](https://github.com/BurntSushi/ripgrep) or ack
- Git plugins need [git](https://git-scm.com/downloads)
- Rust plugins need [rust](https://www.rust-lang.org) and optionally [rustfmt](https://github.com/rust-lang/rustfmt)
- dbext.vim is not maintained on github. Download and place it in ~/.cache/dein/repos/vim.org

### Windows
- `git clone https://github.com/jmzagorski/vimrc.git %USERPROFILE%\vimfiles`
- vimproc needs nmake, normally installed with visual studio
- fzf requires [chocolatey](https://chocolatey.org) and `choco install fzf`.
- vimproc needs nmake.exe in its path, normally installed with visual studio and make_msvc32.mak in the same dir
  - tip: Run developer prompt and type `where nmake`

### Linux
- `git clone https://github.com/jmzagorski/vimrc.git $HOME/.vim`
- vimproc needs make
- For WSL c#, make sure OmniSharp.exe is in `/mnt/c/OmniSharp/omnisharp.http-win-x64/OmniSharp.exe`
