#!/bin/bash

function install_prereqs {
    echo "Installing prerequisites, sudo password request coming soon"
    sudo apt-get install -y cloud-image-utils curl qemu-system-x86 libguestfs-tools qemu-utils
}

install_prereqs
