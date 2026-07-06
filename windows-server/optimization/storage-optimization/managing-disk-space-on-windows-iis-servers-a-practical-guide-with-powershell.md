---
icon: floppy-disks
---

# Managing Disk Space on Windows IIS Servers: A Practical Guide with PowerShell

## Managing Disk Space on Windows IIS Servers: A Practical Guide with PowerShell

### Introduction

Disk space management is a critical part of maintaining Windows servers hosting IIS websites. When the system drive runs out of space, IIS applications, databases, Windows updates, and server services can become unstable or stop functioning altogether.

In a recent maintenance activity, the server's **C:** drive had reached a critically low level of free space. After identifying and removing obsolete IIS websites along with their associated databases, the available disk space increased to **4.57 GB**.

This article outlines the steps involved in identifying unused websites, auditing server resources, and reclaiming disk space using PowerShell.

***

## Step 1: Check Available Disk Space

Use the following PowerShell command to check the available space on the C: drive.

```powershell
Get-PSDrive C | Select-Object Name,
@{Name="Used(GB)";Expression={[math]::Round($_.Used/1GB,2)}},
@{Name="Free(GB)";Expression={[math]::Round($_.Free/1GB,2)}}
```

Or using WMI:

```powershell
Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" |
Select-Object DeviceID,
@{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB,2)}},
@{Name="Free(GB)";Expression={[math]::Round($_.FreeSpace/1GB,2)}}
```

***

## Step 2: List All IIS Websites

Import the IIS module and list all hosted websites.

```powershell
Import-Module WebAdministration

Get-Website
```

Example Output

```
Default Web Site
company.com
portal.company.com
test.company.com
demo.company.com
```

***

## Step 3: List Only Domain Names

To display only the configured host headers (domain names):

```powershell
Import-Module WebAdministration

Get-Website |
ForEach-Object {
    $_.Bindings.Collection |
    Where-Object {$_.protocol -in @("http","https")} |
    ForEach-Object {
        ($_.bindingInformation -split ':')[2]
    }
} |
Where-Object {$_} |
Sort-Object -Unique
```

Example Output

```
company.com
portal.company.com
demo.company.com
```

***

## Step 4: Export Website List to CSV

Share the website inventory with the customer for verification.

```powershell
Import-Module WebAdministration

Get-Website |
ForEach-Object {
    foreach($binding in $_.Bindings.Collection){
        [PSCustomObject]@{
            SiteName=$_.Name
            Protocol=$binding.protocol
            Binding=$binding.bindingInformation
        }
    }
} | Export-Csv C:\Temp\IIS-Websites.csv -NoTypeInformation
```

***

## Step 5: Remove an IIS Website

After customer approval:

```powershell
Import-Module WebAdministration

Remove-Website -Name "OldWebsite"
```

Or

```powershell
Stop-Website -Name "OldWebsite"

Remove-Website -Name "OldWebsite"
```

***

## Step 6: Delete the Website Files

```powershell
Remove-Item "C:\inetpub\wwwroot\OldWebsite" -Recurse -Force
```

Always ensure a backup exists before deleting production files.

***

## Step 7: List SQL Server Databases

If using SQL Server:

```powershell
Invoke-Sqlcmd -Query "SELECT name FROM sys.databases ORDER BY name;"
```

***

## Step 8: Drop an Unused Database

```sql
DROP DATABASE OldWebsiteDB;
```

Or via PowerShell:

```powershell
Invoke-Sqlcmd -Query "DROP DATABASE OldWebsiteDB;"
```

**Important:** Verify that a current backup is available before deleting any database.

***

## Step 9: Find Large Directories

Identify folders consuming the most disk space.

```powershell
Get-ChildItem C:\ -Directory |
ForEach-Object {

$size=(Get-ChildItem $_.FullName -Recurse -File -ErrorAction SilentlyContinue |
Measure-Object Length -Sum).Sum

[PSCustomObject]@{
Folder=$_.FullName
SizeGB=[math]::Round($size/1GB,2)
}

} | Sort-Object SizeGB -Descending
```

***

## Step 10: Clear Temporary Files

```powershell
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
```

***

## Step 11: Remove IIS Log Files Older Than 30 Days

```powershell
Get-ChildItem "C:\inetpub\logs\LogFiles" -Recurse |
Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-30)} |
Remove-Item -Force
```

***

## Step 12: Review Installed Applications

Identify applications that may no longer be required.

```powershell
Get-Package | Sort-Object Name
```

Or

```powershell
Get-WmiObject Win32_Product |
Select Name, Version
```

***

## Maintenance Workflow

A recommended workflow for reclaiming disk space is:

1. Check available disk space.
2. Inventory all IIS websites.
3. Share the website list with the customer.
4. Obtain approval for removing inactive websites.
5. Remove IIS sites.
6. Remove associated databases.
7. Delete obsolete website files.
8. Clean temporary files and IIS logs.
9. Verify free disk space.
10. Continue monitoring storage usage.

***

## Maintenance Outcome

After customer approval:

* Obsolete IIS websites were removed.
* Associated databases were deleted.
* Website directories were cleaned up.
* Disk space increased from critically low levels to **4.57 GB of free space**.

Additional storage can be reclaimed by reviewing any remaining unused directories, websites, databases, backup files, and log files.

***

## Best Practices

* Maintain at least **10–15% free disk space** on the system drive.
* Review IIS websites quarterly.
* Archive or remove inactive applications.
* Enable database backup retention policies.
* Schedule periodic cleanup of IIS logs and temporary files.
* Monitor disk utilization proactively using PowerShell or Windows Performance Monitor.

### Conclusion

Regular auditing and cleanup of IIS websites, associated databases, and application files are essential for maintaining a healthy Windows server. PowerShell simplifies these administrative tasks, enabling administrators to automate inventory collection, identify unused resources, and reclaim valuable storage. A structured maintenance process helps prevent service disruptions, improves performance, and ensures that server resources are used efficiently.
