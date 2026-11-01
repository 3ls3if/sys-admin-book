---
icon: cloud-arrow-up
---

# Automated Backup of All Microsoft SQL Server Databases 1

## Automated Backup of All Microsoft SQL Server Databases Using PowerShell

### 1. Introduction

Taking regular backups of Microsoft SQL Server databases is an essential responsibility for database administrators and Windows Server administrators.

In hosting environments, a single SQL Server instance may contain dozens or hundreds of customer databases. Manually backing up each database through SQL Server Management Studio (SSMS) can be time-consuming and increases the possibility of human error.

This PowerShell automation script simplifies the process by automatically identifying all online user databases on a SQL Server instance and creating individual `.bak` backup files.

The script uses SQLCMD with Windows Authentication to communicate with SQL Server and executes the native SQL Server `BACKUP DATABASE` command.

Each database backup is saved separately with a timestamp, making it easier to identify, organize, and manage backup files.

### 2. Script Overview

| Parameter           | Configuration             |
| ------------------- | ------------------------- |
| Automation Tool     | Windows PowerShell        |
| Database Engine     | Microsoft SQL Server      |
| SQL Instance        | `localhost`               |
| Backup Directory    | `C:\sql-backup29-10`      |
| Backup Format       | `.bak`                    |
| Authentication      | Windows Authentication    |
| SQL Command Utility | SQLCMD                    |
| Database Selection  | All online user databases |
| Backup Type         | Full database backup      |
| Backup Validation   | CHECKSUM option           |
| Progress Monitoring | STATS = 10                |
| Logging             | Timestamped text log      |

### 3. Key Features

#### Automated database discovery

The script automatically retrieves databases from `sys.databases`.

It selects databases that meet the following conditions:

* Database ID greater than 4.
* Database state is `ONLINE`.
* Database is not a database snapshot.
* Database names are sorted alphabetically.

The following SQL query performs database discovery:

```
SELECT name
FROM sys.databases
WHERE database_id > 4
  AND state_desc = 'ONLINE'
  AND source_database_id IS NULL
ORDER BY name;
```

This excludes SQL Server system databases such as:

* master
* model
* msdb
* tempdb

#### Individual backup files

Every database receives its own `.bak` file.

Example:

```
C:\sql-backup29-10\
    Database1_20261101_220000.bak
    Database2_20261101_220000.bak
    Database3_20261101_220000.bak
```

#### Timestamp-based naming

The script generates a timestamp using:

```
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
```

This prevents backup files from being overwritten by subsequent executions using a different timestamp.

#### Backup checksum validation

The script uses SQL Server's `CHECKSUM` option:

```
BACKUP DATABASE [DatabaseName]
TO DISK = N'C:\sql-backup29-10\DatabaseName.bak'
WITH CHECKSUM, STATS = 10;
```

This instructs SQL Server to generate backup checksums and validate page checksums when available during the backup operation.

#### Automatic logging

A separate log file is created for each execution.

Example:

```
BackupLog_20261101_220000.txt
```

The log records successful and failed database backup operations.

#### Error handling

The script checks SQLCMD's exit code and verifies whether the expected backup file exists.

If the backup operation fails, the database is marked as failed and the script continues processing the remaining databases.

### 4. Backup Workflow



<figure><img src="../../../.gitbook/assets/mermaid-diagram (1).png" alt=""><figcaption></figcaption></figure>

### 5. Prerequisites

Before executing the script, verify the following requirements:

1. Microsoft SQL Server is installed and running.
2. SQLCMD utility is installed.
3. The PowerShell execution account has sufficient SQL Server permissions. Typically, `sysadmin` or the required database backup permissions.
4. SQL Server service account has write permissions to the backup directory.
5. Sufficient disk space is available.
6. All databases intended for backup are online.

Important: SQL Server writes the backup files using its service account. The account running PowerShell does not automatically grant SQL Server permission to write to the destination directory.

### 6. Complete PowerShell Script

