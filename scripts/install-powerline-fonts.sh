if [ -d ./powerline-fonts ];
then
    rm -rf ./powerline-fonts
fi
echo "Cloning Powerline Git Repo..."
git clone https://github.com/powerline/fonts.git powerline-fonts
cd ./powerline-fonts
bash install.sh
echo "Done!"
