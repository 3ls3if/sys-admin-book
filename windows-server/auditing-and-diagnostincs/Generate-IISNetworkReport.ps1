#requires -Version 5.1

$ServerName = "example-web01.example.com"
$ServerIP   = "192.0.2.10"

$IISLogRoot = "C:\inetpub\logs\LogFiles"
$SiteLogFolder = $null
$DaysToAnalyze = 7
$OutputDirectory = "C:\IIS-Network-Reports"

$ErrorActionPreference = "SilentlyContinue"

if (!(Test-Path $OutputDirectory)) {
    New-Item -Path $OutputDirectory -ItemType Directory -Force | Out-Null
}

$ReportDate = Get-Date -Format "yyyyMMdd_HHmmss"
$DetailedCsv = Join-Path $OutputDirectory "IIS_Detailed_Traffic_$ReportDate.csv"
$SuspiciousCsv = Join-Path $OutputDirectory "IIS_Suspicious_Traffic_$ReportDate.csv"
$IPSummaryCsv = Join-Path $OutputDirectory "IIS_IP_Summary_$ReportDate.csv"
$EndpointCsv = Join-Path $OutputDirectory "IIS_Endpoint_Summary_$ReportDate.csv"
$HTMLReport = Join-Path $OutputDirectory "IIS_Network_Report_$ReportDate.html"
$StartDate = (Get-Date).AddDays(-$DaysToAnalyze)

function Get-CountryFromIP {
    param([string]$IP)

    if ($IP -match '^10\.' -or $IP -match '^192\.168\.' -or
        $IP -match '^172\.(1[6-9]|2[0-9]|3[0-1])\.' -or
        $IP -eq '127.0.0.1' -or $IP -eq '::1') {
        return 'Private/Local'
    }

    try {
        $r = Invoke-RestMethod -Uri "http://ip-api.com/json/$IP?fields=status,country,countryCode" -TimeoutSec 5
        if ($r.status -eq 'success') { return "$($r.country) [$($r.countryCode)]" }
    } catch {}

    return 'Unknown'
}

function Get-TrafficClassification {
    param(
        [string]$URL,
        [string]$UserAgent,
        [int]$StatusCode,
        [string]$Method
    )

    $reasons = New-Object System.Collections.Generic.List[string]
    $u = ($URL | Out-String).ToLower()
    $ua = ($UserAgent | Out-String).ToLower()

    if ($ua -match 'bot|crawler|spider|slurp|bingpreview|facebookexternalhit|ahrefs|semrush|mj12bot|dotbot|petalbot|bytespider') {
        $reasons.Add('Bot/Crawler User-Agent')
    }

    if ($u -match 'wp-admin|wp-login|xmlrpc\.php|\.env|phpmyadmin|adminer|cgi-bin|vendor/phpunit|\.git|actuator|server-status') {
        $reasons.Add('Common vulnerability/scanner path')
    }

    if ($u -match '\.bak|\.backup|\.sql|\.config|web\.config|appsettings\.json') {
        $reasons.Add('Sensitive file probing')
    }

    if ($u -match 'union(\+|%20)+select|select(\+|%20)+.*from|drop(\+|%20)+table|<script|javascript:|\.\./') {
        $reasons.Add('Possible injection/path traversal')
    }

    if ($StatusCode -eq 404) { $reasons.Add('HTTP 404 - Resource Not Found') }
    if ($StatusCode -ge 500) { $reasons.Add('HTTP 5xx Server Error') }
    if ($StatusCode -eq 401 -or $StatusCode -eq 403) {
        $reasons.Add('Authentication/Authorization response')
    }

    if ($Method -notin @('GET','POST','HEAD','OPTIONS')) {
        $reasons.Add('Unusual HTTP method')
    }

    if ($reasons.Count -eq 0) { return 'Normal' }
    return ($reasons -join '; ')
}

$logFiles = if ($SiteLogFolder -and (Test-Path $SiteLogFolder)) {
    Get-ChildItem $SiteLogFolder -Filter '*.log' -File |
        Where-Object LastWriteTime -ge $StartDate
} else {
    Get-ChildItem $IISLogRoot -Filter '*.log' -File -Recurse |
        Where-Object LastWriteTime -ge $StartDate
}

if (!$logFiles) {
    Write-Error 'No IIS log files found.'
    exit 1
}

$records = New-Object System.Collections.Generic.List[object]

