#!/bin/bash
# by Robin Alexander Studt (2024)

clear
echo "__   __ _ __   __"
echo "\ \ / // \\ \ / /"
echo " \ V // _ \\ V / "
echo "  | |/ ___ \| |  "
echo "  |_/_/   \_\_|  "
echo "                 "
echo ""

while true; do
    read-p "START YAY INSTALLATION NOW? (Y/N): " yn
    case $yn in
        [Yy]* )
            echo "install started."
        break;;
        [Nn]* )
            exit;;
        break;;
        * ) echo "Please answer yes or no";;
    esac
done
git clone https://aur.archlinux.org/yay/git.git
cd yay-git
makepkg -si

echo "DONE!"