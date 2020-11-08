git clone https://github.com/vim/vim.git
sudo apt install gcc
sudo apt install libncurses5-dev
sudo apt install python3-dev
cd vim
./configure --with-features=huge --enable-gui=no --enable-multibyte --enable-python3interp=yes --enable-cscope --netbeans=no
# ./configure --with-features=huge --enable-gui=no --enable-multibyte --enable-python3interp=yes --enable-cscope --netbeans=no
sudo make uninstall && sudo make && sudo make install && sudo make clean && sudo make distclean
./configure --with-features=huge             --enable-multibyte             --enable-rubyinterp=yes             --enable-python3interp=yes             --with-python3-config-dir=$(python3-config --configdir)             --enable-perlinterp=yes             --enable-luainterp=yes             --enable-gui=gtk2             --enable-cscope \
