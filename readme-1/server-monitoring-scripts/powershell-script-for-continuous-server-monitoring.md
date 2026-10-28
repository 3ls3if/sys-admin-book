---
icon: code
---

# PowerShell script for continuous server monitoring

{% hint style="warning" %}
F**ully-featured PowerShell script** for continuous server monitoring. It includes:

✅ Server-wide CPU, RAM, network bandwidth, and active connections\
✅ **Server\_Status** (Lagging only if RAM > 85%)\
✅ **RAM\_Upgrade\_Recommended** (RAM > 60%)\
✅ **CPU\_Upgrade\_Recommended** (CPU > 60%)\
✅ Appends data **every 1 minute**\
✅ Automatically creates **daily Excel files** so logs stay manageable
{% endhint %}

```powershell
# ===============================
# Continuous Server Monitoring Script - Corrected Version
# ===============================
# Features:
# - Server-wide monitoring (CPU, RAM, Network, TCP Connections)
# - Server_Status: Lagging if RAM > 85%
# - Upgrade Recommendations for RAM & CPU
# - Logs every 1 minute
# - Creates a new Excel file per day
# ===============================

# -------- Configuration --------
$intervalSeconds = 60        # 1 minute
$logFolder = "C:\Reports"   # Folder to store reports

# Thresholds
$ramLagThreshold = 85        # RAM % above this = Lagging
$ramUpgradeThreshold = 60    # RAM % above this = recommend upgrade
$cpuUpgradeThreshold = 60    # CPU % above this = recommend upgrade

# Create log folder if it doesn't exist
if (-not (Test-Path $logFolder)) { New-Item -Path $logFolder -ItemType Directory | Out-Null }

# -------- Module Check --------
if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
    Write-Host "ImportExcel module not found. Installing..."
    Install-Module -Name ImportExcel -Scope CurrentUser -Force
}
Import-Module ImportExcel

Write-Host "Starting infinite monitoring loop..."
Write-Host "Logging every $intervalSeconds seconds."
Write-Host "Press Ctrl + C to stop."

# -------- Infinite Loop --------
while ($true) {

    $timestamp = Get-Date
    $dateString = $timestamp.ToString("yyyyMMdd")
    $outputPath = Join-Path $logFolder ("ServerReport_" + $dateString + ".xlsx")
    $sheetName = "ServerReport_" + $dateString

    # ----- CPU Usage -----
    $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

    # ----- Memory Usage -----
    $os = Get-CimInstance Win32_OperatingSystem
    $memTotal = $os.TotalVisibleMemorySize / 1KB   # MB
    $memFree = $os.FreePhysicalMemory / 1KB        # MB
    $memUsed = $memTotal - $memFree
    $memUsedPct = [math]::Round(($memUsed / $memTotal) * 100, 2)

    # ----- Network Bandwidth -----
    $netStats = Get-Counter '\Network Interface(*)\Bytes Total/sec'
    $netTotal = [math]::Round(($netStats.CounterSamples | Measure-Object -Property CookedValue -Sum).Sum, 2)

    # ----- Active TCP Connections -----
    $connections = (Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' }).Count

    # ----- Determine Server Status -----
    $serverStatus = if ($memUsedPct -gt $ramLagThreshold) { "Lagging" } else { "OK" }

    # ----- Upgrade Recommendations -----
    $ramUpgrade = if ($memUsedPct -gt $ramUpgradeThreshold) { "Yes" } else { "No" }
    $cpuUpgrade = if ($cpu -gt $cpuUpgradeThreshold) { "Yes" } else { "No" }

    # ----- Build Record -----
    $record = [PSCustomObject]@{
        Timestamp               = $timestamp
        CPU_Usage_Percent       = [math]::Round($cpu, 2)
        Memory_Used_MB          = [math]::Round($memUsed, 2)
        Memory_Used_Percent     = $memUsedPct
        Network_BytesPerSec     = $netTotal
        Active_Connections      = $connections
        Server_Status           = $serverStatus
        RAM_Upgrade_Recommended = $ramUpgrade
        CPU_Upgrade_Recommended = $cpuUpgrade
    }

    # ----- Display in Console -----
    Write-Host ("[{0}] CPU: {1:N2}% | MEM: {2:N2}% | NET: {3} B/s | CONN: {4} | STATUS: {5} | RAM Upgrade: {6} | CPU Upgrade: {7}" -f `
        $timestamp, $cpu, $memUsedPct, $netTotal, $connections, $serverStatus, $ramUpgrade, $cpuUpgrade)

    # ----- Export to Excel -----
    if (-not (Test-Path $outputPath)) {
        # Create a new Excel file with a daily worksheet
        $record | Export-Excel -Path $outputPath -AutoSize -Title "Server Utilization Report" -WorksheetName $sheetName
    } else {
        # Append to the existing worksheet
        $record | Export-Excel -Path $outputPath -WorksheetName $sheetName -Append -AutoSize
    }

    # ----- Wait for next interval -----
    Start-Sleep -Seconds $intervalSeconds
}
```

{% hint style="warning" %}
✅ **Key Fixes Implemented:**

1. **Daily Worksheet Naming**: Each Excel file now has a worksheet named after the date (`ServerReport_YYYYMMDD`), ensuring consistent appending.
2. **`-Append` Reliability**: `Export-Excel` now explicitly specifies `-WorksheetName` for both new and existing files.
3. **AutoSize for Formatting**: Ensures columns are readable when new rows are appended.
{% endhint %}

