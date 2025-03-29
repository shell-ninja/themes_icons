#!/bin/bash

# --------------- color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
magenta="\e[1;1;35m"
cyan="\e[1;36m"
orange="\e[1;38;5;214m"
end="\e[1;0m"


# check if parallel is installed
if sudo pacman -Q parallel &> /dev/null || rpm -q parallel &> /dev/null || sudo zypper se -i parallel &> /dev/null; then
    printf "${cyan}[ * ]${end} - parallel is installed already, proceesing to the next step..."
else
    if [[ -n "$(command -v pacman)" ]]; then
        sudo pacman -S parallel --noconfirm
    elif [[ -n "$(command -v dnf)" ]]; then
        sudo dnf install parallel -y
    elif [[ -n "$(command -v zypper)" ]]; then
        sudo zypper in parallel -y
    fi
fi

echo

dir="$(dirname "$(realpath "$0")")"
icons="$dir/icons"
themes="$dir/themes"


mkdir -p "$HOME/.icons"
mkdir -p "$HOME/.themes"
# extracting themes and icons
parallel --bar "tar xzf {} -C ~/.icons/ --strip-components=1" ::: $icons/*.tar.gz
parallel --bar "tar xzf {} -C ~/.themes/ --strip-components=1" ::: $themes/*.tar.gz

#______________\\==//______________#
