---
icon: album-circle-user
---

# Attaching One Proxmox VM Disk to Another VM

## Attaching One Proxmox VM Disk to Another VM

This article explains **how to attach an existing Proxmox VM disk to another VM as an additional disk**, using both **GUI (Web Interface)** and **CLI (command line)** methods.

The guide applies to **standalone Proxmox servers** (no cluster, no shared storage) and focuses primarily on the default **LVM-thin (`local-lvm`) storage**, while also covering **file-based storage (`local`, qcow2/raw)**.

***

### Important Concepts (Read First)

#### 1. A disk can only be attached to **one running VM at a time**

* Attaching the same disk to two running VMs **will corrupt the filesystem**.
* You must **power off** VMs before detaching or attaching disks.

#### 2. Disk types in Proxmox

| Storage     | Disk Type               | Example Location          |
| ----------- | ----------------------- | ------------------------- |
| `local-lvm` | LVM-thin logical volume | `/dev/pve/vm-100-disk-0`  |
| `local`     | File-based (qcow2/raw)  | `/var/lib/vz/images/100/` |

The procedure depends on where the disk is stored.

***

### Scenario 1: Attach an LVM-thin Disk (`local-lvm`) to Another VM (Recommended)

This is the **most common and safest scenario**.

#### Example

* VM **100** → Source disk
* VM **200** → Destination VM

***

### GUI Method (Web Interface)

#### Step 1: Shut down both VMs

**From the Proxmox Web UI:**

* Select **VM 100** → Shutdown
* Select **VM 200** → Shutdown

> ⚠️ **This step is mandatory.**

***

#### Step 2: Detach disk from VM 100

1. Select **VM 100**
2. Go to **Hardware**
3. Select the disk (e.g. `scsi0`)
4. Click **Detach**
5. **Do NOT select Delete**

The disk now exists but is unused.

***

#### Step 3: Attach disk to VM 200

1. Select **VM 200**
2. Go to **Hardware → Add → Existing Disk**
3. Choose:
   * **Storage:** `local-lvm`
   * **Disk:** `vm-100-disk-0`
   * **Bus/Device:** `VirtIO SCSI` (recommended)
4. Click **Add**

***

#### Step 4: Start VM 200 and mount the disk

Inside the guest OS:

```bash
lsblk
```

Example output:

```
sda    50G  (system)
sdb    100G (attached disk)
```

Mount the disk:

```bash
mkdir /mnt/attached_disk
mount /dev/sdb1 /mnt/attached_disk
```

***

### CLI Method (Faster & Scriptable)

#### Step 1: Shut down both VMs

```bash
qm shutdown 100
qm shutdown 200
```

***

#### Step 2: Detach disk from VM 100

```bash
qm set 100 --delete scsi0
```

***

#### Step 3: Attach disk to VM 200

```bash
qm set 200 --scsi1 local-lvm:vm-100-disk-0
```

You can verify:

```bash
qm config 200
```

***

#### Step 4: Start VM 200

```bash
qm start 200
```

Mount the disk inside the guest OS as shown earlier.

***

### Scenario 2: Attach a File-Based Disk (`local`, qcow2/raw)

#### GUI Method

1. Shut down both VMs
2. Detach disk from source VM (do not delete)
3. Destination VM → **Hardware → Add → Existing Disk**
4. Select:
   * **Storage:** `local`
   * **Disk:** `vm-100-disk-0.qcow2`
5. Start the VM

***

#### CLI Method

```bash
qm shutdown 100
qm shutdown 200
qm set 100 --delete scsi0
qm set 200 --scsi1 local:100/vm-100-disk-0.qcow2
qm start 200
```

***

### Scenario 3: Copy the Disk Instead of Moving It (Safer)

If you want **VM 100 to keep its disk**, create a copy.

#### Clone an LVM-thin disk

```bash
lvcreate -s -n vm-100-disk-0-copy /dev/pve/vm-100-disk-0
qm set 200 --scsi1 local-lvm:vm-100-disk-0-copy
```

***

#### Copy a qcow2 disk

```bash
cp /var/lib/vz/images/100/vm-100-disk-0.qcow2 \
   /var/lib/vz/images/200/vm-200-disk-1.qcow2

qm set 200 --scsi1 local:200/vm-200-disk-1.qcow2
```

***

### Common Problems & Solutions

| Problem              | Cause            | Fix                |
| -------------------- | ---------------- | ------------------ |
| VM won’t boot        | BIOS mismatch    | Match SeaBIOS/UEFI |
| Disk not visible     | Wrong bus type   | Use VirtIO SCSI    |
| Filesystem errors    | Dirty shutdown   | Run `fsck`         |
| Windows disk missing | No VirtIO driver | Install VirtIO ISO |

***

### Best Practices

✔ Always power off before attaching disks\
✔ Use **VirtIO SCSI** for best performance\
✔ Prefer **cloning** over moving for safety\
✔ Never share a writable disk between running VMs\
✔ Use NFS/SMB if you need shared data

***

### Summary

* Proxmox disks can be safely reattached between VMs
* `local-lvm` disks are easiest to manage
* GUI and CLI methods achieve the same result
* Disk copying is safer than disk moving

This method is commonly used for **data recovery, VM consolidation, forensics, and migration workflows**.

***

_End of article_