The following is the complete script, consolidated into one code pane for copying and deployment.

```ps

# ============================================================
# BACKUP ALL ONLINE MSSQL USER DATABASES
#
# Backup Location : C:\sql-backup29-10
# SQL Instance    : localhost
# Backup Type     : Full Database Backup
# Authentication : Windows Authentication
# ============================================================

$BackupPath = "C:\sql-backup29-10"
$SqlInstance = "localhost"
$SqlCmd = "C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD.EXE"

$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$LogFile = Join-Path $BackupPath "BackupLog_$Timestamp.txt"

# ------------------------------------------------------------
# Create backup directory
# ------------------------------------------------------------

New-Item -Path $BackupPath -ItemType Directory -Force | Out-Null

# ------------------------------------------------------------
# Retrieve online user databases
# ------------------------------------------------------------

$Query = @"
SET NOCOUNT ON;

SELECT name
FROM sys.databases
WHERE database_id > 4
  AND state_desc = 'ONLINE'
  AND source_database_id IS NULL
ORDER BY name;
"@

$Databases = @(& $SqlCmd -S $SqlInstance -E -b -h -1 -W -Q $Query 2>&1)

if ($LASTEXITCODE -ne 0) {
    Write-Host "SQL connection failed. Check the error below:" -ForegroundColor Red
    $Databases
    return
}

$Databases = @(
    $Databases |
    ForEach-Object { "$_".Trim() } |
    Where-Object { $_ -and $_ -notmatch '^-+$' }
)

if ($Databases.Count -eq 0) {
    Write-Host "No user databases found." -ForegroundColor Yellow
    return
}

Write-Host "SQL Instance : $SqlInstance"
Write-Host "Backup folder: $BackupPath"
Write-Host "Total databases: $($Databases.Count)"

Add-Content -Path $LogFile -Value "Backup started: $(Get-Date)"

# ------------------------------------------------------------
# Process each database
# ------------------------------------------------------------

foreach ($DBName in $Databases) {

    # Generate safe database filename

    $SafeName = $DBName -replace '[\\/:*?"<>|]', '_'

    $BackupFile = Join-Path $BackupPath "${SafeName}_${Timestamp}.bak"

    # Escape SQL identifiers and file paths

    $EscapedDB = $DBName.Replace("]", "]]")
    $EscapedFile = $BackupFile.Replace("'", "''")

    Write-Host "`nBacking up: $DBName" -ForegroundColor Cyan

    # --------------------------------------------------------
    # Execute full database backup
    # --------------------------------------------------------

    $BackupQuery = "BACKUP DATABASE [$EscapedDB] TO DISK = N'$EscapedFile' WITH CHECKSUM, STATS = 10;"

    & $SqlCmd -S $SqlInstance -E -b -t 0 -Q $BackupQuery

    # --------------------------------------------------------
    # Check backup result
    # --------------------------------------------------------

    if ($LASTEXITCODE -eq 0 -and (Test-Path $BackupFile)) {

        $Message = "SUCCESS: $DBName | $BackupFile"

        Write-Host $Message -ForegroundColor Green

    }
    else {

        $Message = "FAILED: $DBName | Check SQL Server error output."

        Write-Host $Message -ForegroundColor Red

    }

    # --------------------------------------------------------
    # Write operation status to log
    # --------------------------------------------------------

    Add-Content -Path $LogFile -Value $Message
}

# ------------------------------------------------------------
# Completion
# ------------------------------------------------------------

Write-Host "`nBackup process completed." -ForegroundColor Green

Write-Host "Backup location: $BackupPath"
Write-Host "Log file: $LogFile"
```

### 7. How to Execute the Script

Step 1: Save the script

Save the PowerShell script with the following filename:

```
Backup-All-MSSQL-Databases.ps1
```

Step 2: Open PowerShell

Run PowerShell with an account that has the required SQL Server permissions.

Step 3: Execute the script

```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

