#!/bin/bash

# kill the running VM... this assumes you're only
# running one VM as you, so proceed with caution
# if that isn't the case.
ps -ef | grep qemu | grep ^`whoami` | grep -v grep | awk '{print $2}' | xargs kill