foreach ($logFile in $logFiles) {
    $fields = $null

    foreach ($line in Get-Content $logFile.FullName) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }

        if ($line.StartsWith('#Fields:')) {
            $fields = $line.Substring(8).Trim() -split '\s+'
            continue
        }

        if ($line.StartsWith('#') -or !$fields) { continue }

        $values = $line -split '\s+'
        if ($values.Count -lt $fields.Count) { continue }

        $row = @{}
        for ($i = 0; $i -lt $fields.Count; $i++) {
            $row[$fields[$i]] = $values[$i]
        }

        try {
            $dt = [datetime]::ParseExact(
                "$($row['date']) $($row['time'])",
                'yyyy-MM-dd HH:mm:ss',
                $null
            )
        } catch { continue }

        if ($dt -lt $StartDate) { continue }

        $ip = $row['c-ip']
        if (!$ip) { continue }

        $method = if ($row['cs-method']) { $row['cs-method'] } else { 'Unknown' }
        $url = if ($row['cs-uri-stem']) { $row['cs-uri-stem'] } else { '/' }

        $status = 0
        try { $status = [int]$row['sc-status'] } catch {}

        $ua = $row['cs(User-Agent)']
        $query = $row['cs-uri-query']
        $ref = $row['cs(Referer)']

        $records.Add([pscustomobject]@{
            DateTime = $dt
            SourceIP = $ip
            Method = $method
            URL = $url
            QueryString = $query
            StatusCode = $status
            SubStatus = $row['sc-substatus']
            Win32Status = $row['sc-win32-status']
            UserAgent = $ua
            Referer = $ref
            Classification = Get-TrafficClassification $url $ua $status $method
            LogFile = $logFile.Name
        })
    }
}

if ($records.Count -eq 0) {
    Write-Error 'No traffic records found in the selected period.'
    exit 1
}

$ipCountry = @{}
foreach ($ip in ($records.SourceIP | Select-Object -Unique)) {
    $ipCountry[$ip] = Get-CountryFromIP $ip
}

$enriched = foreach ($r in $records) {
    [pscustomobject]@{
        DateTime = $r.DateTime
        SourceIP = $r.SourceIP
        Country = $ipCountry[$r.SourceIP]
        Method = $r.Method
        URL = $r.URL
        QueryString = $r.QueryString
        StatusCode = $r.StatusCode
        SubStatus = $r.SubStatus
        Win32Status = $r.Win32Status
        UserAgent = $r.UserAgent
        Referer = $r.Referer
        Classification = $r.Classification
        LogFile = $r.LogFile
    }
}

$ipSummary = $enriched | Group-Object SourceIP | ForEach-Object {
    $items = $_.Group

    [pscustomobject]@{
        SourceIP = $_.Name
        Country = $items[0].Country
        TotalRequests = $items.Count
        GETRequests = ($items | Where-Object Method -eq 'GET').Count
        POSTRequests = ($items | Where-Object Method -eq 'POST').Count
        HTTP401 = ($items | Where-Object StatusCode -eq 401).Count
        HTTP403 = ($items | Where-Object StatusCode -eq 403).Count
        HTTP404 = ($items | Where-Object StatusCode -eq 404).Count
        HTTP5xx = ($items | Where-Object StatusCode -ge 500).Count
        BotRequests = ($items | Where-Object Classification -match 'Bot|Crawler').Count
        SuspiciousRequests = ($items | Where-Object Classification -ne 'Normal').Count
        TopEndpoints = (
            $items | Group-Object URL | Sort-Object Count -Descending |
            Select-Object -First 5 |
            ForEach-Object { "$($_.Name) ($($_.Count))" }
        ) -join ' | '
    }
} | Sort-Object TotalRequests -Descending

$endpointSummary = $enriched | Group-Object URL | ForEach-Object {
    $items = $_.Group

    [pscustomobject]@{
        Endpoint = $_.Name
        Requests = $items.Count
        UniqueIPs = ($items.SourceIP | Select-Object -Unique).Count
        GET = ($items | Where-Object Method -eq 'GET').Count
        POST = ($items | Where-Object Method -eq 'POST').Count
        HTTP2xx = ($items | Where-Object { $_.StatusCode -ge 200 -and $_.StatusCode -lt 300 }).Count
        HTTP3xx = ($items | Where-Object { $_.StatusCode -ge 300 -and $_.StatusCode -lt 400 }).Count
        HTTP4xx = ($items | Where-Object { $_.StatusCode -ge 400 -and $_.StatusCode -lt 500 }).Count
        HTTP5xx = ($items | Where-Object { $_.StatusCode -ge 500 }).Count
        Suspicious = ($items | Where-Object Classification -ne 'Normal').Count
    }
} | Sort-Object Requests -Descending

$suspicious = $enriched | Where-Object Classification -ne 'Normal'
$bots = $enriched | Where-Object Classification -match 'Bot|Crawler'

$enriched | Sort-Object DateTime | Export-Csv $DetailedCsv -NoTypeInformation -Encoding UTF8
$suspicious | Sort-Object DateTime | Export-Csv $SuspiciousCsv -NoTypeInformation -Encoding UTF8
$ipSummary | Export-Csv $IPSummaryCsv -NoTypeInformation -Encoding UTF8
$endpointSummary | Export-Csv $EndpointCsv -NoTypeInformation -Encoding UTF8

