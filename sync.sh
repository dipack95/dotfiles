dateCmd="date --iso-8601=seconds"
cp -Rv ~/.zshrc ~/Dotfiles/.zshrc
cp -Rv ~/.bashrc ~/Dotfiles/.bashrc
cp -Rv ~/.vimrc ~/Dotfiles/.vimrc
git add .
git commit -am "Synced on $dateCmd"
git push -u origin master
