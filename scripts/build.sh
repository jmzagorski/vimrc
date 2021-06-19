git clone https://github.com/vim/vim.git
sudo apt install gcc ncurses-dev libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
cd vim
./configure --with-features=huge --enable-gui=no --enable-multibyte --enable-cscope --netbeans=no
sudo make uninstall && sudo make && sudo make install && sudo make clean && sudo make distclean
