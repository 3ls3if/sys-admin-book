---
icon: usb-drive
---

# Prepare Installation Media

Copy the Proxmox ISO image on a CD/DVD or a USB flash drive. Although both options are possible, it is assumed that most systems don't have an optical drive.

Plug in the USB drive and copy the ISO image to the USB stick using the command line or a USB formatting utility (such as [Etcher](https://phoenixnap.com/kb/etcher-ubuntu) or Rufus).

**Note:** Back up and remove any data on the device as the process will erase any previously stored data.

If you are working on [Linux](https://phoenixnap.com/kb/what-is-linux), the fastest way to create a bootable USB is to use the following syntax:

```
dd bs=1M conv=fdatasync if=./proxmox-ve_*.iso of=/device/nameCopy
```

Modify the file name and path in **`if=./proxmox-ve_*.iso`** and make sure to provide the correct USB device name in **`of=/device/name`**.

To find the name of your USB stick, run the following command before and after plugging in the device:

```
lsblkCopy
```

Compare the output. The additional entry in the second output is the name of the device.