function Table($data) {
    if ($data) { $data | ConvertTo-Html -Fragment }
    else { '<p>No data found.</p>' }
}

$total = $enriched.Count
$uniqueIPs = ($enriched.SourceIP | Select-Object -Unique).Count
$countries = ($enriched.Country | Select-Object -Unique).Count
$http404 = ($enriched | Where-Object StatusCode -eq 404).Count
$http403 = ($enriched | Where-Object StatusCode -eq 403).Count
$http5xx = ($enriched | Where-Object StatusCode -ge 500).Count

$countrySummary = $enriched | Group-Object Country |
    Sort-Object Count -Descending | Select-Object -First 20 Name,Count

$uaSummary = $enriched | Group-Object UserAgent |
    Sort-Object Count -Descending | Select-Object -First 20 Name,Count

$suspEndpoints = $suspicious | Group-Object URL |
    Sort-Object Count -Descending | Select-Object -First 20 Name,Count

$html = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IIS Network Traffic Report</title>
<style>
body{font-family:Arial;margin:30px;background:#f4f6f8;color:#222}
h1,h2{color:#374151}
.header,.card{background:white;padding:20px;border-radius:8px;margin:10px 0}
.cards{display:flex;flex-wrap:wrap;gap:10px}
.card{min-width:140px}.value{font-size:26px;font-weight:bold}
table{width:100%;border-collapse:collapse;background:white;font-size:12px}
th{background:#374151;color:white;padding:7px;text-align:left}
td{padding:6px;border-bottom:1px solid #ddd;word-break:break-word}
.danger{background:#f8d7da;padding:15px;border-left:5px solid #dc3545}
.ok{background:#d1e7dd;padding:15px;border-left:5px solid #198754}
</style>
</head>
<body>
<div class="header">
<h1>IIS Network Traffic Analysis</h1>
<p><b>Example Website:</b> $ServerName<br>
<b>Example Server IP:</b> $ServerIP<br>
<b>Period:</b> $($StartDate.ToString('yyyy-MM-dd HH:mm:ss')) -
$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))</p>
</div>

<div class="cards">
<div class="card">Requests<div class="value">$total</div></div>
<div class="card">Unique IPs<div class="value">$uniqueIPs</div></div>
<div class="card">Countries<div class="value">$countries</div></div>
<div class="card">Bot Requests<div class="value">$($bots.Count)</div></div>
<div class="card">Suspicious<div class="value">$($suspicious.Count)</div></div>
<div class="card">404<div class="value">$http404</div></div>
<div class="card">403<div class="value">$http403</div></div>
<div class="card">5xx<div class="value">$http5xx</div></div>
</div>

$(if($suspicious.Count -gt 0) {
"<div class='danger'><b>Suspicious indicators detected.</b>
Review the suspicious traffic CSV and affected endpoints.
These heuristics do not prove malicious activity or compromise.</div>"
} else {
"<div class='ok'><b>No configured suspicious request indicators were detected.</b></div>"
})

<h2>Top Source IPs</h2>
$(Table ($ipSummary | Select-Object -First 20))

<h2>Top Endpoints</h2>
$(Table ($endpointSummary | Select-Object -First 20))

<h2>Traffic by Country</h2>
$(Table $countrySummary)

<h2>Top User Agents</h2>
$(Table $uaSummary)

<h2>Suspicious Affected Endpoints</h2>
$(Table $suspEndpoints)

<h2>Suspicious Traffic Details</h2>
$(Table ($suspicious | Sort-Object DateTime -Descending |
    Select-Object -First 100 DateTime,SourceIP,Country,Method,URL,StatusCode,UserAgent,Classification))

<h2>Methodology</h2>
<div class="header">
<p>Traffic is classified using configurable heuristics for bot/crawler signatures,
common scanner paths, sensitive file probing, basic injection/path-traversal
indicators, unusual HTTP methods and HTTP error responses.</p>
<p>Bot traffic is not automatically malicious. Validate source IPs, User-Agents,
request frequency, endpoint behavior and other security telemetry before taking action.</p>
<p>For production use, consider a local GeoIP database instead of an external API.</p>
</div>
</body>
</html>
"@

$html | Out-File $HTMLReport -Encoding UTF8

Write-Host ""
Write-Host "Reports generated in $OutputDirectory"
Write-Host "Detailed Traffic : $DetailedCsv"
Write-Host "Suspicious       : $SuspiciousCsv"
Write-Host "IP Summary       : $IPSummaryCsv"
Write-Host "Endpoint Summary : $EndpointCsv"
Write-Host "HTML Report      : $HTMLReport"
