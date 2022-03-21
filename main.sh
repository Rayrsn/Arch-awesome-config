#!/bin/bash

#       ___           ___           ___           ___     
#      /\  \         /\  \         |\__\         /\  \    
#     /::\  \       /::\  \        |:|  |       /::\  \   
#    /:/\:\  \     /:/\:\  \       |:|  |      /:/\:\  \  
#   /::\~\:\  \   /::\~\:\  \      |:|__|__   /::\~\:\  \ 
#  /:/\:\ \:\__\ /:/\:\ \:\__\     /::::\__\ /:/\:\ \:\__\
#  \/_|::\/:/  / \/__\:\/:/  /    /:/~~/~    \/_|::\/:/  /
#     |:|::/  /       \::/  /    /:/  /         |:|::/  / 
#     |:|\/__/        /:/  /     \/__/          |:|\/__/  
#     |:|  |         /:/  /                     |:|  |    
#      \|__|         \/__/                       \|__|    


cd /tmp
# Install Packages
sudo pacman -S git lightdm feh vicious awesome nitrogen alacritty dmenu rofi pcmanfm

# Installing the fonts
git clone https://github.com/arcolinux/arcolinux-fonts
cd arcolinux-fonts
sudo cp -r ./usr/* /usr/
func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Fonts

list=(
awesome-terminal-fonts
adobe-source-sans-fonts
cantarell-fonts
noto-fonts
ttf-bitstream-vera
ttf-dejavu
ttf-droid
ttf-hack
ttf-inconsolata
ttf-liberation
ttf-roboto
ttf-ubuntu-font-family
tamsyn-font
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0

# Installing the configs
cd /tmp
git clone https://github.com/Rayrsn/arcolinux-awesome
cd arcolinux-awesome
mkdir -p ~/.config/awesome/rc/
sudo cp -r ./etc/skel/.config/awesome/* ~/.config/awesome/
echo 'awful.util.spawn("xrandr -s 1920x1080")' >> ~/.config/awesome/rc/rc.lua
echo 'awful.util.spawn("nitrogen --restore &")' >> ~/.config/awesome/rc/rc.lua

# Ask user if they want to install Arco Linux wallpapers
read -p "Do you want to install the Arco Linux wallpapers? (y/n) " -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd /tmp
    git clone https://github.com/arcolinux/arcolinux-wallpapers
    cd arcolinux-wallpapers
    sudo cp -r ./usr/* /usr/
