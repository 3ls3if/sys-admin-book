---
icon: microsoft
---

# Windows Server C: Drive Disk Usage Analysis Using PowerShell

### **1. Introduction**

Disk space management is an important responsibility of Windows Server administration. Over time, Windows servers accumulate application data, temporary files, Windows Update files, IIS logs, application logs, backup data, and other files that consume valuable storage capacity.

When a client reports that their C: drive is running out of space, administrators need more than the basic drive utilization percentage. They need to identify exactly which folders and subfolders are consuming storage.

Windows provides several ways to check disk utilization, but identifying recursive folder-wise storage consumption through the graphical interface can be time-consuming.

In this article, we will develop a PowerShell-based C: drive disk usage analysis tool that generates:

* Complete C: drive capacity and utilization information.
* Folder-wise and subfolder-wise disk usage.
* Recursive directory tree with storage consumption.
* Folder sizes in MB and GB.
* Percentage of total drive capacity consumed by each folder.
* Top 20 largest folders.
* CSV reports for further analysis in Microsoft Excel.
* Scan error logs for inaccessible directories.

The solution is designed for Windows Server 2016, 2019, 2022, and 2025.

### **2. Architecture and Working Methodology**

The script uses native PowerShell commands and Windows Management Instrumentation through CIM to collect storage information.

The analysis follows this workflow:

1. Identify C: drive capacity and available free space.
2. Enumerate directories and files recursively.
3. Calculate the direct file size within each directory.
4. Calculate cumulative folder sizes, including all subdirectories.
5. Build a hierarchical folder tree.
6. Sort folders according to their storage consumption.
7. Export the collected information into TXT and CSV reports.

**Important:** The script measures logical file sizes using file metadata. It does not calculate physical disk allocation or NTFS compression overhead.

### **3. Complete PowerShell Script**

Create a PowerShell file named:

`CDrive_Usage_Analysis.ps1`

The following script scans the C: drive, calculates recursive folder sizes, and generates storage reports.

```

# ============================================================
# WINDOWS SERVER - C DRIVE USAGE ANALYSIS
# ============================================================
# Version       : 1.0
# PowerShell    : 5.1+
# OS            : Windows Server 2016/2019/2022/2025
# Purpose       : Recursive folder-wise disk usage reporting
# ============================================================

# ---------------- CONFIGURATION ----------------

$Drive = "C:\"
$OutputFolder = "C:\DriveUsageReport"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

$TreeFile = Join-Path $OutputFolder "CDrive_Tree_$Timestamp.txt"
$CsvFile = Join-Path $OutputFolder "CDrive_Folder_Details_$Timestamp.csv"
$SummaryFile = Join-Path $OutputFolder "CDrive_Summary_$Timestamp.txt"
$ErrorFile = Join-Path $OutputFolder "CDrive_Scan_Errors_$Timestamp.txt"

$Errors = New-Object System.Collections.Generic.List[string]
$Nodes = @{}

# ---------------- CREATE OUTPUT DIRECTORY ----------------

New-Item -ItemType Directory -Path $OutputFolder -Force |
    Out-Null

# ---------------- GET DRIVE INFORMATION ----------------

$Disk = Get-CimInstance Win32_LogicalDisk `
    -Filter "DeviceID='C:'"

if (-not $Disk -or $Disk.Size -le 0) {
    throw "Unable to retrieve C: drive information."
}

$TotalBytes = [double]$Disk.Size
$FreeBytes = [double]$Disk.FreeSpace
$UsedBytes = $TotalBytes - $FreeBytes

# ---------------- CREATE ROOT NODE ----------------

$Root = [PSCustomObject]@{
    Path       = "C:\"
    Name       = "C:"
    Parent     = $null
    Depth      = 0
    DirectSize = [double]0
    TotalSize  = [double]0
    Children   = New-Object System.Collections.ArrayList
}

