---
icon: layer-plus
---

# How to Backup and Restore Virtual Machines and Containers in Proxmox VE

### Types of Proxmox Backups

Proxmox supports backups for **VMs (QEMU/KVM)** and **Containers (LXC)**. These backups are always **full backups** (not incremental, unless you use **Proxmox Backup Server**).

#### Backup Modes

* **Snapshot (Recommended):** Uses storage snapshots (if supported). VM/CT runs with minimal downtime.
* **Suspend:** Pauses the VM/CT during backup and resumes after completion.
* **Stop:** Shuts down the VM/CT completely for a backup. Safest, but maximum downtime.

#### Backup Storage Options

Backups can be stored on:

* Local storage (`local`, `local-lvm`)
* NFS/SMB shares
* External drives
* Proxmox Backup Server (PBS) for deduplication, encryption, and incremental backups



***

### Backup via Proxmox Web GUI

#### Step 1: Open the Backup Panel

* Log into the **Proxmox Web GUI**.
* Select the **Datacenter**, then choose the **node** where your VM/CT runs.
* Go to **VM → Backup**.

#### Step 2: Start a Manual Backup

* Click **Backup now**.
* Choose the **storage target** (e.g., `local` or PBS).
* Select the **mode** (snapshot, suspend, stop).
* Choose the **compression method** (ZSTD is recommended for speed and efficiency).
* Click **Start**.

#### Step 3: Monitor Progress

You’ll see the backup log in real-time. Once completed, the backup file will be listed in the **Backup tab**.



***

## REFERENCES

* [https://www.saturnme.com/how-to-backup-and-restore-virtual-machines-and-containers-in-proxmox-ve/](https://www.saturnme.com/how-to-backup-and-restore-virtual-machines-and-containers-in-proxmox-ve/)
