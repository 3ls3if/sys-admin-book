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



***

## Explanation

You’re basically doing a **manual VM migration** between two **stand-alone Proxmox hosts** that use **LVM-thin** for VM disks and have **no cluster or shared storage**. Let me break this down conceptually first, then map it cleanly to the steps you described and explain _why each step is necessary_.

***

### 1. Why this is harder in “newer” Proxmox

#### Old Proxmox (file-based storage)

Earlier Proxmox setups commonly stored VM disks as:

```
/var/lib/vz/images/VMID/vm-VMID-disk-1.raw
```

or `qcow2`.

➡️ Result:\
You could just `scp` or `rsync` the file to another host and attach it.

***

#### New Proxmox (LVM-thin storage)

Now, most installs use **local-lvm (LVM-thin)** by default.

Key differences:

* VM disks are **logical volumes**, not files
* Stored under `/dev/pve/vm-VMID-disk-*`
* Managed entirely by LVM
* **Not directly copyable** with rsync/scp

➡️ Result:\
You must **convert LVM volumes into files**, transfer them, then **convert them back into LVM volumes**.

That’s exactly what your process does.

***

### 2. High-level idea of the migration

You’re doing this:

```
LVM volume (source)
   ↓
QCOW2 file (source)
   ↓ rsync/scp
QCOW2 file (destination)
   ↓
LVM volume (destination)
```

The Web UI steps are just a friendly wrapper around this conversion.

***

### 3. Understanding the SOURCE steps (proxmox #1)

#### 🔹 Why enable “Disk image” on `local`

By default:

* `local` → ISO, backups, templates
* `local-lvm` → VM disks

To temporarily store a **VM disk as a file**, Proxmox needs permission to store “Disk image” on `local`.

So:

```
Datacenter → Storage → local → Content → Disk image
```

This allows Proxmox to place VM disks in:

```
/var/lib/vz/images/VMID/
```

***

#### 🔹 Why “Move disk” → local (qcow2)

When you click **Move disk**:

* Proxmox exports the LVM-thin volume
* Converts it to a file format (`qcow2` or `raw`)
* Writes it to `local`

Internally, this is similar to:

```
qemu-img convert /dev/pve/vm-100-disk-1 vm-100-disk-1.qcow2
```

Result:

```
/var/lib/vz/images/VMID/vm-VMID-disk-1.qcow2
```

Now your VM disk is:

* Portable
* Copyable
* Independent of LVM

***

#### 🔹 Why “Delete source” is optional

If checked:

* Proxmox removes the original LVM volume\
  If unchecked:
* You must delete it manually later

Best practice: **delete source** once verified.

***

#### 🔹 Why disable “Disk image” afterward

You don’t want Proxmox accidentally storing VM disks on `local` long-term.\
`local-lvm` is optimized for VM disks (snapshots, performance).

***

### 4. Understanding the DESTINATION steps (proxmox #2)

#### 🔹 Why create a dummy VM first

Proxmox needs:

* A VMID
* A config file: `/etc/pve/qemu-server/VMID.conf`

Creating a VM:

* Generates the config
* Sets CPU, RAM, BIOS, NIC, etc.

⚠️ You **must match**:

* BIOS (SeaBIOS vs OVMF)
* Machine type (i440fx vs q35)
* Disk bus (SCSI / VirtIO)

Otherwise the VM may not boot.

***

#### 🔹 Why delete the auto-created disk

When you create the VM with a disk:

* Proxmox creates a placeholder qcow2 file\
  or
* LVM volume

You delete it because:

* You’re replacing it with the migrated disk
* Disk names must match:

```
vm-VMID-disk-1.qcow2
```

***

#### 🔹 Why copy into `/var/lib/vz/images/VMID/`

This is where Proxmox expects file-based disks on `local`.

Using:

```
rsync -avP vm-VMID-disk-1.qcow2 root@proxmox2:/var/lib/vz/images/VMID/
```

At this point:

* The VM is pointing to a file-based disk
* Still not ideal for production

***

#### 🔹 Why “Move disk” → local-lvm

This converts the file back into an LVM-thin volume:

```
qcow2 file
   ↓
/dev/pve/vm-VMID-disk-1
```

This gives you:

* Snapshots
* Better performance
* Standard Proxmox layout

After this step:

* The qcow2 file is removed
* The disk lives in `local-lvm`

***

#### 🔹 Why disable “Disk image” again

Same reason as source:

* Prevent accidental file-based disks
* Keep storage clean

***

### 5. What happens to snapshots, state, etc.

❌ **Snapshots are NOT migrated**

* LVM snapshots don’t survive export
* Only the **current disk state** is transferred

❌ **VM state (suspend)** is lost

* Must shut down the VM before migration

***

### 6. What could go wrong (important!)

#### Common boot failures

* Wrong disk controller (IDE vs VirtIO vs SCSI)
* BIOS mismatch (UEFI vs Legacy)
* Missing VirtIO drivers (Windows)

#### Network issues

* New MAC address → DHCP issues
* Static IPs may need adjustment

***

### 7. Easier alternatives (for future)

#### ✔ Option 1: vzdump + restore (recommended)

If both hosts run compatible Proxmox versions:

```bash
vzdump VMID --mode stop --compress zstd
scp /var/lib/vz/dump/vzdump-qemu-VMID*.zst proxmox2:/var/lib/vz/dump/
qmrestore vzdump-qemu-VMID*.zst VMID
```

✔ Preserves:

* VM config
* Disk layout
* Much safer

***

#### ✔ Option 2: `qm move_disk` via CLI

More control, same logic as UI.

***

### 8. Mental model (TL;DR)

Think of LVM-thin like a **sealed container**:

* You can’t copy it directly
* You must **export → move → import**