$Nodes["C:\"] = $Root

# ---------------- DIRECTORY SCANNING ----------------

$Queue = New-Object System.Collections.Generic.Stack[string]
$Queue.Push($Drive)

$ScannedDirectories = 0
$ScannedFiles = 0

Write-Host "`nStarting C: drive analysis..." -ForegroundColor Cyan

while ($Queue.Count -gt 0) {

    $CurrentPath = $Queue.Pop()
    $CurrentNode = $Nodes[$CurrentPath]

    $ScannedDirectories++

    if ($ScannedDirectories % 500 -eq 0) {
        Write-Host "Directories scanned: $ScannedDirectories" `
            -ForegroundColor Yellow
    }

    try {
        $Items = Get-ChildItem -LiteralPath $CurrentPath `
            -Force -ErrorAction Stop
    }
    catch {
        $Errors.Add("$CurrentPath : $($_.Exception.Message)")
        continue
    }

    foreach ($Item in $Items) {

        try {

            if ($Item.PSIsContainer) {

                # Skip symbolic links and junctions
                if (($Item.Attributes -band
                    [System.IO.FileAttributes]::ReparsePoint) -ne 0) {
                    continue
                }

                # Exclude report directory
                if ($Item.FullName.TrimEnd('\') -ieq
                    $OutputFolder.TrimEnd('\')) {
                    continue
                }

                $ChildPath = $Item.FullName

                $ChildNode = [PSCustomObject]@{
                    Path       = $ChildPath
                    Name       = $Item.Name
                    Parent     = $CurrentPath
                    Depth      = $CurrentNode.Depth + 1
                    DirectSize = [double]0
                    TotalSize  = [double]0
                    Children   = New-Object System.Collections.ArrayList
                }

                $Nodes[$ChildPath] = $ChildNode

                [void]$CurrentNode.Children.Add($ChildNode)

                $Queue.Push($ChildPath)

            }
            else {

                $CurrentNode.DirectSize += [double]$Item.Length
                $ScannedFiles++

            }

        }
        catch {
            $Errors.Add("$($Item.FullName) : $($_.Exception.Message)")
        }
    }
}

# ---------------- CALCULATE RECURSIVE SIZE ----------------

$OrderedNodes = @(
    $Nodes.Values | Sort-Object Depth -Descending
)

foreach ($Node in $OrderedNodes) {

    $Node.TotalSize = $Node.DirectSize

    foreach ($Child in $Node.Children) {
        $Node.TotalSize += $Child.TotalSize
    }

}

# ---------------- SIZE FORMATTING FUNCTIONS ----------------

function Format-Size {

    param([double]$Bytes)

    if ($Bytes -ge 1GB) {
        return "{0:N2} GB" -f ($Bytes / 1GB)
    }
    elseif ($Bytes -ge 1MB) {
        return "{0:N2} MB" -f ($Bytes / 1MB)
    }
    elseif ($Bytes -ge 1KB) {
        return "{0:N2} KB" -f ($Bytes / 1KB)
    }
    else {
        return "{0:N0} Bytes" -f $Bytes
    }
}

function Format-Percent {

    param([double]$Bytes)

    if ($TotalBytes -gt 0) {
        return [math]::Round(
            ($Bytes / $TotalBytes) * 100, 2
        )
    }

    return 0
}

# ---------------- GENERATE TREE REPORT ----------------

$TreeLines = New-Object System.Collections.Generic.List[string]

$TreeLines.Add("============================================================")
$TreeLines.Add("             C DRIVE DISK USAGE TREE REPORT")
$TreeLines.Add("============================================================")
$TreeLines.Add("Server Name       : $env:COMPUTERNAME")
$TreeLines.Add("Scan Date         : $(Get-Date)")
$TreeLines.Add("Drive             : C:\")
$TreeLines.Add("Total Capacity    : $(Format-Size $TotalBytes)")
$TreeLines.Add("Used Space        : $(Format-Size $UsedBytes)")
$TreeLines.Add("Free Space        : $(Format-Size $FreeBytes)")
$TreeLines.Add("Drive Utilization : $(Format-Percent $UsedBytes)%")
$TreeLines.Add("Directories       : $ScannedDirectories")
$TreeLines.Add("Files             : $ScannedFiles")
$TreeLines.Add("============================================================")
$TreeLines.Add("")
$TreeLines.Add("C:\ [$(Format-Size $Root.TotalSize)]")
$TreeLines.Add("")

$TreeLines.Add(
    "Files directly under C:\ : $(Format-Size $Root.DirectSize)"
)

$TreeLines.Add("")

$DisplayStack = New-Object System.Collections.Stack

$RootChildren = @(
    $Root.Children | Sort-Object TotalSize -Descending
)

for ($i = $RootChildren.Count - 1; $i -ge 0; $i--) {

    $DisplayStack.Push([PSCustomObject]@{
        Node = $RootChildren[$i]
        Prefix = ""
        Last = ($i -eq ($RootChildren.Count - 1))
    })
}

while ($DisplayStack.Count -gt 0) {

    $Entry = $DisplayStack.Pop()
    $Node = $Entry.Node

    if ($Entry.Last) {
        $Branch = "\-- "
        $NextPrefix = $Entry.Prefix + "    "
    }
    else {
        $Branch = "|-- "
        $NextPrefix = $Entry.Prefix + "|   "
    }

    $Size = Format-Size $Node.TotalSize
    $Percent = Format-Percent $Node.TotalSize

    $TreeLines.Add(
        "$($Entry.Prefix)$Branch$($Node.Name) [$Size] [$Percent%]"
    )

    $Children = @(
        $Node.Children | Sort-Object TotalSize -Descending
    )

    for ($i = $Children.Count - 1; $i -ge 0; $i--) {

        $DisplayStack.Push([PSCustomObject]@{
            Node = $Children[$i]
            Prefix = $NextPrefix
            Last = ($i -eq ($Children.Count - 1))
        })

    }
}

$TreeLines | Out-File -FilePath $TreeFile -Encoding UTF8

# ---------------- GENERATE CSV REPORT ----------------

$CsvData = foreach ($Node in $Nodes.Values) {

    if ($Node.Depth -eq 0) {
        continue
    }

    [PSCustomObject]@{
        FolderName       = $Node.Name
        FolderPath       = $Node.Path
        ParentFolder     = $Node.Parent
        FolderDepth      = $Node.Depth
        TotalSizeBytes   = [math]::Round($Node.TotalSize, 0)
        TotalSizeMB      = [math]::Round($Node.TotalSize / 1MB, 2)
        TotalSizeGB      = [math]::Round($Node.TotalSize / 1GB, 3)
        PercentOfDrive   = Format-Percent $Node.TotalSize
        DirectFilesBytes = [math]::Round($Node.DirectSize, 0)
    }
}

$CsvData |
    Sort-Object TotalSizeBytes -Descending |
    Export-Csv -Path $CsvFile -NoTypeInformation -Encoding UTF8

# ---------------- GENERATE SUMMARY REPORT ----------------

$TopFolders = (
    $CsvData |
    Sort-Object TotalSizeBytes -Descending |
    Select-Object -First 20 |
    ForEach-Object {
        "$($_.FolderPath) : $($_.TotalSizeGB) GB"
    }
) -join "`r`n"

$Summary = @"
============================================================
              C DRIVE STORAGE SUMMARY
============================================================

Server Name       : $env:COMPUTERNAME
Report Date       : $(Get-Date)

Drive             : C:\
Total Capacity    : $(Format-Size $TotalBytes)
Used Space        : $(Format-Size $UsedBytes)
Free Space        : $(Format-Size $FreeBytes)
Drive Utilization : $(Format-Percent $UsedBytes)%

Directories Scanned : $ScannedDirectories
Files Scanned       : $ScannedFiles
Scan Warnings       : $($Errors.Count)

TOP 20 LARGEST FOLDERS
------------------------------------------------------------

$TopFolders

============================================================
"@

$Summary | Out-File -FilePath $SummaryFile -Encoding UTF8

# ---------------- SAVE SCAN ERRORS ----------------

if ($Errors.Count -gt 0) {

    $Errors | Out-File -FilePath $ErrorFile -Encoding UTF8

}

# ---------------- FINAL OUTPUT ----------------

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "       C DRIVE ANALYSIS COMPLETED" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "Server       : $env:COMPUTERNAME"
Write-Host "Total Space  : $(Format-Size $TotalBytes)"
Write-Host "Used Space   : $(Format-Size $UsedBytes)"
Write-Host "Free Space   : $(Format-Size $FreeBytes)"
Write-Host "Utilization  : $(Format-Percent $UsedBytes)%"

Write-Host "`nReports Generated:" -ForegroundColor Cyan
Write-Host "Tree Report  : $TreeFile"
Write-Host "Folder CSV   : $CsvFile"
Write-Host "Summary      : $SummaryFile"

if ($Errors.Count -gt 0) {
    Write-Host "Error Report  : $ErrorFile" -ForegroundColor Yellow
}

Write-Host "`nAll reports saved in: $OutputFolder" `
    -ForegroundColor Green
```

### **4. Script Execution**

#### **Step 1: Save the script**

Save the PowerShell script as:

```
C:\CDrive_Usage_Analysis.ps1
```

#### **Step 2: Open PowerShell as Administrator**

Execute:

```
Set-ExecutionPolicy -Scope Process Bypass -Force
```

#### **Step 3: Run the script**

```
C:\CDrive_Usage_Analysis.ps1
```

The script will start scanning directories and calculating folder sizes.

**Execution time:** It depends on the total number of files, directories, storage performance, and access permissions.

### **5. Generated Reports**

After execution, the script creates the following directory:

```
C:\
 |
 +--- DriveUsageReport
       |
       +--- CDrive_Tree_YYYYMMDD_HHMMSS.txt
       |
       +--- CDrive_Folder_Details_YYYYMMDD_HHMMSS.csv
       |
       +--- CDrive_Summary_YYYYMMDD_HHMMSS.txt
       |
       +--- CDrive_Scan_Errors_YYYYMMDD_HHMMSS.txt
```

#### **5.1 Tree View Report**

The tree report displays the folder hierarchy along with cumulative folder sizes.

**Example output (illustrative):**

```
C DRIVE DISK USAGE TREE REPORT

Server Name       : WIN-SERVER01
Total Capacity    : 250.00 GB
Used Space        : 185.50 GB
Free Space        : 64.50 GB
Drive Utilization : 74.20%

C:\ [185.50 GB]

|-- Windows [82.50 GB] [33.00%]
|   |-- Installer [25.20 GB] [10.08%]
|   |-- WinSxS [18.40 GB] [7.36%]
|   |-- SoftwareDistribution [8.50 GB] [3.40%]
|   \-- System32 [15.60 GB] [6.24%]

|-- Program Files [35.20 GB] [14.08%]
|   |-- Microsoft SQL Server [18.50 GB] [7.40%]
|   \-- Common Files [5.20 GB] [2.08%]

|-- ProgramData [28.60 GB] [11.44%]
|   |-- Microsoft [15.40 GB] [6.16%]
|   \-- Application Data [8.20 GB] [3.28%]

\-- Users [12.50 GB] [5.00%]
    |-- Administrator [8.20 GB] [3.28%]
    \-- Public [4.30 GB] [1.72%]
```

The values above are illustrative, not actual scan results. Individual child folders are included in their parent folder's cumulative size, so do not add the figures across different hierarchy levels.

#### **5.2 CSV Folder Details Report**

The CSV file contains detailed information for every discovered folder.

| Column           | Description                              |
| ---------------- | ---------------------------------------- |
| FolderName       | Directory name                           |
| FolderPath       | Complete directory path                  |
| ParentFolder     | Parent directory                         |
| FolderDepth      | Hierarchy level                          |
| TotalSizeBytes   | Recursive size in bytes                  |
| TotalSizeMB      | Recursive size in MB                     |
| TotalSizeGB      | Recursive size in GB                     |
| PercentOfDrive   | Percentage of total drive capacity       |
| DirectFilesBytes | Size of files directly inside the folder |

You can open this report in Excel and sort by `TotalSizeGB` to identify the largest directories.

#### **5.3 Summary Report**

The summary report provides:

* Server identification.
* Total disk capacity.
* Used and free space.
* Drive utilization percentage.
* Number of scanned directories.
* Number of scanned files.
* Top 20 largest folders.
* Scan warnings.

#### **5.4 Error Report**

The error report records directories that PowerShell could not access.

This is important because protected Windows system directories may require elevated permissions or may remain inaccessible even when running as Administrator.

### **6. Understanding the Folder Size Calculation**

The script uses two different storage measurements.

**Direct folder size**

This represents the combined size of files directly inside a particular folder, excluding its subdirectories.

**Total folder size**

This represents the direct folder size plus the cumulative size of all subdirectories.

For example:

```
C:\Application
    |
    |-- app.exe            500 MB
    |
    |-- Logs
    |     |-- app.log      2 GB
    |
    |-- Database
          |-- data.mdf     10 GB
```

The resulting calculation is:

| Directory   | Direct size | Total size |
| ----------- | ----------- | ---------- |
| Application | 500 MB      | 12.5 GB    |
| Logs        | 2 GB        | 2 GB       |
| Database    | 10 GB       | 10 GB      |

This distinction helps administrators understand whether the space is being consumed directly by application files or by nested directories such as logs and database files.

### **7. Troubleshooting and Important Considerations**

#### **7.1 Access Denied Errors**

If the script reports access-denied errors, execute PowerShell as Administrator.

Some system-protected directories may still be inaccessible.

Do not change ownership or permissions on Windows system folders merely to complete the scan.

#### **7.2 Large Directory Scanning Time**

On servers with millions of files, recursive disk scanning can take considerable time.

Avoid running multiple disk-analysis scans simultaneously on production servers.

#### **7.3 Symbolic Links and Junctions**

The script skips reparse-point directories to prevent duplicate counting and infinite directory traversal.

As a result, storage accessible only through a junction or symbolic link may not appear in the report.

#### **7.4 Logical Size vs Physical Disk Allocation**

The script calculates logical file sizes using the `Length` property.

Actual NTFS disk allocation can differ because of:

* NTFS compression.
* Sparse files.
* Hard links.
* Filesystem metadata.
* Cluster allocation.

The report should therefore be treated as a logical file-size analysis, not an exact physical allocation report.

#### **7.5 Windows System Folders**

Special care is required when investigating the following directories:

| Directory                         | Purpose                            |
| --------------------------------- | ---------------------------------- |
| `C:\Windows\WinSxS`               | Windows component store            |
| `C:\Windows\Installer`            | Windows Installer cache            |
| `C:\Windows\SoftwareDistribution` | Windows Update data                |
| `C:\ProgramData`                  | Application and service data       |
| `C:\Program Files`                | Installed applications             |
| `C:\Users`                        | User profiles and application data |

Do not manually delete files from these directories based only on their reported sizes. Use supported Windows cleanup and application maintenance procedures.

### **8. Recommended Administrative Workflow**

When a client reports high C: drive utilization, follow this workflow:

1.  **Check disk capacity**

    Retrieve the total, used, and free space of the C: drive.
2.  **Generate the folder usage report**

    Execute the PowerShell script with administrative privileges.
3.  **Identify large directories**

    Review the tree report and sort the CSV by folder size.
4.  **Investigate storage consumers**

    Check application logs, IIS logs, SQL databases, backup files, temporary files, and Windows Update data.
5.  **Verify cleanup opportunities**

    Identify safe cleanup opportunities with the application or system owner.
6.  **Prepare the client report**

    Share the disk utilization summary, folder tree, and largest-folder breakdown.

### **9. Conclusion**

PowerShell provides an effective way to automate Windows Server storage analysis without requiring third-party disk-usage applications.

The script developed in this article provides administrators with a hierarchical view of C: drive utilization, recursive folder-size calculations, CSV exports, and scan diagnostics.

It can be used during routine server health checks, storage troubleshooting, disk capacity planning, and client-requested infrastructure reporting.

For production environments, administrators should also consider monitoring disk utilization regularly and configuring alerts before the drive reaches critical capacity.
