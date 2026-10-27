---
icon: calendar-check
---

# Automating Weekly MS SQL Database Backups Using PowerShell and Task Scheduler

### Step 1: Understand the Goal

In this tutorial, you will create an automated solution that:

* Takes a **full backup** of a specific MS SQL Server database
* Stores backups in a folder
* Keeps **only the latest 5 backups**
* Automatically deletes the **oldest backup** when a new one is created
* Runs **every Sunday** using Windows Task Scheduler

This solution works well even on **SQL Server Express**, where SQL Agent is not available.

***

### Step 2: Prerequisites

Before starting, make sure you have:

* Microsoft SQL Server installed
* PowerShell 5.1 or later
* Permission to back up the SQL database
* Write access to the backup folder
* `SqlServer` PowerShell module installed

To install the SQL module (run PowerShell as Administrator):

```powershell
Install-Module SqlServer -Scope AllUsers
```

***

### Step 3: Create the Backup Folder

Decide where the backup files will be stored, for example:

```
C:\SQLBackups
```

Make sure this folder exists and the scheduled task account has **write permissions**.

***

### Step 4: Create the PowerShell Backup Script

Open Notepad or PowerShell ISE and paste the following script.

Save the file as:

```
C:\SQLScripts\WeeklySqlBackup.ps1
```

```powershell
# -------------------------------
# Configuration
# -------------------------------
$SqlServer  = "localhost"
$Database   = "ARMCPA_DATA".Trim()  # Trim extra spaces
$BackupPath = "C:\SQLBackups"  # Ensure this is correct with no spaces
$MaxBackups = 5

# Ensure backup folder exists
if (!(Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath
}

# Get existing backups
$ExistingBackups = Get-ChildItem $BackupPath -Filter "$Database*.bak" |
                   Sort-Object LastWriteTime

# Delete oldest backups if limit exceeded
if ($ExistingBackups.Count -ge $MaxBackups) {
    $FilesToDelete = $ExistingBackups | 
                     Select-Object -First ($ExistingBackups.Count - $MaxBackups + 1)
    foreach ($file in $FilesToDelete) {
        Remove-Item $file.FullName -Force
    }
}

# Determine backup number
$BackupNumber = (Get-ChildItem $BackupPath -Filter "$Database*.bak").Count + 1
if ($BackupNumber -gt $MaxBackups) { $BackupNumber = $MaxBackups }

# Create backup file name without extra spaces
$Date = Get-Date -Format "yyyy-MM-dd"
$BackupFile = "$BackupPath\$Database" + "_" + $Date + "_" + $BackupNumber + ".bak"

# SQL backup command
$SqlQuery = @"
BACKUP DATABASE [$Database]
TO DISK = N'$BackupFile'
WITH INIT, STATS = 10
"@

# Execute backup
Invoke-Sqlcmd -ServerInstance $SqlServer -Query $SqlQuery

Write-Output "Backup completed: $BackupFile"

```

***

### Step 5: Test the Script Manually

Before scheduling, test the script manually.

1. Open **PowerShell as Administrator**
2.  Run:

    ```powershell
    C:\SQLScripts\WeeklySqlBackup.ps1
    ```
3. Verify that:
   * A `.bak` file is created
   * No errors appear
   * Old backups are deleted after the 5th run

***

### Step 6: Set PowerShell Execution Policy

If scripts do not run, enable script execution:

```powershell
Set-ExecutionPolicy RemoteSigned
```

Select **Y** when prompted.

***

### Step 7: Open Task Scheduler

1. Press **Win + R**
2. Type `taskschd.msc`
3. Press **Enter**

***

### Step 8: Create a Scheduled Task

1. Click **Create Task**
2. In the **General** tab:
   * Name: `Weekly SQL Database Backup`
   * Select **Run whether user is logged on or not**
   * Check **Run with highest privileges**

***

### Step 9: Configure the Trigger (Weekly)

1. Go to the **Triggers** tab
2. Click **New**
3. Select:
   * Begin the task: **On a schedule**
   * Schedule: **Weekly**
   * Day: **Sunday**
   * Time: Choose a low-usage time (e.g., 2:00 AM)
4. Click **OK**

***

### Step 10: Configure the Action

1. Go to the **Actions** tab
2. Click **New**
3. Set:
   * **Program/script:** `powershell.exe`
   *   **Add arguments:**

       ```
       -NoProfile -ExecutionPolicy Bypass -File "C:\SQLScripts\WeeklySqlBackup.ps1"
       ```
   *   **Start in:**

       ```
       C:\SQLScripts
       ```
4. Click **OK**

***

### Step 11: Configure Conditions and Settings

#### Conditions Tab

* Uncheck **Start the task only if the computer is on AC power**

#### Settings Tab

* Check **Allow task to be run on demand**
* Check **Run task as soon as possible after a scheduled start is missed**

***

### Step 12: Save and Test the Task

* Click **OK**
* Enter the account password when prompted
* Right-click the task → **Run**
* Verify a new backup file is created

***

### Step 13: Verify Ongoing Operation

Each Sunday, confirm:

* A new `.bak` file appears
* Only **5 backup files** exist
* Task Scheduler shows **Success** in History

***

### Conclusion

By following these steps, you have successfully implemented an automated, reliable weekly backup system for your SQL Server database using PowerShell and Task Scheduler. This approach is simple, cost-effective, and ideal for environments without SQL Agent.
