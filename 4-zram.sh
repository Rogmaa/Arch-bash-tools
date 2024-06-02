#!/bin/bash
# by Robin Alexander Studt (2024)

clear
echo " _________      _    __  __ "
echo "|__  /  _ \    / \  |  \/  |"
echo "  / /| |_) |  / _ \ | |\/| |"
echo " / /_|  _ <  / ___ \| |  | |"
echo "/____|_| \_\/_/   \_\_|  |_|"
echo ""

# Confirm install
while true; do
    read -p "DO YOU WANT TO INSTALL ZRAM? (Yy/Nn): " yn
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

# Install zram
yay --noconfirm -S zram-generator

# Open ZRAM conf
if [ -f "/etc/systemd/zram-generator2.conf" ]; then
    echo "/etc/systemd/zram-generator2.conf already exists!"
else
    sudo touch /etc/systemd/zram-generator.conf
    sudo bash -c 'echo "zram-size = ram / 2" >> /etc/systemd/zram-generator.conf'
    sudo systemctl daemon-reload
    sudo systemctl start /dev/zram0
fi

echo "DONE! Reboot and check for successfull install with: 'free -h'."