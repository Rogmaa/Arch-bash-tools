#!/bin/bash
clear
echo "    _             _       ___           _        _ _ "
echo "   / \   _ __ ___| |__   |_ _|_ __  ___| |_ __ _| | |"
echo "  / _ \ | '__/ __| '_ \   | || '_ \/ __| __/ _' | | |"
echo " / ___ \| | | (__| | | |  | || | | \__ \ || (_| | | |"
echo "/_/   \_\_|  \___|_| |_| |___|_| |_|___/\__\__,_|_|_|"
echo ""
echo "by Robin Alexander Studt (2024)"
echo "-----------------------------------------------------"
echo ""
echo "Important: You will need to setup a few manual steps, please check out the README file"
echo "this script is still worked on, use it on your own risk."

# Enter partition names
lsblk
read -p "Enter the name of your EFI partition: " nvme0n1p1
read -p "Enter the name of the ROOT partition: " nvme0n1p2
#read -p "Enter the name of the _ partition(keep it commented if not needed!): " nvme0n1p3

# Sync local time
timedatectl set-ntp true

# Format partitions, nvme0n1p3 only needed if you use line 19
mkfs.fat -F 32 /dev/$nvme0n1p1;
mkfs.btrfs -f /dev/$nvme0n1p2;
#mkfs.btrfs -f /dev/$nvme0n1p3

# Mount points for btrfs
mount /dev/$nvme0n1p2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@log
umount /mnt

mount -o compress=zstd:1,noatime,subvol=@ /dev/$nvme0n1p2 /mnt
mkdir -p /mnt/{boot/efi,home,.snapshots,var/{cache,log}}
mount -o compress=zstd:1,noatime,subvol=@cache /dev/$nvme0n1p2 /mnt/var/cache
mount -o compress=zstd:1,noatime,subvol=@home /dev/$nvme0n1p2 /mnt/home
mount -o compress=zstd:1,noatime,subvol=@log /dev/$nvme0n1p2 /mnt/var/log
mount -o compress=zstd:1,noatime,subvol=@snapshots /dev/$nvme0n1p2 /mnt/.snapshots
mount /dev/$nvme0n1p1 /mnt/boot/efi
#mkdir /mnt/'optional_partition' <-- Options for third partition, change name and uncomment if needed.
#mount /dev/$nvme0n1p3 /mount/'optional_partition' <-- same goes for this line if needed, adapt it.
# Install base packages, change ucode for your CPU..
pacstrap -K /mnt base base-devel git linux linux-firmware vim openssh reflector rsync amd-ucode
# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

# Install configuration scripts
mkdir /mnt/archinstall
cp 2-config.sh /mnt/archinstall/
cp 3-yay.sh /mnt/archinstall/
cp 4-zram.sh /mnt/archinstall/
cp 5-timeshift.sh /mnt/archinstall/
cp 6-preload.sh /mnt/archinstall/
cp snapshot.sh /mnt/archinstall/

# Chroot to installed sytem
arch-chroot /mnt ./archinstall/2-config.sh
