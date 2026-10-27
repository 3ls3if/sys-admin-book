---
icon: subtitles
---

# Script: DB Backup and Restore

```powershell
# Ensure SQLServer module is installed
if (-not (Get-Module -ListAvailable -Name SqlServer)) {
    Write-Host "SqlServer module not found. Installing..." -ForegroundColor Yellow
    Install-Module -Name SqlServer -AllowClobber -Force
} else {
    Write-Host "SqlServer module already installed." -ForegroundColor Green
}
 
Import-Module SqlServer
 
function Show-Menu {
    Clear-Host
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "     SQL Backup/Restore Utility     " -ForegroundColor Yellow
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "1. Backup All Databases" -ForegroundColor Green
    Write-Host "2. Restore All Databases" -ForegroundColor Green
    Write-Host "3. Exit" -ForegroundColor Red
    Write-Host "====================================" -ForegroundColor Cyan
}
 
function Do-Backup {
 
    Write-Host "`n=== BACKUP DATABASES ===" -ForegroundColor Cyan
 
    $backupInstance = Read-Host "Enter Backup Instance (e.g. SERVER01\SQLEXPRESS)"
    $backupFolder   = Read-Host "Enter Backup Folder (e.g. C:\SQLBackups)"
 
    if (!(Test-Path $backupFolder)) {
        New-Item -Path $backupFolder -ItemType Directory | Out-Null
        Write-Host "Created folder: $backupFolder" -ForegroundColor Yellow
    }
 
    # Detect SQL Server service account
    $serviceNameEscaped = $backupInstance.Split("\")[1]
    $serviceName = "MSSQL`$$serviceNameEscaped"
 
    $sqlService = Get-WmiObject Win32_Service -Filter "Name='$serviceName'"
    $serviceAccount = $sqlService.StartName
 
    Write-Host "SQL Service Account: $serviceAccount" -ForegroundColor Yellow
 
    # Grant permissions
    $acl = Get-Acl $backupFolder
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        $serviceAccount,
        "FullControl",
        "ContainerInherit,ObjectInherit",
        "None",
        "Allow"
    )
    $acl.SetAccessRule($rule)
    Set-Acl $backupFolder $acl
 
    Write-Host "Permissions applied to $backupFolder" -ForegroundColor DarkYellow
 
    # Backup databases
    $server = New-Object Microsoft.SqlServer.Management.Smo.Server($backupInstance)
 
    foreach ($db in $server.Databases) {
        if ($db.IsSystemObject) { continue }
 
        $dbName = $db.Name
        $backupFile = Join-Path $backupFolder "$dbName.bak"
 
        Write-Host "Backing up $dbName ..." -ForegroundColor Cyan
        try {
            $backup = New-Object Microsoft.SqlServer.Management.Smo.Backup
            $backup.Action = "Database"
            $backup.Database = $dbName
            $backup.Initialize = $true
            $backup.Devices.AddDevice($backupFile, "File")
 
            $backup.SqlBackup($server)
            Write-Host "Backup complete: $dbName" -ForegroundColor Green
        }
        catch {
            Write-Host "ERROR backing up $dbName" -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor Red
        }
    }
 
    Write-Host "`nAll backups completed." -ForegroundColor Green
    Pause
}
 
function Do-Restore {
 
    Write-Host "`n=== RESTORE DATABASES ===" -ForegroundColor Cyan
 
    $restoreInstance = Read-Host "Enter Restore Instance (e.g. STAGING\MSSQL)"
    $backupFolder    = Read-Host "Enter Folder Containing .BAK files"
 
    if (!(Test-Path $backupFolder)) {
        Write-Host "Backup folder does not exist!" -ForegroundColor Red
        Pause
        return
    }
 
    $baks = Get-ChildItem $backupFolder -Filter *.bak
    $server = New-Object Microsoft.SqlServer.Management.Smo.Server($restoreInstance)
 
    foreach ($file in $baks) {
        $dbName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        Write-Host "Restoring $dbName ..." -ForegroundColor Cyan
 
        try {
            $restore = New-Object Microsoft.SqlServer.Management.Smo.Restore
            $restore.Action = "Database"
            $restore.Database = $dbName
            $restore.ReplaceDatabase = $true
            $restore.Devices.AddDevice($file.FullName, "File")
 
            $restore.SqlRestore($server)
 
            Write-Host "Restored: $dbName" -ForegroundColor Green
        }
        catch {
            Write-Host "ERROR restoring $dbName" -ForegroundColor Red
            Write-Host $_.Exception.InnerException.InnerException.Message -ForegroundColor Red
        }
    }
 
    Write-Host "`nAll restores completed." -ForegroundColor Green
    Pause
}
 
# MAIN LOOP
while ($true) {
    Show-Menu
    $choice = Read-Host "Enter your choice (1-3)"
 
    switch ($choice) {
        "1" { Do-Backup }
        "2" { Do-Restore }
        "3" { break }
        default { Write-Host "Invalid choice!" -ForegroundColor Red; Pause }
    }
}
```
