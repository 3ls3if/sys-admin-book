---
icon: cloud-question
---

# Monitor and Log all active TCP connections

### **Script Name:** `Capture-TCPConnections.ps1`

#### **Purpose**

This PowerShell script **monitors and logs all active TCP connections** on ports **80 (HTTP)** and **443 (HTTPS)** on a Windows system.\
It periodically saves the connection details into a CSV file for network analysis or auditing.

***

#### **Key Features**

1. **Monitors:** Established TCP connections (`Get-NetTCPConnection -State Established`).
2. **Ports Tracked:**
   * `80` → HTTP
   * `443` → HTTPS
3. **Logging Interval:** Every **5 seconds** (`$IntervalSeconds = 5`).
4. **Output Format:** CSV file with timestamped filename.
5. **Output Location:** `C:\Logs\` (automatically created if it doesn’t exist).
6. **Stops Manually:** Press **Ctrl + C** to stop the script.



***

## Script

```powershell
# Capture-TCPConnections.ps1
# Logs active TCP connections on ports 80 and 443 every 5 seconds
# Creates a new log file every hour automatically
# Includes process names for better context

# ===== Configuration =====
$OutputFolder    = "C:\Logs"
$IntervalSeconds = 5

# Create log folder if it doesn’t exist
if (!(Test-Path $OutputFolder)) {
    New-Item -Path $OutputFolder -ItemType Directory | Out-Null
}

Write-Host "Logging TCP connections to ports 80 and 443 every $IntervalSeconds seconds."
Write-Host "Logs will be saved in $OutputFolder"
Write-Host "Press Ctrl+C to stop.`n"

# ===== Function to Create New Log File =====
function New-LogFile {
    param([string]$FolderPath)

    $timestamp  = (Get-Date).ToString('yyyyMMdd_HHmmss')
    $OutputFile = Join-Path $FolderPath "tcp_connections_$timestamp.csv"
    
    # Write CSV header
    "Timestamp,LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess,ProcessName" | Out-File -FilePath $OutputFile -Encoding utf8
    return $OutputFile
}

# Create first log file
$OutputFile = New-LogFile -FolderPath $OutputFolder
$LogStartTime = Get-Date

try {
    while ($true) {
        $now = Get-Date
        $timestamp = $now.ToString('o')

        # Create new log file every hour
        if ((New-TimeSpan -Start $LogStartTime -End $now).TotalHours -ge 1) {
            Write-Host "Creating new log file..."
            $OutputFile = New-LogFile -FolderPath $OutputFolder
            $LogStartTime = Get-Date
        }

        # Get all established connections on ports 80 and 443
        $connections = Get-NetTCPConnection -State Established -LocalPort 80,443 -ErrorAction SilentlyContinue

        foreach ($conn in $connections) {
            # Try to get process name from PID
            $processName = ""
            try {
                $processName = (Get-Process -Id $conn.OwningProcess -ErrorAction Stop).ProcessName
            } catch {
                $processName = "N/A"
            }

            # Build log line
            $line = "{0},{1},{2},{3},{4},{5},{6},{7}" -f `
                $timestamp, $conn.LocalAddress, $conn.LocalPort, `
                $conn.RemoteAddress, $conn.RemotePort, $conn.State, `
                $conn.OwningProcess, $processName

            # Append line to file
            Add-Content -Path $OutputFile -Value $line
        }

        Start-Sleep -Seconds $IntervalSeconds
    }
}
catch {
    Write-Error "Script stopped: $($_.Exception.Message)"
}

```

***

#### **Step-by-Step Explanation**

**1. Set Output Folder**

```powershell
$OutputFolder = "C:\Logs"
if (!(Test-Path $OutputFolder)) { New-Item -Path $OutputFolder -ItemType Directory | Out-Null }
```

* Checks if the folder `C:\Logs` exists.
* If not, creates it to store log files.

***

**2. Create a Timestamped Log File**

```powershell
$timestamp = (Get-Date).ToString('yyyyMMdd_HHmmss')
$OutputFile = Join-Path $OutputFolder "tcp_connections_$timestamp.csv"
```

* Generates a filename with the current date and time (e.g., `tcp_connections_20251009_131317.csv`).

***

**3. Write CSV Header**

```powershell
"Timestamp,LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess" | Out-File -FilePath $OutputFile -Encoding utf8
```

* Defines column headers for the CSV file.

***

**4. Set Logging Interval**

```powershell
$IntervalSeconds = 5
```

* Logs data every **5 seconds** (can be changed).

***

**5. Continuous Monitoring Loop**

```powershell
while ($true) {
    $now = (Get-Date).ToString('o')
    $conns = Get-NetTCPConnection -State Established -LocalPort 80,443 -ErrorAction SilentlyContinue
    foreach ($c in $conns) {
        $line = "{0},{1},{2},{3},{4},{5},{6}" -f $now, $c.LocalAddress, $c.LocalPort, $c.RemoteAddress, $c.RemotePort, $c.State, $c.OwningProcess
        Add-Content -Path $OutputFile -Value $line
    }
    Start-Sleep -Seconds $IntervalSeconds
}
```

**Explanation:**

* Infinite loop (`while ($true)`) — runs until stopped manually.
* Gets all active TCP connections on ports 80 and 443.
* For each connection:
  * Extracts details (local/remote address & port, state, process ID).
  * Logs the data with a timestamp.
* Waits 5 seconds, then repeats.

***

**6. Error Handling**

```powershell
catch [System.Exception] {
    Write-Error "Stopped: $($_.Exception.Message)"
}
```

* Catches and displays any errors (e.g., permission issues, script interruption).

***

#### **Sample CSV Output**

```
Timestamp,LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess
2025-10-09T13:13:22.1234567Z,192.168.1.5,443,172.217.167.46,52438,Established,1234
2025-10-09T13:13:27.6543210Z,192.168.1.5,80,104.244.42.1,51322,Established,2567
```

***

#### **Use Cases**

* Monitoring **web traffic** activity on a local server.
* Tracking **active HTTP/HTTPS connections** for forensic or troubleshooting purposes.
* Identifying **which processes (by PID)** are using network ports 80/443.
* Useful in **incident response**, **network auditing**, or **security monitoring**.

***

#### **Note**

* Must be run with **administrator privileges** to access all process and connection data.
* You can modify `$IntervalSeconds` or add other ports (e.g., 22, 25, 8080) for broader monitoring.
