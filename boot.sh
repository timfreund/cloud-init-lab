#!/bin/bash

IMAGE_NAME=xenial-server-cloudimg-amd64-disk1.img

rm -f userdata.img
# Always create a new instance-id:  reusing an instance-id results
# in skipping the application of userdata settings when also reusing
# a disk image that has previously booted with that instance-id
echo "instance-id: $(uuidgen)" > metadata.txt
cloud-localds userdata.img userdata.txt metadata.txt

# The upstream image is a QCOW2 formatted disk image, and QCOW == QEMU
# Copy On Write.  That means we can make a new disk image that uses
# the upstream image as a base.  The linked image starts off small
# (less than 200K) and only grows as we add/change things.
if [ ! -e "my-${IMAGE_NAME}" ]
then
    qemu-img create -f qcow2 -b ${IMAGE_NAME} my-${IMAGE_NAME}
fi

qemu-system-x86_64 -machine accel=kvm -m 512 \
                   -drive file=my-${IMAGE_NAME} \
                   -cdrom userdata.img -nographic \
                   -device e1000,netdev=network0,mac=52:55:00:d1:55:09 \
                   -netdev tap,id=network0,ifname=tap0,script=no,downscript=no
