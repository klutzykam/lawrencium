#!/bin/bash

set -ouex pipefail
pacman-key --init
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com 
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm >> /dev/null
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm >> /dev/null
echo -e "\n[chaotic-aur]\n Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf 

pacman -Syu bash bash-completion curl gcc nano tar unzip efibootmgr plasma plasma-login-manager konsole dolphin pipewire wireplumber chaotic-aur/opentabletdriver flatpak lvm2 tpm2-tss nvidia-open nvidia-utils --noconfirm

echo "enable my login manager pls thx much love"
systemctl enable plasmalogin