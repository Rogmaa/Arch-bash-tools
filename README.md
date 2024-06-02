# MyArchTools, Bash scripts which make my life easier.
# Follow those steps before using the arch install script!

# Load your preffered keyboard layout (simply swap 'de' with any language of your choice..
loadkeys de-latin1

# Increase the font size to ease the work for your eyes. (optional)
setfont ter-p20b

# Connect to LAN or WLAN (Following step is for WLAN0)
iwctl --passphrase [password of network] station wlan0 connect [name of network]

# Check for a sucessfull internet connection. (-c4 limits the ping command to do only 4 repititions)
ping -c4 'adress of target'

# Check partitions. (IMPORTANT: This setup only supports 2 Partitions at the moment - EFI and Filesystem)
# If you have more then 2 Partitions please delete all existing partitions (after backing up your data ofcourse)
lsblk

# Create partitions ("nvme0n1": this part can be different for your system, you might need to change it, to the right storage device.)
gdisk /dev/nvme0n1
# Partition 1: +512M as 'ef00' -> (for EFI)
# Partition 2: Available space as '8300' (for linux filesystem)
#Optional Partition 3 for VM for example or even as /home partition (not needed for this script to succeed)

# Sync your packages!
pacman -Syy

# Install git (IMPORTANT: You might need to install archlinux keyring prior to that)
pacman -S git

# Clone the repo 
git clone 'my-link'
cd archinstall

# Start the script
./1-archinstall.sh
