# WHAT'S INCLUDED?
  Minimal Arch install, with usefull packages, feel free to change the package list to your needs.

# IMPORTANT THIS SCRIPT SUPPORTS 2-3 PARTITIONS. BUT ITS EASY TO MODIFY TO YOUR NEEDS.  
# !!! PLEASE MAKE SURE TO PREPARE THE SYSTEM BEFORE STARTING THE SCRIPTS !!!

1 - Load your desired keyboard layout = loadkeys de-latin1

2 - If your not using LAN, connect to your wifi = iwctl --passphrase [password of network] station wlan0 connect [name of network]

3 - Check for a sucessfull internet connection = ping -c4 'adress of target'

4 - Create partitions ("nvme0n1": this part can be different for your system, you might need to change it, to the right storage device.)
    gdisk /dev/nvme0n1
# Partition 1: +512M as 'ef00' -> (for EFI)
# Partition 2: Available space as '8300' (for linux filesystem)
Optional Partition 3 for VM for example or even as /home partition (not needed for this script to succeed)

5 - Sync your packages = pacman -Syy

6 - Install git (IMPORTANT: You might need to install archlinux keyring prior to that) = pacman -S git

7 - Clone the repo = git clone https://github.com/Rogmaa/Arch-bash-tools >> cd archinstall

8 - Start the script = ./1-archinstall.sh
