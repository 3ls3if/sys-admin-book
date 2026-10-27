---
icon: globe-pointer
---

# IIS log parser — extract client IPs for requests served on s-port 80 or 443

{% hint style="warning" %}
This parses W3C IIS logs (default folder `C:\inetpub\logs\LogFiles\`) and writes filtered results to CSV. Useful for historical analysis / request logs.

Save as `Parse-IISLogs-Ports80-443.ps1` and run (no admin required unless access is restricted):
{% endhint %}

```powershell
# Parse-IISLogs-Ports80-443.ps1
# Scans IIS W3C log files under C:\inetpub\logs\LogFiles and extracts entries where s-port is 80 or 443
# Edit $IISLogRoot and $OutputFile as needed

$IISLogRoot = "C:\inetpub\logs\LogFiles"
$OutputFolder = "C:\Logs"
if (!(Test-Path $OutputFolder)) { New-Item -Path $OutputFolder -ItemType Directory | Out-Null }

$timestamp = (Get-Date).ToString('yyyyMMdd_HHmmss')
$OutputFile = Join-Path $OutputFolder "iis_clients_ports80_443_$timestamp.csv"

# Create header
"Timestamp,ClientIP,ServerPort,Method,Uri,Status,SiteLogFile" | Out-File -FilePath $OutputFile -Encoding utf8

# Find log files
$logFiles = Get-ChildItem -Path $IISLogRoot -Recurse -Filter *.log -ErrorAction SilentlyContinue

foreach ($file in $logFiles) {
    $fields = $null
    # Read file line by line (memory friendly)
    Get-Content -Path $file -Encoding utf8 | ForEach-Object {
        $line = $_.Trim()
        if ($line -like '#Fields:*') {
            # Extract the fields order
            $fields = ($line -replace '^#Fields:\s*','').Split(' ')
            return
        }
        if ($line.StartsWith('#') -or [string]::IsNullOrWhiteSpace($line) -or -not $fields) { return }

        $parts = $line.Split(' ')
        if ($parts.Count -lt $fields.Count) { return } # malformed line

        # Build a hashtable for indexed access by field name
        $obj = @{}
        for ($i = 0; $i -lt $fields.Count; $i++) {
            $obj[$fields[$i]] = $parts[$i]
        }

        # Check server port field (s-port)
        if ($obj.ContainsKey('s-port') -and ($obj['s-port'] -in @('80','443'))) {
            $ts = if ($obj.ContainsKey('date') -and $obj.ContainsKey('time')) { "$($obj['date']) $($obj['time'])" } else { (Get-Date).ToString('o') }
            $outObj = "{0},{1},{2},{3},{4},{5},{6}" -f $ts, ($obj['c-ip'] -replace ',',''), $obj['s-port'], ($obj['cs-method'] -replace ',',''), ($obj['cs-uri-stem'] -replace ',',''), ($obj['sc-status'] -replace ',',''), $file.FullName
            Add-Content -Path $OutputFile -Value $outObj
        }
    }
}

Write-Host "Done. Output written to $OutputFile"
```

**Notes:**

* This script finds `#Fields:` header lines to map fields reliably (so it works across different IIS log formats).
* Outputs: Timestamp (date+time columns from log), client IP (`c-ip`), server port (`s-port`), HTTP method, URI, status, and source log file.
* If your IIS logs are stored elsewhere, change `$IISLogRoot`.

### Extra suggestions & tips

* **If you want unique IP counts** after running the IIS parser, run:
* **Rotate logs / run as scheduled task**: wrap either script into a Scheduled Task to run during the campaign window. For real-time logging, run the TCP capture on a dedicated server/process.
* **Security:** If you capture connections, be mindful of privacy and store logs securely.
* **If behind a reverse proxy / load balancer**: the client IP may be in `X-Forwarded-For` or `cs(User-Agent)` depending on your setup — the IIS parser reads `c-ip` (client IP seen by IIS).

{% hint style="warning" %}
Import-Csv C:\Logs\iis\_clients\_ports80\_443\_YYYYMMDD\_HHMMSS.csv | Group-Object ClientIP | Sort-Object Count -Descending
{% endhint %}

