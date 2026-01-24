---
icon: arrow-u-turn-up-left
---

# Migrate and attach existing disk of a VM to another VM on remote machine

{% hint style="warning" %}
There are 2 physical servers with Proxmox (Proxmox-ve 4.2) installed on them, each one handles few VMs and containers. These servers are (almost) completely isolated and there is no cluster/shared storage/additional storage, etc. between them.

A VM has been setup and configured it's OS and application(s) on proxmox#1 but it should be moved to proxmox#2. In prior versions of Proxmox, it was as easy as moving the VM's disk image to another server using rsync or scp. But in recent versions of Proxmox, storage for storing VM's disk are completely separated with parent host using lvmthin and there is a logical volume for every single VM, state, snapshot, etc.
{% endhint %}

## Steps

**On source (proxmox #1):**

First, you have to use "Move disk" in order to get access to VM's disk as a raw or qcow2 file. Using web interface, go to `Datacenter` --> `Storage` and select `local`. Click `Edit`and in `Content` drop down, select `Disk image` ("Iso image", "Container template" and "VZDump backup file" are already selected). Put "Max Backups" 0 or 1 if `OK` button is disabled. Then `select your VM` on the left, go to `Hardware` tab, select `Hard Disk` and click `Move disk`. On `Target Storage` of the pop-up box, select `local` and choose appropriate `Format`. "QEMU image format(qcow2)" is OK in this case. You can check "Delete source" or delete it manually later (this is suggested). Finally click `Move disk` and after few minutes, your VM disk is ready. It's dumped in `/var/lib/vz/images/VMID/`. When you are done, unselect `Disk image` from `Datacenter --> Storage`, select `local` and click `OK`.



**On destination (proxmox #2):**

Using web interface, go to `Datacenter --> Storage` and select `local`. Click `Edit`and in `Content` drop down, select `Disk image` ("Iso image", "Container template" and "VZDump backup file" are already selected). Put "Max Backups" 0 or 1 if `OK` button is disabled. Then `create a VM` with the same specifications you had on source server, but select `local` from drop down in `Storage` section of `Hard Disk` tab. Do not turn on the machine. Go to `/var/lib/vz/images/VMID/` and `remove vm-VMID-disk-1.qcow2`. Move image dumped on source server (proxmox #1) to destination server (proxmox #2) '/var/lib/vz/images/VMID/' with `vm-VMID-disk-1.qcow2` name using `rsync` or similar tools.

`Select your VM` on the left, go to `Hardware` tab, select `Hard Disk` and click `Move disk`. On `Target Storage` of the pop-up box, select `local-lvm` and choose appropriate `Format`. When you are done, unselect `Disk image` from `Datacenter --> Storage`, select `local` and finally click `OK`.

**Turn on the VM!**
