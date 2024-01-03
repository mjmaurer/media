This is the best resource for working with LVM disk management:
https://www.digitalocean.com/community/tutorials/how-to-use-lvm-to-manage-storage-devices-on-ubuntu-18-04#step-2-creating-or-extending-lvm-components

Each disk is a physical volume (/dev/sda disk is 2TB SSD).
There is a single volume group "vgubuntu" with all physical volumes.
I created a logical volume called "media" for media purposes.

Use `sudo pvdisplay` to get PV info.