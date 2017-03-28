#!/bin/bash
#dd-wipe.sh
#Author: Alex Thomas
#Created 28 March 2017
#License to be set later
#This is a script to take an ubuntu live cd and use it to completely wipe a hard drive 
#with aes-256-CTR data. The script with enable the universe repo, install pv for a 
#progress bar, get the size of the drive for pv, then wipe the drive.
sudo -i 
add-apt-repository universe
apt-get update
apt-get -y install pv
disk_size=$(blockdev --getsize64 /dev/sda)
 openssl enc -aes-256-ctr -pass pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)" -nosalt </dev/zero \
    | pv -bartpes $disk_size | dd bs=64K of=/dev/sda
    