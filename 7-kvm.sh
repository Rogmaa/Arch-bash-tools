#!/bin/bash
# by Robin Alexander Studt (2024)

Echo " _  ____     ____  __ " 
Echo "| |/ /\ \   / /  \/  |"  
Echo "| ' /  \ \ / /| |\/| |"  
Echo "| . \   \ V / | |  | |"  
Echo "|_|\_\   \_/  |_|  |_|"  
Echo "                      "  

# Init install
while true; do
    read -p "DO YOU WANT TO INSTALL KVM? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo "START KVM/QEMU/VIRT MANAGER INSTALLATION."
        break;;
        [Nn]* ) 
            exit;
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Install packages
sudo pacman -S virt-manager virt-viewer qemu vde2 ebtables iptables-nft nftables dnsmasq bridge-utils ovmf swtpm

# Edit libvirtd.conf
echo "Manual steps required:"
echo "Open sudo vim /etc/libvirt/qemu.conf"
echo "Uncomment and add your user name to user and group."
echo 'user = "your username"'
echo 'group = "your username"'
read -p "Press any key to open qemu.conf: " c
sudo vim /etc/libvirt/qemu.conf

# Restart services
sudo systemctl restart libvirtd

# Autostart network
sudo virsh net-autostart default

echo "Reboot your system to apply changes."