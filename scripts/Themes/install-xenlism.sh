#Add GPG Key
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 90127F5B

#Add Repository To Source list

echo "deb http://downloads.sourceforge.net/project/xenlism-wildfire/repo deb/" | sudo tee -a /etc/apt/sources.list

#Update Repository And Intall
sudo apt-get update
sudo apt-get install xenlism-minimalism-theme


#install xenlism wildfire icons theme
#sudo apt-get install xenlism-wildfire-icon-theme xenlism-artwork-wallpapers