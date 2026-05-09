#!/bin/bash

set -ouex pipefail

dnf5 install -y tmux
dnf5 install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release -y
dnf5 install -y mangowc gnome-keyring
dnf5 -y copr enable avengemedia/dms-git
dnf5 -y copr enable avengemedia/danklinux

dnf5 -y install dms dms-greeter foot quickshell-git 

systemctl enable podman.socket
systemctl enable greetd.service
