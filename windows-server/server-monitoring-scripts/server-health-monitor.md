---
icon: suitcase-medical
---

# Server Health Monitor

A robust, continuous Windows Server monitoring script written in PowerShell that generates a beautiful, interactive, and premium HTML dashboard using Chart.js. The script gives you real-time insights into resource utilization, user impact, storage health, hardware stability, and application crashes.



### Usage Examples

**1. Default Run (7 Days, 15 Min Interval)**

```
.\Monitor-ServerHealth.ps1
```

**2. Custom Continuous Run** Monitors the server for 30 days, capturing data every 60 minutes, and saving the dashboard to a specific folder.

```
.\Monitor-ServerHealth.ps1 -Days 30 -IntervalMinutes 60 -ExportPath "C:\Reports\MonthlyHealth.html"
```

**3. Point-in-time Snapshot** Takes a single reading and immediately generates the report.

```
.\Monitor-ServerHealth.ps1 -RunOnce -ExportPath "C:\Reports\Snapshot.html"
```



***

## Script

```powershell
<#
.SYNOPSIS
    Continuously monitors a Windows Server for a specified number of days and generates an ongoing HTML report with trend charts.

.DESCRIPTION
    This script runs in a loop for the specified number of days, taking samples of CPU, RAM, Disk, and Network 
    every X minutes. It maintains a historical record and regenerates a premium HTML report using Chart.js to visually 
    show resource trends over the monitoring period. It also checks Event Logs for crashes and errors, and tracks 
    resource utilization PER USER.

.PARAMETER Days
    Number of days the script should continuously monitor the server (Default: 7)

.PARAMETER IntervalMinutes
    How often (in minutes) to take a resource sample and update the report (Default: 15)

.PARAMETER ExportPath
    The path where the HTML report will be saved. (Default: $env:USERPROFILE\Desktop\ServerHealthReport.html)
    
.PARAMETER RunOnce
    If specified, the script immediately takes one snapshot, builds the report, and exits without looping.
#>

param (
    [int]$Days = 7,
    [int]$IntervalMinutes = 15,
    [string]$ExportPath = "$env:USERPROFILE\Desktop\ServerHealthReport.html",
    [switch]$RunOnce
)

# Admin Check
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Warning "Please run this script as an Administrator to get accurate Event Log, User Tracking, and Active User data."
}

Write-Host "Started Continuous Server Monitor Script..." -ForegroundColor Cyan
if (-not $RunOnce) {
    Write-Host "Monitoring will run for $Days day(s), updating the report every $IntervalMinutes minute(s)." -ForegroundColor Yellow
    Write-Host "WARNING: Please leave this PowerShell window open until the monitoring is complete." -ForegroundColor Red
}

$endTime = (Get-Date).AddDays($Days)
$historyData = @()

# Static System Data
$os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
$totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$cpuInfo = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue

while ($true) {
    $timestampLabel = (Get-Date).ToString("MM/dd HH:mm")
    Write-Host "[$(Get-Date)] Gathering sample..." -ForegroundColor White

    # 1. Current CPU & RAM
    $osCurrent = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
    $cpuCurrent = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
    
    $freeRam = [math]::Round($osCurrent.FreePhysicalMemory / 1MB, 2)
    $usedRam = $totalRam - $freeRam
    $ramPercent = [math]::Round(($usedRam / $totalRam) * 100, 2)
    $cpuLoad = if ($cpuCurrent.LoadPercentage -eq $null) { 0 } else { ($cpuCurrent | Measure-Object -Property LoadPercentage -Average).Average }

    # 2. Disk Space
    $disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction SilentlyContinue | Select-Object DeviceID, VolumeName, 
        @{n='SizeGB';e={[math]::Round($_.Size / 1GB, 2)}},
        @{n='FreeGB';e={[math]::Round($_.FreeSpace / 1GB, 2)}},
        @{n='UsedPercent';e={[math]::Round((($_.Size - $_.FreeSpace) / $_.Size) * 100, 2)}}

    # 3. Top Apps & User Resource Aggregation
    $allProcesses = Get-Process -IncludeUserName -ErrorAction SilentlyContinue
    $topCpu = $allProcesses | Sort-Object CPU -Descending | Select-Object -First 10 Name, @{n='CPU';e={[math]::Round($_.CPU, 2)}}, Id, UserName
    $topRam = $allProcesses | Sort-Object WorkingSet -Descending | Select-Object -First 10 Name, @{n='RAM_MB';e={[math]::Round($_.WorkingSet / 1MB, 2)}}, Id, UserName

    # User Aggregation
    $userStats = $allProcesses | Where-Object { $_.UserName -ne $null -and $_.UserName -notmatch "SYSTEM|LOCAL SERVICE|NETWORK SERVICE|DWM" } | Group-Object UserName | ForEach-Object {
        $userCpu = [math]::Round(($_.Group | Measure-Object -Property CPU -Sum).Sum, 2)
        $userRam = [math]::Round((($_.Group | Measure-Object -Property WorkingSet -Sum).Sum / 1MB), 2)
        [PSCustomObject]@{
            Username = $_.Name.Replace('\','\\') # Escape backslashes for JS array
            CPU = $userCpu
            RAM = $userRam
        }
    } | Sort-Object RAM -Descending | Select-Object -First 10

    # 4. Active Users
    $quserOutput = $null
    try { $quserOutput = quser.exe 2>&1 } catch {}
    $activeUsers = @()
    if ($quserOutput -and $quserOutput.ToString() -notmatch "No User exists") {
        $quserLines = $quserOutput -replace '\s{2,}', ',' | Select-Object -Skip 1
        foreach ($line in $quserLines) {
            $parts = $line.Split(',')
            if ($parts.Count -ge 5) {
                $activeUsers += [PSCustomObject]@{
                    Username = $parts[0].Trim('>').Trim()
                    SessionName = $parts[1].Trim()
                    ID = $parts[2].Trim()
                    State = $parts[3].Trim()
                    IdleTime = $parts[4].Trim()
                    LogonTime = ($parts[5..($parts.Count-1)] -join ' ').Trim()
                }
            }
        }
    }

    # 5. Event Logs (Since script started, or last 24h if just started)
    $logLookback = if ($historyData.Count -eq 0) { (Get-Date).AddDays(-1) } else { (Get-Date).AddDays(-$Days) }
    
    $appCrashes = Get-WinEvent -FilterHashtable @{LogName='Application'; Level=2; StartTime=$logLookback} -ErrorAction SilentlyContinue | Where-Object { $_.Id -eq 1000 -or $_.Id -eq 1002 }
    $appCrashCount = if ($appCrashes) { $appCrashes.Count } else { 0 }
    $topCrashingApps = if ($appCrashes) {
        $appCrashes | ForEach-Object { if ($_.Properties[0].Value) { $_.Properties[0].Value } else { "Unknown" } } | Group-Object | Sort-Object Count -Descending | Select-Object -First 5 Name, Count
    } else { @() }

    $sysErrors = Get-WinEvent -FilterHashtable @{LogName='System'; Level=2,3; StartTime=$logLookback} -ErrorAction SilentlyContinue
    $diskErrors = @($sysErrors | Where-Object { $_.ProviderName -match "disk|storahci|Ntfs" })
    $netErrors = @($sysErrors | Where-Object { $_.ProviderName -match "TCPIP|NDIS" })

    # 6. Record History for Charts
    $historyData += [PSCustomObject]@{
        Time = $timestampLabel
        CPU = $cpuLoad
        RAM = $ramPercent
    }

    # Limit history array in memory to prevent huge RAM bloat on very long runs (e.g. max 1000 points)
    if ($historyData.Count -gt 1000) { $historyData = $historyData[($historyData.Count - 1000)..($historyData.Count - 1)] }

    # Parse Chart Arrays for JS (Trend Line)
    $jsLabels = ($historyData | ForEach-Object { "`"$($_.Time)`"" }) -join ","
    $jsCpu = ($historyData | ForEach-Object { $_.CPU }) -join ","
    $jsRam = ($historyData | ForEach-Object { $_.RAM }) -join ","

    # Parse Chart Arrays for JS (User Bar Impact)
    $jsUserLabels = ($userStats | ForEach-Object { "`"$($_.Username)`"" }) -join ","
    $jsUserCpu = ($userStats | ForEach-Object { $_.CPU }) -join ","
    $jsUserRam = ($userStats | ForEach-Object { $_.RAM }) -join ","

    # Generate Recommendations
    $recommendations = @()
    if ($cpuLoad -gt 85) { $recommendations += "Critical: High CPU utilization ($cpuLoad%). Consider investigating the top CPU-consuming apps or scaling up compute resources." }
    if ($ramPercent -gt 85) { $recommendations += "Critical: System is running low on memory ($ramPercent% used). Suggest adding more RAM." }
    if ($userStats -and $userStats[0].RAM -gt ($totalRam * 1024 * 0.5)) { $recommendations += "Warning: User $($userStats[0].Username -replace '\\\\','\') is consuming more than 50% of the entire Server RAM." }
    $lowDisk = $disks | Where-Object { $_.UsedPercent -gt 90 }
    foreach ($d in $lowDisk) { $recommendations += "Warning: Drive $($d.DeviceID) is almost full ($($d.UsedPercent)% used). Clean up temporary files." }
    if ($appCrashCount -gt 20) { $recommendations += "Warning: Found $appCrashCount application crashes. Applications to investigate: $(($topCrashingApps | Select-Object -ExpandProperty Name) -join ', ')." }
    if ($diskErrors.Count -gt 10) { $recommendations += "Critical: Found $($diskErrors.Count) disk-related errors in the System log. Failing disks severely impact performance." }
    if ($recommendations.Count -eq 0) { $recommendations += "Success: All core metrics look healthy. No immediate actions required." }

    # HTML Helpers
    function Write-TableRow ($ObjectArray) {
        if (-not $ObjectArray) { return "<tr><td colspan='100%' style='text-align:center'>No data available.</td></tr>" }
        $props = $ObjectArray[0].PSObject.Properties.Name
        $html = "<tr><th>$($props -join '</th><th>')</th></tr>`n"
        foreach ($item in $ObjectArray) {
            $html += "<tr>"
            foreach ($p in $props) {
                $val = $item.$p
                if ($val -is [array]) { $val = $val -join ', ' }
                $html += "<td>$val</td>"
            }
            $html += "</tr>`n"
        }
        return $html
    }

    $topCpuHtml = Write-TableRow $topCpu
    $topRamHtml = Write-TableRow $topRam
    $disksHtml = Write-TableRow $disks
    $usersHtml = Write-TableRow $activeUsers
    $appsHtml = Write-TableRow $topCrashingApps

    $errorDetails = @()
    if ($appCrashes -or $sysErrors) {
        $combinedErrors = @()
        if ($appCrashes) { $combinedErrors += $appCrashes }
        if ($sysErrors) { $combinedErrors += $sysErrors }
        
        $errorDetails = $combinedErrors | Sort-Object TimeCreated -Descending | Select-Object -First 15 | ForEach-Object {
            $msg = $_.Message
            if ($msg) { $msg = $msg -replace "`n|`r", " " } else { $msg = "Unknown Error" }
            if ($msg.Length -gt 150) { $msg = $msg.Substring(0, 147) + "..." }
            [PSCustomObject]@{
                Time = if ($_.TimeCreated) { $_.TimeCreated.ToString("MM/dd HH:mm") } else { "N/A" }
                Log = $_.LogName
                Source = $_.ProviderName
                ID = $_.Id
                Message = $msg
            }
        }
    }
    $errorDetailsHtml = Write-TableRow $errorDetails

    $recsHtml = ""
    foreach ($r in $recommendations) {
        $class = if ($r -match "Critical") { "alert-critical" } elseif ($r -match "Warning") { "alert-warning" } else { "alert-success" }
        $recsHtml += "<div class='alert $class'>$r</div>"
    }

    $timeRemaining = ($endTime - (Get-Date))

    $headerStatusHtml = if ($RunOnce) {
        @"
        <p>Report Type: <strong>Point-in-Time Snapshot</strong></p>
        <div style="margin-top: 1rem;">
            <span class="live-badge" style="background: rgba(59, 130, 246, 0.2); color: #60a5fa; border: 1px solid rgba(59, 130, 246, 0.3);">
                <span style="display:inline-block; width:8px; height:8px; background:#60a5fa; border-radius:50%; margin-right:6px;"></span>
                SNAPSHOT COMPLETED
            </span>
        </div>
"@
    } else {
        @"
        <p>Target Duration: $Days Days | Remaining: $($timeRemaining.Days)d $($timeRemaining.Hours)h $($timeRemaining.Minutes)m</p>
        <div style="margin-top: 1rem;">
            <span class="live-badge">MONITORING ACTIVE</span>
        </div>
"@
    }

# Build HTML 
$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Health Report - $($os.CSName)</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap');
        
        :root {
            --bg: #0f172a;
            --surface: rgba(30, 41, 59, 0.7);
            --surface-hover: rgba(30, 41, 59, 0.9);
            --primary: #3b82f6;
            --secondary: #8b5cf6;
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --critical: #ef4444;
            --warning: #f59e0b;
            --success: #10b981;
            --border: rgba(255,255,255,0.1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            background-image: radial-gradient(circle at top right, rgba(59, 130, 246, 0.1), transparent 40%),
                              radial-gradient(circle at bottom left, rgba(139, 92, 246, 0.1), transparent 40%);
            background-attachment: fixed;
            color: var(--text);
            margin: 0;
            padding: 2rem;
            line-height: 1.6;
        }

        .header { text-align: center; margin-bottom: 2rem; animation: fadeIn 1s ease-in-out; }
        .header h1 { font-size: 2.8rem; background: linear-gradient(to right, #60a5fa, #c084fc); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 0.5rem; letter-spacing: -1px; }
        .header p { color: var(--text-muted); font-size: 1.1rem; margin-bottom: 0.5rem;}
        
        .live-badge {
            display: inline-flex; align-items: center; background: rgba(16, 185, 129, 0.2); 
            color: var(--success); padding: 0.3rem 0.8rem; border-radius: 9999px; font-weight: 600; font-size: 0.85rem; border: 1px solid rgba(16,185,129,0.3);
        }

        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .card {
            background: var(--surface); backdrop-filter: blur(12px); border: 1px solid var(--border); border-radius: 16px; padding: 1.5rem;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1); transition: transform 0.3s ease, background 0.3s ease, box-shadow 0.3s ease; animation: slideUp 0.6s ease-out backwards;
        }
        .card:hover { transform: translateY(-5px); background: var(--surface-hover); box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2); border-color: rgba(255,255,255,0.2); }
        .card-title { font-size: 1.25rem; font-weight: 600; margin-bottom: 1.2rem; color: var(--text); border-bottom: 1px solid var(--border); padding-bottom: 0.8rem; display: flex; align-items: center; gap: 0.5rem; }
        
        .chart-container { position: relative; height: 300px; width: 100%; }

        .metric { display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.6rem; padding: 0.4rem 0; border-bottom: 1px dashed rgba(255,255,255,0.05); }
        .metric:last-of-type { border-bottom: none; }
        .metric-label { color: var(--text-muted); font-size: 0.95rem; }
        .metric-value { font-weight: 600; font-size: 1.05rem; }

        .table-wrapper { overflow-x: auto; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
        th, td { padding: 0.8rem 1rem; text-align: left; border-bottom: 1px solid var(--border); }
        th { background-color: rgba(0, 0, 0, 0.2); color: #cbd5e1; font-weight: 600; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 0.05em; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background-color: rgba(255, 255, 255, 0.03); }

        .alert { padding: 1.2rem; border-radius: 12px; margin-bottom: 1rem; font-weight: 500; display: flex; align-items: center; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .alert-critical { background: rgba(239, 68, 68, 0.15); border-left: 5px solid var(--critical); color: #fca5a5; }
        .alert-warning { background: rgba(245, 158, 11, 0.15); border-left: 5px solid var(--warning); color: #fcd34d; }
        .alert-success { background: rgba(16, 185, 129, 0.15); border-left: 5px solid var(--success); color: #6ee7b7; }

        .dashboard-section { margin-bottom: 3.5rem; }
        .dashboard-section > h2 { font-size: 1.5rem; font-weight: 600; margin-bottom: 1.5rem; color: #e2e8f0; display: flex; align-items: center; }
        .dashboard-section > h2::before { content: ''; display: inline-block; width: 8px; height: 24px; background: linear-gradient(to bottom, var(--primary), var(--secondary)); border-radius: 4px; margin-right: 12px; }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

    <div class="header">
        <h1>Server Resource & Health Report</h1>
        <p>Host: <strong style="color:#fff;">$($os.CSName)</strong> | Updated: <strong style="color:#fff;">$(Get-Date)</strong></p>
        $headerStatusHtml
    </div>

    <!-- Recommendations Section -->
    <div class="dashboard-section">
        <h2>Insights & Recommendations (Latest)</h2>
        <div class="card" style="padding: 1rem; border: none; background: transparent; backdrop-filter: none; box-shadow: none;">
            $recsHtml
        </div>
    </div>

    <!-- Trend Charts -->
    <div class="dashboard-section">
        <h2>Resource Utilization Trends</h2>
        <div class="grid" style="grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));">
            <div class="card">
                <div class="card-title">Server Wide Utilization (Over Time)</div>
                <div class="chart-container">
                    <canvas id="resourceChart"></canvas>
                </div>
            </div>
            <div class="card">
                <div class="card-title">User Impact (Top 10 Active Users)</div>
                <div class="chart-container">
                    <canvas id="userChart"></canvas>
                </div>
                <p style="font-size:0.85rem; color:var(--text-muted); margin-top:1rem;">Displays total RAM/CPU consumed by all processes owned by the user.</p>
            </div>
        </div>
    </div>

    <!-- Storage and Hardware -->
    <div class="dashboard-section">
        <h2>Storage & Hardware Health</h2>
        <div class="grid">
            <div class="card" style="grid-column: span 2;">
                <div class="card-title">Logical Disks</div>
                <div class="table-wrapper">
                    <table>$disksHtml</table>
                </div>
            </div>
            <div class="card">
                <div class="card-title">Hardware Errors (Since Script Start)</div>
                <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: -0.5rem; margin-bottom: 1rem;">From Windows System Event Logs</p>
                <div class="metric"><span class="metric-label">Disk Errors</span><span class="metric-value" style="color: $(if($diskErrors.Count -gt 0){"var(--critical)"}else{"var(--success)"})">$($diskErrors.Count)</span></div>
                <div class="metric"><span class="metric-label">Network Errors</span><span class="metric-value" style="color: $(if($netErrors.Count -gt 0){"var(--critical)"}else{"var(--success)"})">$($netErrors.Count)</span></div>
            </div>
        </div>
    </div>

    <!-- Error Details Log -->
    <div class="dashboard-section">
        <h2>Recent Critical Errors Log (Top 15)</h2>
        <div class="card">
            <div class="table-wrapper">
                <table>$errorDetailsHtml</table>
            </div>
        </div>
    </div>

    <!-- Applications -->
    <div class="dashboard-section">
        <h2>Application Utilization & Stability (Latest Sample)</h2>
        <div class="grid">
            <div class="card">
                <div class="card-title">Top 10 CPU Consumers</div>
                <div class="table-wrapper">
                    <table>$topCpuHtml</table>
                </div>
            </div>
            <div class="card">
                <div class="card-title">Top 10 Memory Consumers</div>
                <div class="table-wrapper">
                    <table>$topRamHtml</table>
                </div>
            </div>
            <div class="card">
                <div class="card-title">Crashing Apps</div>
                <div class="table-wrapper">
                    <table>$appsHtml</table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Active Users -->
    <div class="dashboard-section">
        <h2>Active User Sessions</h2>
        <div class="card">
            <div class="table-wrapper">
                <table>$usersHtml</table>
            </div>
        </div>
    </div>

    <script>
        // Server Trend Chart
        const ctx = document.getElementById('resourceChart').getContext('2d');
        const resourceChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [$jsLabels],
                datasets: [
                    {
                        label: 'CPU Usage (%)',
                        data: [$jsCpu],
                        borderColor: '#3b82f6',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    },
                    {
                        label: 'RAM Usage (%)',
                        data: [$jsRam],
                        borderColor: '#8b5cf6',
                        backgroundColor: 'rgba(139, 92, 246, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                color: '#cbd5e1',
                plugins: {
                    legend: { labels: { color: '#f8fafc' } }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        grid: { color: 'rgba(255,255,255,0.1)' },
                        ticks: { color: '#94a3b8' }
                    },
                    x: {
                        grid: { display: false },
                        ticks: { color: '#94a3b8', maxTicksLimit: 20 }
                    }
                }
            }
        });

        // User Impact Bar Chart
        const userCtx = document.getElementById('userChart').getContext('2d');
        const userChart = new Chart(userCtx, {
            type: 'bar',
            data: {
                labels: [$jsUserLabels],
                datasets: [
                    {
                        label: 'RAM Consumption (MB)',
                        data: [$jsUserRam],
                        backgroundColor: 'rgba(139, 92, 246, 0.7)',
                        borderColor: '#8b5cf6',
                        borderWidth: 1,
                        yAxisID: 'y'
                    },
                    {
                        label: 'CPU Processing Impact',
                        data: [$jsUserCpu],
                        backgroundColor: 'rgba(59, 130, 246, 0.7)',
                        borderColor: '#3b82f6',
                        borderWidth: 1,
                        yAxisID: 'y1'
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                color: '#cbd5e1',
                plugins: {
                    legend: { labels: { color: '#f8fafc' } },
                    tooltip: { mode: 'index', intersect: false }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { color: '#94a3b8' }
                    },
                    y: {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        title: { display: true, text: 'RAM (MB)', color: '#94a3b8' },
                        grid: { color: 'rgba(255,255,255,0.1)' },
                        ticks: { color: '#94a3b8' }
                    },
                    y1: {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        title: { display: true, text: 'CPU Impact', color: '#94a3b8' },
                        grid: { drawOnChartArea: false },
                        ticks: { color: '#94a3b8' }
                    }
                }
            }
        });
    </script>
</body>
</html>
"@

    # Save HTML Report
    $html | Out-File -FilePath $ExportPath -Encoding UTF8
    Write-Host "[$(Get-Date)] Report Updated: $ExportPath" -ForegroundColor Green

    if ($RunOnce -or (Get-Date) -ge $endTime) {
        Write-Host "Monitoring Period Completed!" -ForegroundColor Cyan
        break
    }

    Write-Host "Sleeping for $IntervalMinutes minute(s)..." -ForegroundColor DarkGray
    Start-Sleep -Seconds ($IntervalMinutes * 60)
}
```



***

## REFERENCES

* [https://github.com/3ls3if/Windows-Server-Health-Monitor/tree/main](https://github.com/3ls3if/Windows-Server-Health-Monitor/tree/main)
