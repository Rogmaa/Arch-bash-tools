#!/bin/bash
# by Robin Alexander Studt (2024)

clear
echo " ____           _                 _  "
echo "|  _ \ _ __ ___| | ___   __ _  __| | "
echo "| |_) | '__/ _ \ |/ _ \ / _' |/ _' | "
echo "|  __/| | |  __/ | (_) | (_| | (_| | "
echo "|_|   |_|  \___|_|\___/ \__,_|\__,_| "
echo "                                      "
echo ""

# Confirm install
while true; do
    read -p "DO YOU WANT TO INSTALL PRELOAD? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
        break;;
        [Nn]* ) 
            exit;
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Install Preload
yay --noconfirm -S preload

echo "DONE!"