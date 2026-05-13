#!/bin/bash

set -ouex pipefail

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "\n[chaotic-aur]\n Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

sudo pacman -Syu base bash bash-completion curl gcc git nano tar unzip linux nvidia-open nvidia-utils efibootmgr linux-firmware plasma plasma-login-manager konsole dolphin pipewire wireplumber udev ostree --no-confirm