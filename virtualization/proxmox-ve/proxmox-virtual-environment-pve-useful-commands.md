---
icon: rectangle-terminal
---

# Proxmox Virtual Environment (PVE) – Useful Commands

### **Proxmox Virtual Environment (PVE) – Useful Commands Summary**

#### **1. Cluster and Node Status**

*   **Check Cluster Status:**

    ```bash
    pvecm status
    ```

    * Shows connected nodes and their IDs.
*   **Check Node Resources:**

    ```bash
    pveperf
    ```

    * Displays CPU, disk, seek time, file sync time, DNS, etc.

***

#### **2. Virtual Machines (QEMU) Management**

*   **List VMs:**

    ```bash
    qm list
    ```
*   **Start a VM:**

    ```bash
    qm start <vmid>
    ```
*   **Stop a VM:**

    ```bash
    qm stop <vmid>
    ```
*   **Reboot a VM:**

    ```bash
    qm reboot <vmid>
    ```
*   **Clone a VM:**

    ```bash
    qm clone <source_vmid> <new_vmid>
    ```
*   **View VM Configuration:**

    ```bash
    qm config <vmid>
    ```
*   **Restore VM from Backup:**

    ```bash
    qmrestore <backup_file_path> <vmid>
    ```

***

#### **3. Container (LXC) Management**

*   **List Containers:**

    ```bash
    pct list
    ```
*   **Enter Container Shell:**

    ```bash
    pct enter <ctid>
    ```

***

#### **4. Backup and Restore**

*   **Backup a VM:**

    ```bash
    vzdump <vmid>
    ```

    * Creates a backup file under `/var/lib/vz/dump/`
*   **View Backup Logs:**

    ```bash
    cat <backup_log_file>
    ```

***

#### **5. Disk and Storage Management**

*   **List Block Devices:**

    ```bash
    lsblk
    ```
*   **Check Disk Usage (Human-readable):**

    ```bash
    df -h
    ```
*   **Check Memory Usage:**

    ```bash
    free -h
    ```
*   **Check Storage Status:**

    ```bash
    pvesm status
    ```
*   **Add New Storage:**

    ```bash
    pvesm add <type> <args>
    ```

    * Refer to storage tutorial for detailed syntax.

***

#### **6. Network and Logs**

*   **Check IP Address:**

    ```bash
    ip a
    ```
*   **View System Logs:**

    ```bash
    journalctl -xe
    ```

***

#### **7. System Updates**

*   **Update Package List:**

    ```bash
    apt update
    ```
*   **Upgrade Packages:**

    ```bash
    apt upgrade
    ```

***

#### **Tips**

* The Web UI uses the same backend commands.
* Learning CLI gives you more control and access to advanced features.
* Practice basic commands before moving to advanced operations.
