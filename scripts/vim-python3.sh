#!/bin/bash
echo "Getting prerequisites for this build..."

sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
	        python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git


echo "Starting VIM Python 3 build.."

if [ ! -d ./vim-build/ ]; then
    mkdir -p ./vim-build
fi

cd ./vim-build

echo "Cloning VIM git repository"
git clone https://github.com/vim/vim.git vim-git
cd ./vim-git

VIM_PYTHON3_SETUP="$(python3-config --configdir)"
echo "Python 3 Config directory is: " $VIM_PYTHON3_SETUP

./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-python3interp --with-python3-config-dir=$VIM_PYTHON3_SETUP --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim80

echo "Using checkinstall to build and install custom VIM"
sudo checkinstall

unset $VIM_PYTHON3_SETUP

echo "Done!"
