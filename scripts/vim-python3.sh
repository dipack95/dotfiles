#!/bin/bash
function makeBuildDir() {
    if [ ! -d ./vim-build/ ]; then
        mkdir -p ./vim-build
    fi
    cd ./vim-build
}

function cloneGitRepo() {
    echo "Cloning VIM git repository"
    git clone https://github.com/vim/vim.git vim-git
    cd ./vim-git
}

function setup() {
    VIM_PYTHON3_SETUP="$(python3-config --configdir)"
    VIM_VERSION="$(head -1 README.txt | sed -r 's/[^0-9]//g')"
    echo "Python 3 Config directory is: " $VIM_PYTHON3_SETUP
    ./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-python3interp --with-python3-config-dir=$VIM_PYTHON3_SETUP --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=/usr
    make VIMRUNTIMEDIR=/usr/share/vim/vim80
    echo "Using checkinstall to build and install custom VIM"
    sudo checkinstall --pkgname=vim-py3 --pkgversion=$VIM_VERSION-git --provides=vim
    unset $VIM_PYTHON3_SETUP
}

echo "Getting prerequisites for this build..."

INSTALLER=""
if command -v apt-get; then
    INSTALLER="apt-get";
fi

sudo $INSTALLER install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git

echo "Starting VIM Python 3 build";

makeBuildDir()
cloneGitRepo()
setup()

echo "Done!";