.\Backup-All-MSSQL-Databases.ps1
```

Step 4: Monitor backup operations

The script displays the database currently being backed up and SQL Server's backup progress.

### 8. Expected Output

Example console output:

```
SQL Instance : localhost
Backup folder: C:\sql-backup29-10
Total databases: 5

Backing up: CustomerDB
10 percent processed.
20 percent processed.
30 percent processed.
100 percent processed.

SUCCESS: CustomerDB | C:\sql-backup29-10\CustomerDB_20261101_220000.bak

Backing up: SchoolDB
10 percent processed.
20 percent processed.
100 percent processed.

SUCCESS: SchoolDB | C:\sql-backup29-10\SchoolDB_20261101_220000.bak

Backing up: WebsiteDB
SUCCESS: WebsiteDB | C:\sql-backup29-10\WebsiteDB_20261101_220000.bak

Backup process completed.

Backup location: C:\sql-backup29-10
Log file: C:\sql-backup29-10\BackupLog_20261101_220000.txt
```

Illustrative output; actual database names and backup progress will vary.

### 9. Backup Log Example

The script creates a log file containing the status of each database.

Example:

```
Backup started: 11/01/2026 22:00:00

SUCCESS: CustomerDB | C:\sql-backup29-10\CustomerDB_20261101_220000.bak
SUCCESS: SchoolDB | C:\sql-backup29-10\SchoolDB_20261101_220000.bak
FAILED: WebsiteDB | Check SQL Server error output.
SUCCESS: ApplicationDB | C:\sql-backup29-10\ApplicationDB_20261101_220000.bak
```

This makes it easier to identify failed backups without manually checking every database.

### 10. Important Technical Considerations

| Area                | Technical consideration                                      |
| ------------------- | ------------------------------------------------------------ |
| Backup type         | The script creates full database backups.                    |
| System databases    | System databases are excluded.                               |
| Offline databases   | Offline databases are excluded.                              |
| Database snapshots  | Database snapshots are excluded.                             |
| Backup checksum     | Uses `WITH CHECKSUM`.                                        |
| Backup destination  | SQL Server service account needs write access.               |
| Backup retention    | No automatic retention or deletion is configured.            |
| Backup verification | No separate `RESTORE VERIFYONLY` operation is performed.     |
| Transaction logs    | This is not a transaction log backup solution.               |
| Recovery testing    | A successful backup does not guarantee a successful restore. |

#### Recommended production improvements

For production hosting environments, consider adding:

1. Automatic backup retention, such as keeping the last 7, 15, or 30 days.
2. Separate backup directories for each server or customer.
3. `RESTORE VERIFYONLY` after each backup.
4. Backup file size validation.
5. Email notifications for failed database backups.
6. Scheduled execution through Windows Task Scheduler.
7. Off-server or cloud backup replication.
8. Periodic test restores and `DBCC CHECKDB`.

Important: The current script considers a backup successful when SQLCMD returns exit code `0` and the backup file exists. For stronger verification, add a separate `RESTORE VERIFYONLY WITH CHECKSUM` step and periodic test restores.

### 11. Conclusion

This PowerShell automation provides a straightforward way to back up all online user databases from a Microsoft SQL Server instance.

Instead of manually selecting databases and initiating individual backups through SSMS, administrators can execute a single script to:

* Discover all eligible user databases.
* Generate individual `.bak` files.
* Include backup checksums.
* Monitor backup progress.
* Record success and failure statuses.
* Maintain timestamped backup logs.

This approach is particularly useful for hosting providers, Windows Server administrators, and SQL Server administrators managing multiple customer databases.

### 12. Related Documentation

This backup automation can be paired with the previously documented restoration script:

Automated Bulk MSSQL Database Restoration Using PowerShell

The two scripts can be used together as part of a database migration or recovery workflow:

1\. Database Backup

Automatically backs up all eligible online user databases into individual `.bak` files.

2\. Backup Transfer

Transfer backup files to the destination SQL Server.

3\. Database Restoration

Automatically detects and restores databases while skipping existing databases.
