#!/bin/bash

BASE_URL=https://cloud-images.ubuntu.com/xenial/current
IMAGE_NAME=xenial-server-cloudimg-amd64-disk1.img

function install_prereqs {
    apt-get install -y cloud-image-utils curl qemu-system-x86 libguestfs-tools qemu-utils
}

# function configure_network {
#     tunctl -u `whoami`
#     sudo ip link set tap0 master vibr0
# }

function download_latest {
    latest_md5=`curl -s ${BASE_URL}/MD5SUMS | grep ${IMAGE_NAME} | awk '{print $1}'`
    if [ -e ${IMAGE_NAME} ]
    then
        local_md5=`md5sum ${IMAGE_NAME} | awk '{print $1}'`
        if [ $latest_md5 == $local_md5 ]
        then
            echo "We have the latest image already"
            return
        fi
    fi

    curl -o ${IMAGE_NAME} ${BASE_URL}/${IMAGE_NAME}
    chmod 444 ${IMAGE_NAME}

    if [ -e "my-${IMAGE_NAME}" ]
    then
        rm "my-${IMAGE_NAME}"
    fi
    
    
}

install_prereqs
download_latest
