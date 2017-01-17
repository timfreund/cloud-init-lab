# Lab Exercise: cloud-init

[cloud-init](https://cloudinit.readthedocs.io) is often installed in
Linux system images built for use within cloud computing platforms.

This repository contains scripts to streamline the process of
experimenting with cloud-init configurations locally on any Linux
system.  I hope that the speed of iteration this enables will help
users get comfortable with cloud-init and begin using it during cloud
deployments.

## Usage

First things first.  Install prerequisite programs and download the
latest Ubuntu Xenial disk image:

    $ ./init.sh

Next customize the userdata.txt file.

And finally boot the system:

    $ ./boot.sh

The `boot.sh` script boots the system with no GUI and instead redirects
input and output from your current terminal session.  If you'd rather
have a separate window that contains the virtual machine, remove the `-nographic`
option from `boot.sh`.

Ubuntu system images come with a default user named `ubuntu`, and we've set the
password to a completely terrible value of `thisisterrible`.  Log in with that
combination to poke around once the system boots.

## Resetting the data

If you want to get a clean slate, just remove the file named
`my-xenial-server-cloudimg-amd64-disk1.img`.  It's a lightweight disk
image built on top of the upstream image, and it will be recreated
from scratch the next time you boot.
