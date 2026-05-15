#!/bin/bash

set -ouex pipefail
pacman-key --init
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com 
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm >> /dev/null
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm >> /dev/null
echo -e "\n[chaotic-aur]\n Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf 

#pacman -R linux --noconfirm >> /dev/null
pacman -Syu nvidia-open nvidia-utils --noconfirm >> /dev/null
pacman -Syu curl gcc sudo nano noto-fonts noto-fonts-cjk noto-fonts-emoji tar unzip efibootmgr plasma plasma-login-manager konsole dolphin pipewire wireplumber chaotic-aur/opentabletdriver flatpak lvm2 tpm2-tss dhcpcd fastfetch --noconfirm
pacman -Syu git podman podman-compose distrobox udiskie udisks2 firewalld networkmanager libmtp --noconfirm >> /dev/null

#copied from tartaria will replace / understand later...
KERNEL_VERSION="$(basename "$(find /usr/lib/modules -maxdepth 1 -type d | grep -v -E "\.img$" | tail -n 1)")"
DRACUT_NO_XATTR=1 dracut --force --no-hostonly --reproducible --zstd --verbose --add ostree "/usr/lib/modules/$KERNEL_VERSION/initramfs.img"

echo "Enable Systemd services."
systemctl enable \
    plasmalogin.service \
    NetworkManager.service \
    firewalld.service   \
    systemd-resolved.service 
systemctl enable --global opentabletdriver.service
