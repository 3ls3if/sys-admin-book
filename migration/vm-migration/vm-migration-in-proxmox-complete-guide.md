---
icon: desktop
---

# VM Migration in Proxmox (Complete Guide)

## VM Migration in Proxmox (Complete Guide)

This article explains **how to migrate virtual machines (VMs in Proxmox)** using **GUI and CLI methods**, covering **clustered**, **standalone**, and **offline/manual migration** scenarios.

It is suitable for:

* System administrators
* IT / security engineers
* Lab and production environments

***

### 1. What Is VM Migration in Proxmox?

VM migration is the process of moving a virtual machine from one Proxmox host to another. Depending on the setup, migration can be:

* **Live migration** (VM keeps running)
* **Offline migration** (VM is powered off)
* **Manual migration** (no cluster / no shared storage)

***

### 2. Types of Proxmox VM Migration

| Migration Type        | Requires Cluster | Requires Shared Storage | Downtime |
| --------------------- | ---------------- | ----------------------- | -------- |
| Live Migration        | Yes              | Yes                     | None     |
| Offline Migration     | Yes              | Optional                | Yes      |
| Backup & Restore      | No               | No                      | Yes      |
| Manual Disk Migration | No               | No                      | Yes      |

***

### 3. Live Migration (Cluster + Shared Storage)

#### Requirements

* Proxmox cluster configured
* Shared storage (NFS, iSCSI, Ceph, ZFS over iSCSI)
* Same CPU architecture
* Same Proxmox version (recommended)

***

#### GUI Method (Live Migration)

1. Select the VM
2. Click **Migrate**
3. Choose the **target node**
4. Enable **Online** migration
5. Click **Migrate**

The VM continues running during migration.

***

#### CLI Method (Live Migration)

```bash
qm migrate 100 node2 --online
```

***

### 4. Offline Migration (Cluster, No Shared Storage)

This method shuts down the VM and copies disks over the network.

***

#### GUI Method (Offline Migration)

1. Shut down the VM
2. Select **Migrate**
3. Choose the target node
4. Disable **Online migration**
5. Start migration

***

#### CLI Method (Offline Migration)

```bash
qm shutdown 100
qm migrate 100 node2
```

***

### 5. VM Migration Using Backup & Restore (Recommended for Standalone Hosts)

This is the **safest and cleanest method** when hosts are not clustered.

***

#### Step 1: Create a VM Backup (Source Host)

**GUI**

1. Select VM → **Backup**
2. Choose storage
3. Mode: **Stop** (recommended)
4. Compression: `zstd`
5. Click **Backup**

***

**CLI**

```bash
vzdump 100 --mode stop --compress zstd
```

Backups are stored in:

```
/var/lib/vz/dump/
```

***

#### Step 2: Transfer Backup to Destination Host

```bash
scp /var/lib/vz/dump/vzdump-qemu-100-*.zst root@node2:/var/lib/vz/dump/
```

***

#### Step 3: Restore VM on Destination Host

**GUI**

1. Go to **Datacenter → Storage → local → Backups**
2. Select backup file
3. Click **Restore**
4. Choose new VMID or keep original

***

**CLI**

```bash
qmrestore /var/lib/vz/dump/vzdump-qemu-100-*.zst 100
```

***

### 6. Manual VM Migration (No Cluster, No Backup)

Used when backup is not possible or disk-level access is required.

#### High-Level Process

```
LVM-thin disk → qcow2 file → copy → LVM-thin disk
```

***

#### GUI Method (Manual Disk Migration)

**Source Host**

1. Enable **Disk image** on `local` storage
2. VM → Hardware → Disk → **Move Disk**
3. Target: `local`, Format: `qcow2`

Disk appears at:

```
/var/lib/vz/images/VMID/
```

***

**Destination Host**

1. Create VM with same configuration
2. Delete auto-created disk
3. Copy qcow2 file using `rsync`
4. VM → Hardware → **Move Disk** → `local-lvm`

***

#### CLI Method (Manual Disk Migration)

```bash
# export disk
qemu-img convert /dev/pve/vm-100-disk-0 vm-100-disk-0.qcow2

# copy disk
scp vm-100-disk-0.qcow2 root@node2:/var/lib/vz/images/100/

# import disk
qm importdisk 100 vm-100-disk-0.qcow2 local-lvm
```

***

### 7. Common Migration Issues & Fixes

| Issue                | Cause          | Solution                    |
| -------------------- | -------------- | --------------------------- |
| VM won’t boot        | BIOS mismatch  | Match UEFI / SeaBIOS        |
| Network missing      | New MAC        | Update DHCP / static config |
| Windows disk missing | No VirtIO      | Install VirtIO drivers      |
| Slow migration       | No compression | Use `zstd`                  |

***

### 8. Best Practices

✔ Prefer **backup & restore** for standalone hosts\
✔ Use **live migration** only with shared storage\
✔ Match CPU type between nodes\
✔ Always test migration in staging\
✔ Keep Proxmox versions aligned

***

### 9. Migration Method Decision Guide

| Scenario                       | Best Method       |
| ------------------------------ | ----------------- |
| Production cluster             | Live migration    |
| Cluster without shared storage | Offline migration |
| Standalone hosts               | Backup & restore  |
| Disk-level recovery            | Manual migration  |

***

### 10. Summary

Proxmox provides flexible VM migration options:

* **Live migration** for zero downtime
* **Offline migration** for simple clusters
* **Backup & restore** for standalone nodes
* **Manual migration** for advanced scenarios

Choosing the correct method ensures **data safety, minimal downtime, and predictable results**.

***

_End of article_



***

## REFERENCES

* [https://www.bdrshield.com/blog/proxmox-vm-migration-a-step-by-step-guide-for-offline-migration-part-13/](https://www.bdrshield.com/blog/proxmox-vm-migration-a-step-by-step-guide-for-offline-migration-part-13/)
