---
icon: album-circle-plus
---

# Troubleshooting Disk Partitioning Issues on C: Drive

### Introduction

Disk partitioning is a common administrative task, whether for organizing data, improving system management, or preparing servers for specific workloads. However, while attempting to shrink the **C:** drive in Windows to create a new partition, administrators may encounter a frustrating error:

> **“You do have free space, but Windows cannot shrink it because of unmovable system files near the end of the C: drive.”**

This error occurs even when the drive clearly shows sufficient free space. The root cause is typically the presence of system files that Windows cannot move automatically. This article explains why this happens and provides a step-by-step approach to safely resolve the issue.



<figure><img src="../../.gitbook/assets/image (121).png" alt=""><figcaption></figcaption></figure>

***

### Understanding the Problem

Windows Disk Management can only shrink a volume up to the point where the **last unmovable file** is located. These files often include:

* Page file (pagefile.sys)
* Hibernation file (hiberfil.sys)
* System restore data
* NTFS metadata
* CryptoAPI RSA key containers

When such files exist near the end of the disk, Windows prevents further shrinking, even if large amounts of free space are available elsewhere.

***

### Step 1: Verify Settings and Prepare the System

Before making any changes:

* Ensure you are logged in with **administrator privileges**.
* Confirm that sufficient free space exists on the C: drive.
* Take a **backup or snapshot** (especially on production servers).
* Schedule downtime if the system is critical, as restarts are required.

Preparation reduces the risk of data loss and ensures changes can be safely applied.

***

### Step 2: Disable the Page File Temporarily

The page file is one of the most common unmovable files preventing disk shrinking.

#### Steps:

1. Right-click **This PC** → **Properties**
2. Click **Advanced system settings**
3. Under **Performance**, click **Settings**
4. Go to **Advanced** → **Virtual Memory** → **Change**
5. Uncheck **Automatically manage paging file size for all drives**
6. Select **C:** → choose **No paging file** → click **Set**
7. Restart the system

Disabling the page file allows Windows to relocate disk data more effectively.

***

### Step 3: Defragment the Drive

Defragmentation consolidates free space and moves files toward the beginning of the disk.

#### Command:

Open **Command Prompt (Run as Administrator)** and execute:

```cmd
defrag C: /X
```

#### What this does:

* Moves files to consolidate free space
* Attempts to free contiguous space at the end of the volume
* Increases the maximum shrinkable size

> Note: This step is most effective on HDDs. On SSDs, Windows performs optimization differently, but the command is still safe.

***

### Step 4: Check Event Viewer for Errors

If shrinking the volume still fails:

* Open **Event Viewer**
* Navigate to **Windows Logs → System**
* Look for warnings or errors related to:
  * Disk
  * NTFS
  * Volsnap
  * Partition or storage drivers

These logs can reveal underlying issues such as file system corruption or driver-related problems that block disk operations.

***

### Step 5: Remove Problematic CryptoAPI RSA Key Containers

In some cases, unmovable system files are caused by CryptoAPI RSA key containers stored under the LocalService profile.

#### Location:

```
C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\Microsoft\Crypto\RSA
```

#### Action:

* Navigate to the directory
* Remove the files inside the **RSA** folder

⚠ **Important Warning**:

* These files store encryption keys used by Windows services
* Removing them may reset certain cryptographic keys
* Always back up the directory before deletion, especially on domain controllers or certificate authorities

This step has proven effective in cases where Disk Management reports unmovable files despite other optimizations.

***

### Step 6: Restart the Server

After completing all changes:

* Restart the system to release file locks
* Allow Windows to rebuild required system files

Once the server is back online, retry shrinking the C: drive using **Disk Management**.

***

### Final Summary

The “unmovable system files” error during disk shrinking is a common Windows limitation rather than a lack of free space. By following a structured approach:

* Temporarily disabling the page file
* Defragmenting the disk
* Reviewing system logs
* Removing problematic CryptoAPI key containers
* Restarting the system

administrators can successfully shrink the C: drive and create new partitions without reinstalling the OS or using third-party tools.

This method is especially useful for **system administrators, IT engineers, and security teams** managing Windows servers and workstations.

***

