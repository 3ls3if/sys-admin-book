---
icon: database
---

# SQL Server Disk Space Investigation and Cleanup: Resolving Excessive Storage Consumption

## SQL Server Disk Space Investigation and Cleanup: Resolving Excessive Storage Consumption

### Overview

A routine health check on the Windows Server identified that the system drive (C:) was running low on available disk space. To determine the cause, a detailed disk space analysis was performed using PowerShell. The investigation identified the primary storage consumers, isolated the root cause, and reclaimed disk space by removing obsolete SQL Server archived error logs.

***

## Environment

* **Operating System:** Windows Server
* **Database:** Microsoft SQL Server 2016 (MSSQL13)
* **Disk:** C: Drive (99.5 GB)

***

## Step 1: Identify the Largest Top-Level Folders

The following PowerShell script was used to determine which top-level folders were consuming the most disk space.

```powershell
Get-ChildItem C:\ -Directory | ForEach-Object {

    $size = (
        Get-ChildItem $_.FullName -Recurse -Force -ErrorAction SilentlyContinue |
        Where-Object { -not $_.PSIsContainer } |
        Measure-Object -Property Length -Sum
    ).Sum

    [PSCustomObject]@{
        Folder = $_.FullName
        SizeGB = [math]::Round(($size / 1GB),2)
    }

} | Sort-Object SizeGB -Descending
```

#### Output

| Folder                 |     Size |
| ---------------------- | -------: |
| C:\Program Files       | 38.12 GB |
| C:\Windows             | 21.04 GB |
| C:\inetpub             | 11.72 GB |
| C:\Users               |  4.41 GB |
| C:\Program Files (x86) |  3.31 GB |

The results indicated that **C:\Program Files** was the largest storage consumer.

***

## Step 2: Drill Down into Program Files

The following script was executed to identify which application within **Program Files** occupied the most storage.

```powershell
Get-ChildItem "C:\Program Files" -Directory | ForEach-Object {

    $size = (
        Get-ChildItem $_.FullName -Recurse -Force -ErrorAction SilentlyContinue |
        Where-Object { -not $_.PSIsContainer } |
        Measure-Object Length -Sum
    ).Sum

    [PSCustomObject]@{
        Folder = $_.Name
        SizeGB = [math]::Round($size/1GB,2)
    }

} | Sort-Object SizeGB -Descending
```

#### Output

| Folder                      |     Size |
| --------------------------- | -------: |
| Microsoft SQL Server        | 36.39 GB |
| BraveSoftware               |  0.98 GB |
| Microsoft Analysis Services |  0.35 GB |
| Others                      | < 0.2 GB |

The investigation confirmed that **Microsoft SQL Server** was responsible for nearly all of the storage consumption within Program Files.

***

## Step 3: Identify the Largest Files

To determine exactly which files were consuming the space, the following PowerShell script was executed.

```powershell
Get-ChildItem "C:\Program Files\Microsoft SQL Server" -Recurse -File -ErrorAction SilentlyContinue |
Sort-Object Length -Descending |
Select-Object -First 20 FullName,
@{Name='SizeGB';Expression={[math]::Round($_.Length/1GB,2)}}
```

#### Output

| File            |     Size |
| --------------- | -------: |
| ERRORLOG.4      | 23.87 GB |
| ERRORLOG.5      |  2.44 GB |
| ERRORLOG.3      |  1.20 GB |
| ERRORLOG.6      |  0.78 GB |
| spark555raj.bak |  0.69 GB |
| spark555.mdf    |  0.69 GB |
| ERRORLOG.1      |  0.47 GB |
| ERRORLOG.2      |  0.16 GB |

***

## Root Cause

The investigation revealed that the majority of the storage was consumed by archived SQL Server error log files located at:

```
C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Log
```

The archived logs had accumulated over time and were no longer required for routine operations.

The largest archived log (`ERRORLOG.4`) alone occupied approximately **24 GB**, while the total archived error logs consumed approximately **28–29 GB**.

***

## Corrective Actions

The following actions were performed:

* Conducted a PowerShell-based disk space analysis.
* Identified SQL Server as the primary storage consumer.
* Isolated the largest files within the SQL Server installation.
* Verified that the files were archived SQL Server error logs.
* Removed obsolete archived SQL Server error logs (`ERRORLOG.1` through `ERRORLOG.6`).
* Preserved the active SQL Server log (`ERRORLOG`).

***

## Results

After cleanup:

| Metric                   |                  Value |
| ------------------------ | ---------------------: |
| Total Disk Capacity      |                99.5 GB |
| Free Space After Cleanup |                35.0 GB |
| Space Recovered          | Approximately 28–29 GB |

The server now has sufficient free disk space for normal operations.

***

## Recommendations

To avoid similar issues in the future:

1. Configure SQL Server to cycle error logs regularly.
2. Implement a retention policy to automatically remove older archived logs.
3. Monitor disk utilization periodically.
4. Review SQL Server logs to identify recurring errors that may generate excessive log entries.
5. Include disk space monitoring in routine server health checks.

***

## Conclusion

The investigation successfully identified archived SQL Server error logs as the primary cause of low disk space on the Windows Server. Through systematic PowerShell analysis, the largest directories and files were identified, allowing obsolete archived logs to be safely removed.

Approximately **28–29 GB** of storage was reclaimed, increasing the available free space on the C: drive to **35 GB** and restoring adequate operating capacity. Regular SQL Server log maintenance and proactive disk monitoring are recommended to prevent recurrence.
