---
icon: windows
---

# Windows Server Audit Script

### Overview

The Windows Security Auditor is a PowerShell script that performs comprehensive security assessments of Windows systems. It analyzes system configuration, installed applications, security settings, event logs, and detects security software like EDR (Endpoint Detection and Response) and backup solutions. The tool generates an interactive HTML report with detailed findings and remediation recommendations.

### Features

#### 🛡️ **Security Analysis**

* **System Information**: OS details, hardware specs, uptime, domain membership
* **Security Configuration**: Firewall status, UAC settings, SMB protocols, Windows Defender
* **User & Group Analysis**: Local users, Administrators, Remote Desktop Users
* **Network Configuration**: IP addresses, DNS, gateways, MAC addresses

#### 🔍 **Threat Detection**

* **Installed Applications**: Security scoring based on vendor reputation
* **Startup Applications**: Analysis of auto-start programs with risk classification
* **Security Events**: Review of Windows Event Logs for critical events
* **EDR Detection**: Sophos and other Endpoint Detection & Response solutions
* **Backup Solution Detection**: Acronis and other backup software monitoring

#### 📊 **Reporting**

* **Interactive HTML Report**: Collapsible sections, search functionality
* **Security Scoring**: Overall security score with color-coded risk levels
* **Executive Summary**: Quick overview with priority actions
* **Detailed Findings**: Severity-based findings with remediation steps
* **Statistics Dashboard**: Visual representation of security posture

#### 🛠️ **Technical Features**

* **Robust Error Handling**: Continues execution even when components fail
* **Exception Management**: Comprehensive error logging and reporting
* **Domain Controller Support**: Special checks for AD environments
* **Extensible Architecture**: Easy to add new detection modules

### Installation

#### Prerequisites

* **Windows PowerShell 5.1+** or **PowerShell 7+**
* **Administrator privileges** (recommended for full access)
* **Execution Policy**: Set to `RemoteSigned` or use `Bypass` for execution



***

## Powershell Script

```ps1
<#
.SYNOPSIS
    CloudTechtiq Enhanced Windows Security Auditor
.DESCRIPTION
    Performs comprehensive security audits on local machines and Domain Controllers.
    Generates a detailed, expandable HTML report with findings and remediation steps.
    Includes: Application inventory, startup programs, security event analysis,
    EDR detection (Sophos), and Backup Solution detection (Acronis).
.OUTPUTS
    HTML report saved to the user's Desktop.
.NOTES
    Version: 4.2
    Author: CloudTechtiq Pvt. Ltd.
    Changes: Added EDR (Sophos) and Backup (Acronis) detection with exception handling
#>

# ===============================
# ENHANCED EXCEPTION HANDLING CONFIGURATION
# ===============================
$ErrorActionPreference = "Continue"  # Changed from "Stop" to continue on errors
$Error.Clear()  # Clear any existing errors
$Script:ExecutionErrors = @()  # Global variable to track errors
$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ReportPath = "$env:USERPROFILE\Desktop\CloudTechtiq_Security_Audit_$Date.html"

# Function to log errors without stopping execution
function Log-Error {
    param(
        [string]$FunctionName,
        [string]$ErrorMessage,
        [string]$ErrorType = "Warning"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $errorEntry = [PSCustomObject]@{
        Timestamp = $timestamp
        Function = $FunctionName
        Message = $ErrorMessage
        Type = $ErrorType
    }
    
    $Script:ExecutionErrors += $errorEntry
    Write-Host "[$ErrorType] $FunctionName`: $ErrorMessage" -ForegroundColor Yellow
}

# Function to safely execute code with error handling
function Invoke-Safely {
    param(
        [string]$FunctionName,
        [scriptblock]$ScriptBlock,
        [object]$DefaultReturn = $null,
        [switch]$ContinueOnError
    )
    
    try {
        return & $ScriptBlock
    }
    catch {
        $errorMsg = "Error in $FunctionName`: $_"
        Log-Error -FunctionName $FunctionName -ErrorMessage $errorMsg -ErrorType "Error"
        
        if ($ContinueOnError) {
            Write-Host "  [!] Continuing despite error in $FunctionName..." -ForegroundColor Yellow
        }
        
        return $DefaultReturn
    }
}

# ===============================
# REMAINING CONFIGURATION
# ===============================
$IsDomainController = Invoke-Safely -FunctionName "Check-DC" -ScriptBlock {
    (Get-WmiObject Win32_ComputerSystem).DomainRole -in @(4, 5)
} -DefaultReturn $false

# Security scoring parameters
$ApplicationSecurityScores = @{
    "Microsoft" = 10
    "Adobe" = 7
    "Java" = 4
    "Chrome" = 8
    "Firefox" = 8
    "Zoom" = 6
    "TeamViewer" = 3
    "AnyDesk" = 2
    "VNC" = 3
    "PuTTY" = 7
    "OpenSSH" = 9
    "Python" = 8
    "Node.js" = 8
    "Docker" = 7
    "VMware" = 8
    "VirtualBox" = 7
    "7-Zip" = 9
    "WinRAR" = 6
    "VLC" = 9
}

# Known risky startup applications
$RiskyStartupApps = @(
    "utorrent", "bittorrent", "torrent", 
    "cryptominer", "miner", "coinminer",
    "keylogger", "spy", "hack", "crack",
    "cheat", "trainer", "patch", "loader"
)

# Known safe startup applications
$SafeStartupApps = @(
    "windows", "microsoft", "intel", "amd", 
    "nvidia", "realtek", "broadcom", "dell",
    "hp", "lenovo", "acer", "asus", "logitech",
    "adobe", "java", "vmware", "citrix", "cisco"
)

# ===============================
# CORE FUNCTIONS (from original script)
# ===============================

function Get-EnhancedGroupMembers {
    <#
    .SYNOPSIS
        Retrieves all members of a specified local group, expanding nested groups.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$GroupName,
        [Parameter(Mandatory = $false)]
        [string]$ComputerName = $env:COMPUTERNAME
    )

    $AllMembers = @()

    try {
        Write-Host "  [i] Retrieving members of group: $GroupName" -ForegroundColor Cyan
        $DirectMembers = Get-LocalGroupMember -Group $GroupName -ErrorAction Stop

        foreach ($Member in $DirectMembers) {
            $MemberObject = [PSCustomObject]@{
                Name           = $Member.Name
                ObjectClass    = $Member.ObjectClass
                Source         = 'Direct'
                ParentGroup    = $GroupName
                PrincipalType  = if ($Member.Name -like "*\$env:COMPUTERNAME*") { 'Local' } elseif ($Member.Name -like "*\*") { 'Domain' } else { 'Unknown' }
            }
            $AllMembers += $MemberObject

            if ($Member.ObjectClass -eq 'Group') {
                Write-Host "  [+] Found nested group: $($Member.Name)" -ForegroundColor Cyan
            }
        }
    } catch {
        $errorMsg = "Error accessing group '$GroupName': $_"
        Log-Error -FunctionName "Get-EnhancedGroupMembers" -ErrorMessage $errorMsg
        $AllMembers = [PSCustomObject]@{
            Name           = "Group '$GroupName' not found or inaccessible"
            ObjectClass    = 'N/A'
            Source         = 'Error'
            ParentGroup    = 'N/A'
            PrincipalType  = 'N/A'
        }
    }

    if ($AllMembers.Count -eq 0) {
        $AllMembers = [PSCustomObject]@{
            Name           = "No members found in '$GroupName'"
            ObjectClass    = 'N/A'
            Source         = 'Empty'
            ParentGroup    = $GroupName
            PrincipalType  = 'N/A'
        }
    }

    return $AllMembers
}

function Get-InstalledApplications {
    <#
    .SYNOPSIS
        Retrieves installed applications with security scoring.
    #>
    Write-Host "  [i] Collecting installed applications..." -ForegroundColor Cyan
    
    $Applications = @()
    
    # Method 1: Get from registry (32-bit and 64-bit)
    $RegPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    
    foreach ($Path in $RegPaths) {
        try {
            if (Test-Path $Path) {
                $Apps = Get-ItemProperty $Path -ErrorAction SilentlyContinue | Where-Object {
                    $null -ne $_.DisplayName -and $_.DisplayName -ne ""
                }
                
                foreach ($App in $Apps) {
                    $AppName = $App.DisplayName
                    $Publisher = if ($App.Publisher) { $App.Publisher } else { "Unknown" }
                    $Version = if ($App.DisplayVersion) { $App.DisplayVersion } else { "Unknown" }
                    $InstallDate = if ($App.InstallDate) { $App.InstallDate } else { "Unknown" }
                    
                    # Calculate security score
                    $SecurityScore = 5  # Default score
                    $ScoreReason = "Neutral application"
                    
                    # Check against known vendors (using case-insensitive regex escape)
                    foreach ($Vendor in $ApplicationSecurityScores.Keys) {
                        # First clean the vendor string, then escape it for regex
                        $CleanVendor = $Vendor -replace '\\', ''
                        $EscapedVendor = [regex]::Escape($CleanVendor)
                        
                        if ($AppName -match $EscapedVendor -or ($Publisher -and $Publisher -match $EscapedVendor)) {
                            $SecurityScore = $ApplicationSecurityScores[$Vendor]
                            $ScoreReason = "Known vendor: $CleanVendor"
                            break
                        }
                    }

                    # Check for risky keywords (case-insensitive)
                    $RiskyKeywords = @("crack", "keygen", "hack", "patch", "trainer", "cheat", "torrent", "miner")
                    foreach ($Keyword in $RiskyKeywords) {
                        if ($AppName -match $Keyword -or ($Publisher -and $Publisher -match $Keyword)) {
                            $SecurityScore = 1
                            $ScoreReason = "Contains risky keyword: $Keyword"
                            break
                        }
                    }
                    
                    # Check for outdated versions of common software
                    if ($AppName -match "(Java|Adobe|Flash|Reader|Chrome|Firefox)") {
                        # For Java specifically, check for older versions
                        if ($AppName -match "Java" -and $Version -match "^(\d+)") {
                            $MajorVersion = [int]$Matches[1]
                            if ($MajorVersion -lt 11) {
                                $SecurityScore = [math]::Min($SecurityScore, 3)
                                $ScoreReason = "Outdated Java version ($MajorVersion)"
                            }
                        }
                        
                        # For Adobe Flash, flag any version as risky (Flash is deprecated)
                        if ($AppName -match "Flash" -or $AppName -match "Adobe Flash") {
                            $SecurityScore = [math]::Min($SecurityScore, 2)
                            $ScoreReason = "Adobe Flash is deprecated and insecure"
                        }
                    }
                    
                    $Applications += [PSCustomObject]@{
                        Name          = $AppName
                        Publisher     = $Publisher
                        Version       = $Version
                        InstallDate   = $InstallDate
                        SecurityScore = $SecurityScore
                        ScoreReason   = $ScoreReason
                    }
                }
            }
        } catch {
            $errorMsg = "Error reading registry path $Path`: $_"
            Log-Error -FunctionName "Get-InstalledApplications" -ErrorMessage $errorMsg
            continue
        }
    }
    
    # Method 2: Get from Programs and Features (alternative method)
    try {
        $Programs = Get-WmiObject -Class Win32_Product -ErrorAction SilentlyContinue | Select-Object Name, Version, Vendor, InstallDate
        
        foreach ($Program in $Programs) {
            if ($Program.Name) {
                $AppName = $Program.Name
                
                # Check if already in list
                if ($Applications.Name -notcontains $AppName) {
                    $SecurityScore = 5
                    $ScoreReason = "Neutral application"
                    
                    foreach ($Vendor in $ApplicationSecurityScores.Keys) {
                        $EscapedVendor = [regex]::Escape($Vendor -replace '\\', '')
                        if ($AppName -match $EscapedVendor -or ($Program.Vendor -and $Program.Vendor -match $EscapedVendor)) {
                            $SecurityScore = $ApplicationSecurityScores[$Vendor]
                            $ScoreReason = "Known vendor: $($Vendor -replace '\\\\', '')"
                            break
                        }
                    }
                    
                    $Applications += [PSCustomObject]@{
                        Name          = $AppName
                        Publisher     = if ($Program.Vendor) { $Program.Vendor } else { "Unknown" }
                        Version       = if ($Program.Version) { $Program.Version } else { "Unknown" }
                        InstallDate   = if ($Program.InstallDate) { 
                            try {
                                [DateTime]::ParseExact($Program.InstallDate.Substring(0,8), "yyyyMMdd", $null).ToString("yyyy-MM-dd")
                            } catch {
                                $Program.InstallDate
                            }
                        } else { "Unknown" }
                        SecurityScore = $SecurityScore
                        ScoreReason   = $ScoreReason
                    }
                }
            }
        }
    } catch {
        $errorMsg = "Could not retrieve programs via WMI: $_"
        Log-Error -FunctionName "Get-InstalledApplications" -ErrorMessage $errorMsg
    }
    
    # Remove duplicates and sort by security score (lowest first)
    try {
        # Group by Name and select the first entry for each group
        $UniqueApps = $Applications | Group-Object Name | ForEach-Object {
            $_.Group | Sort-Object SecurityScore | Select-Object -First 1
        } | Sort-Object SecurityScore, Name
    } catch {
        $errorMsg = "Error processing application list: $_"
        Log-Error -FunctionName "Get-InstalledApplications" -ErrorMessage $errorMsg
        $UniqueApps = $Applications | Select-Object -First 100  # Return first 100 if sorting fails
    }
    
    Write-Host "  [✓] Found $($UniqueApps.Count) installed applications" -ForegroundColor Green
    
    return $UniqueApps
}

function Get-StartupApplications {
    <#
    .SYNOPSIS
        Retrieves startup applications with security analysis.
    #>
    Write-Host "  [i] Analyzing startup applications..." -ForegroundColor Cyan
    
    $StartupItems = @()
    
    # Check common startup locations
    $StartupLocations = @(
        @{Path = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"; Type = "User Startup"},
        @{Path = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"; Type = "System Startup"},
        @{Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; Type = "Registry (HKLM Run)"},
        @{Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; Type = "Registry (HKCU Run)"},
        @{Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; Type = "Registry (HKLM RunOnce)"},
        @{Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; Type = "Registry (HKCU RunOnce)"}
    )
    
    foreach ($Location in $StartupLocations) {
        $Path = $Location.Path
        $Type = $Location.Type
        
        try {
            if ($Path -like "*\*" -and $Path -notlike "*Registry*") {
                # File system path
                if (Test-Path $Path) {
                    $Files = Get-ChildItem -Path $Path -ErrorAction SilentlyContinue
                    
                    foreach ($File in $Files) {
                        $Assessment = "Review Recommended"
                        $RiskLevel = "Medium"
                        $Reason = "Startup application"
                        
                        # Analyze the startup item
                        $FileName = $File.Name.ToLower()
                        
                        # Check for known safe applications
                        $IsSafe = $false
                        foreach ($SafeApp in $SafeStartupApps) {
                            if ($FileName -match $SafeApp) {
                                $Assessment = "Likely Safe"
                                $RiskLevel = "Low"
                                $Reason = "Known safe application: $SafeApp"
                                $IsSafe = $true
                                break
                            }
                        }
                        
                        # Check for risky applications if not already marked safe
                        if (-not $IsSafe) {
                            foreach ($RiskyApp in $RiskyStartupApps) {
                                if ($FileName -match $RiskyApp) {
                                    $Assessment = "Potentially Risky"
                                    $RiskLevel = "High"
                                    $Reason = "Contains risky keyword: $RiskyApp"
                                    break
                                }
                            }
                        }
                        
                        # Check file properties
                        try {
                            $FileVersion = (Get-ItemProperty -Path $File.FullName -ErrorAction SilentlyContinue).VersionInfo.FileVersion
                            if (-not $FileVersion) { $FileVersion = "Unknown" }
                        } catch {
                            $FileVersion = "Unknown"
                        }
                        
                        $StartupItems += [PSCustomObject]@{
                            Name        = $File.Name
                            Path        = $File.FullName
                            Type        = $Type
                            Assessment  = $Assessment
                            RiskLevel   = $RiskLevel
                            Reason      = $Reason
                            FileVersion = $FileVersion
                            LastModified = $File.LastWriteTime.ToString("yyyy-MM-dd HH:mm")
                        }
                    }
                }
            } else {
                # Registry path
                if (Test-Path $Path) {
                    $RegEntries = Get-ItemProperty -Path $Path -ErrorAction SilentlyContinue
                    
                    $RegEntries.PSObject.Properties | Where-Object {
                        $_.Name -notin @("PSPath", "PSParentPath", "PSChildName", "PSDrive", "PSProvider")
                    } | ForEach-Object {
                        $RegValue = $_.Value
                        $RegName = $_.Name
                        
                        $Assessment = "Review Recommended"
                        $RiskLevel = "Medium"
                        $Reason = "Registry startup entry"
                        
                        # Analyze registry entry
                        $RegValueLower = $RegValue.ToLower()
                        
                        # Check for known safe applications
                        $IsSafe = $false
                        foreach ($SafeApp in $SafeStartupApps) {
                            if ($RegValueLower -match $SafeApp -or $RegName.ToLower() -match $SafeApp) {
                                $Assessment = "Likely Safe"
                                $RiskLevel = "Low"
                                $Reason = "Known safe application: $SafeApp"
                                $IsSafe = $true
                                break
                            }
                        }
                        
                        # Check for risky applications
                        if (-not $IsSafe) {
                            foreach ($RiskyApp in $RiskyStartupApps) {
                                if ($RegValueLower -match $RiskyApp -or $RegName.ToLower() -match $RiskyApp) {
                                    $Assessment = "Potentially Risky"
                                    $RiskLevel = "High"
                                    $Reason = "Contains risky keyword: $RiskyApp"
                                    break
                                }
                            }
                        }
                        
                        # Check for suspicious paths
                        if ($RegValueLower -match "(temp|tmp|appdata|local settings|\.\\.*)") {
                            if ($Assessment -eq "Review Recommended") {
                                $Assessment = "Suspicious Location"
                                $RiskLevel = "Medium"
                                $Reason = "Starts from temporary or hidden location"
                            }
                        }
                        
                        $StartupItems += [PSCustomObject]@{
                            Name        = $RegName
                            Path        = $RegValue
                            Type        = $Type
                            Assessment  = $Assessment
                            RiskLevel   = $RiskLevel
                            Reason      = $Reason
                            FileVersion = "N/A (Registry)"
                            LastModified = "N/A"
                        }
                    }
                }
            }
        } catch {
            $errorMsg = "Error checking startup location $Path`: $_"
            Log-Error -FunctionName "Get-StartupApplications" -ErrorMessage $errorMsg
            continue
        }
    }
    
    # Also check scheduled tasks that run at startup
    try {
        $StartupTasks = Get-ScheduledTask -ErrorAction SilentlyContinue | Where-Object {
            $_.Triggers | Where-Object { $_.StartBoundary -like "*AtStartup*" -or $_.Enabled -eq $true }
        } | Select-Object -First 10
        
        foreach ($Task in $StartupTasks) {
            $TaskName = $Task.TaskName
            $TaskPath = $Task.TaskPath
            
            $Assessment = "Review Recommended"
            $RiskLevel = "Medium"
            $Reason = "Scheduled task at startup"
            
            $StartupItems += [PSCustomObject]@{
                Name        = $TaskName
                Path        = $TaskPath
                Type        = "Scheduled Task"
                Assessment  = $Assessment
                RiskLevel   = $RiskLevel
                Reason      = $Reason
                FileVersion = "N/A (Scheduled Task)"
                LastModified = "N/A"
            }
        }
    } catch {
        $errorMsg = "Could not retrieve scheduled tasks: $_"
        Log-Error -FunctionName "Get-StartupApplications" -ErrorMessage $errorMsg
    }
    
    Write-Host "  [✓] Found $($StartupItems.Count) startup items" -ForegroundColor Green
    
    try {
        return $StartupItems | Sort-Object RiskLevel -Descending
    } catch {
        return $StartupItems  # Return unsorted if sorting fails
    }
}

function Get-SecurityEvents {
    <#
    .SYNOPSIS
        Retrieves critical security events from Windows Event Logs.
    #>
    Write-Host "  [i] Analyzing security events..." -ForegroundColor Cyan
    
    $SecurityEvents = @()
    
    # Define critical event IDs to look for
    $CriticalEventIDs = @{
        # Account Management
        4720 = "A user account was created"
        4722 = "A user account was enabled"
        4723 = "An attempt was made to change an account's password"
        4724 = "An attempt was made to reset an account's password"
        4725 = "A user account was disabled"
        4726 = "A user account was deleted"
        4738 = "A user account was changed"
        
        # Logon Events
        4624 = "An account was successfully logged on"
        4625 = "An account failed to log on"
        4634 = "An account was logged off"
        4648 = "A logon was attempted using explicit credentials"
        4672 = "Special privileges assigned to new logon"
        
        # Security Events
        4688 = "A new process has been created"
        4697 = "A service was installed in the system"
        4698 = "A scheduled task was created"
        4699 = "A scheduled task was deleted"
        4700 = "A scheduled task was enabled"
        4701 = "A scheduled task was disabled"
        4702 = "A scheduled task was updated"
        
        # Audit Events
        4719 = "System audit policy was changed"
        4902 = "The Per-user audit policy table was created"
        4907 = "Auditing settings on object were changed"
        
        # Privilege Use
        4673 = "A privileged service was called"
        4674 = "An operation was attempted on a privileged object"
        
        # System Events
        4616 = "System time was changed"
        5024 = "The Windows Firewall Service has started successfully"
        5025 = "The Windows Firewall Service has been stopped"
        5031 = "The Windows Firewall Service blocked an application from accepting incoming connections"
    }
    
    try {
        # Get events from last 7 days
        $StartTime = (Get-Date).AddDays(-7)
        
        # Get Security events
        $Events = Get-WinEvent -LogName "Security" -MaxEvents 100 -ErrorAction SilentlyContinue | 
                  Where-Object { $_.TimeCreated -ge $StartTime -and $_.Id -in $CriticalEventIDs.Keys } |
                  Select-Object -First 20
        
        foreach ($Event in $Events) {
            $EventID = $Event.Id
            $EventTime = $Event.TimeCreated.ToString("yyyy-MM-dd HH:mm:ss")
            $EventSource = "Security"
            
            # Get event message
            $EventMessage = $Event.Message
            if ([string]::IsNullOrEmpty($EventMessage)) {
                $EventMessage = if ($CriticalEventIDs.ContainsKey($EventID)) {
                    $CriticalEventIDs[$EventID]
                } else {
                    "Event ID: $EventID"
                }
            } else {
                # Truncate long messages
                if ($EventMessage.Length -gt 200) {
                    $EventMessage = $EventMessage.Substring(0, 200) + "..."
                }
            }
            
            # Determine severity
            $Severity = "Info"
            $SeverityClass = "event-info"
            
            # Critical events
            if ($EventID -in @(4725, 4726, 4672, 4673, 4719)) {
                $Severity = "Critical"
                $SeverityClass = "event-critical"
            }
            # Error events
            elseif ($EventID -in @(4625, 5025)) {
                $Severity = "Error"
                $SeverityClass = "event-error"
            }
            # Warning events
            elseif ($EventID -in @(4720, 4722, 4697, 4698, 4616)) {
                $Severity = "Warning"
                $SeverityClass = "event-warning"
            }
            # Success events
            elseif ($EventID -in @(4624, 5024)) {
                $Severity = "Success"
                $SeverityClass = "event-success"
            }
            
            $SecurityEvents += [PSCustomObject]@{
                Time     = $EventTime
                EventID  = $EventID
                Source   = $EventSource
                Severity = $Severity
                Message  = $EventMessage
                Class    = $SeverityClass
            }
        }
        
        # Also check System and Application logs for security-related events
        $OtherLogs = @("System", "Application")
        
        foreach ($LogName in $OtherLogs) {
            try {
                $LogEvents = Get-WinEvent -LogName $LogName -MaxEvents 20 -ErrorAction SilentlyContinue |
                            Where-Object { 
                                $_.TimeCreated -ge $StartTime -and 
                                ($_.Message -match "error|fail|denied|blocked|attack|malware|virus|threat" -or
                                 $_.Id -in @(1000, 1001, 1002, 1015, 7022, 7023, 7024, 7026, 7031, 7032, 7034))
                            } |
                            Select-Object -First 10
                
                foreach ($Event in $LogEvents) {
                    $EventTime = $Event.TimeCreated.ToString("yyyy-MM-dd HH:mm:ss")
                    $EventMessage = $Event.Message
                    
                    if ($EventMessage.Length -gt 150) {
                        $EventMessage = $EventMessage.Substring(0, 150) + "..."
                    }
                    
                    $SecurityEvents += [PSCustomObject]@{
                        Time     = $EventTime
                        EventID  = $Event.Id
                        Source   = $LogName
                        Severity = "Warning"
                        Message  = $EventMessage
                        Class    = "event-warning"
                    }
                }
            } catch {
                $errorMsg = "Could not read $LogName log: $_"
                Log-Error -FunctionName "Get-SecurityEvents" -ErrorMessage $errorMsg
            }
        }
        
    } catch {
        $errorMsg = "Could not retrieve security events: $_"
        Log-Error -FunctionName "Get-SecurityEvents" -ErrorMessage $errorMsg
        # Return a placeholder if events can't be accessed
        $SecurityEvents = @(
            [PSCustomObject]@{
                Time     = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                EventID  = "N/A"
                Source   = "Audit Script"
                Severity = "Warning"
                Message  = "Could not access Windows Event Logs. Run script as Administrator."
                Class    = "event-warning"
            }
        )
    }
    
    Write-Host "  [✓] Found $($SecurityEvents.Count) security events" -ForegroundColor Green
    
    try {
        return $SecurityEvents | Sort-Object Time -Descending
    } catch {
        return $SecurityEvents  # Return unsorted if sorting fails
    }
}

function Get-SystemInformation {
    <#
    .SYNOPSIS
        Collects comprehensive system information.
    #>
    try {
        $OS = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
        $ComputerSystem = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue

        if (-not $OS) {
            $OS = @{
                Caption = "Unknown"
                Version = "Unknown"
                BuildNumber = "Unknown"
                OSArchitecture = "Unknown"
                InstallDate = "Unknown"
                LastBootUpTime = "Unknown"
            }
        }
        
        if (-not $ComputerSystem) {
            $ComputerSystem = @{
                Domain = "Unknown"
                Manufacturer = "Unknown"
                Model = "Unknown"
                TotalPhysicalMemory = 0
            }
        }

        $SysInfo = [PSCustomObject]@{
            Hostname          = $env:COMPUTERNAME
            Domain            = $ComputerSystem.Domain
            'DC Role'         = if ($IsDomainController) { 'Yes' } else { 'No' }
            Manufacturer      = $ComputerSystem.Manufacturer
            Model             = $ComputerSystem.Model
            'OS Name'         = $OS.Caption
            'OS Version'      = $OS.Version
            'OS Build'        = $OS.BuildNumber
            Architecture      = $OS.OSArchitecture
            'Install Date'    = $OS.InstallDate
            'Last Boot Time'  = $OS.LastBootUpTime
            'System Uptime'   = if ($OS.LastBootUpTime -ne "Unknown") {
                (New-TimeSpan -Start $OS.LastBootUpTime -End (Get-Date)).ToString("dd\.hh\:mm\:ss")
            } else { "Unknown" }
            'Total Memory (GB)' = if ($ComputerSystem.TotalPhysicalMemory -gt 0) {
                [math]::Round($ComputerSystem.TotalPhysicalMemory / 1GB, 2)
            } else { "Unknown" }
            'Logged-in User'  = "$env:USERDOMAIN\$env:USERNAME"
        }

        return $SysInfo
    } catch {
        $errorMsg = "Error collecting system information: $_"
        Log-Error -FunctionName "Get-SystemInformation" -ErrorMessage $errorMsg
        
        # Return basic information even if CIM fails
        return [PSCustomObject]@{
            Hostname          = $env:COMPUTERNAME
            Domain            = "Error retrieving"
            'DC Role'         = "Unknown"
            Manufacturer      = "Error retrieving"
            Model             = "Error retrieving"
            'OS Name'         = "Windows"
            'OS Version'      = "Unknown"
            'OS Build'        = "Unknown"
            Architecture      = "Unknown"
            'Install Date'    = "Unknown"
            'Last Boot Time'  = "Unknown"
            'System Uptime'   = "Unknown"
            'Total Memory (GB)' = "Unknown"
            'Logged-in User'  = "$env:USERDOMAIN\$env:USERNAME"
        }
    }
}

function Get-DiskInformation {
    <#
    .SYNOPSIS
        Collects disk usage information.
    #>
    try {
        $Disks = Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | Where-Object { $_.Used -or $_.Free } | Select-Object @(
            @{N='Drive';E={$_.Name}},
            @{N='Description';E={if ($_.DisplayRoot) { $_.DisplayRoot } else { "Local Disk" }}},
            @{N='Used (GB)';E={[math]::Round($_.Used / 1GB, 2)}},
            @{N='Free (GB)';E={[math]::Round($_.Free / 1GB, 2)}},
            @{N='Total (GB)';E={[math]::Round(($_.Used + $_.Free) / 1GB, 2)}},
            @{N='Free %';E={if (($_.Used + $_.Free) -gt 0) { [math]::Round(($_.Free / ($_.Used + $_.Free)) * 100, 1) } else { 0 }}}
        )

        return $Disks
    } catch {
        $errorMsg = "Error collecting disk information: $_"
        Log-Error -FunctionName "Get-DiskInformation" -ErrorMessage $errorMsg
        
        return @(
            [PSCustomObject]@{
                Drive = "C"
                Description = "Local Disk (Error)"
                'Used (GB)' = "Error"
                'Free (GB)' = "Error"
                'Total (GB)' = "Error"
                'Free %' = "Error"
            }
        )
    }
}

function Get-NetworkInformation {
    <#
    .SYNOPSIS
        Collects network configuration.
    #>
    try {
        $NetInfo = Get-NetIPConfiguration -Detailed -ErrorAction SilentlyContinue | ForEach-Object {
            [PSCustomObject]@{
                Interface    = $_.InterfaceAlias
                'IPv4 Address' = ($_.IPv4Address.IPAddress -join ', ')
                Subnet       = ($_.IPv4Address.PrefixLength -join ', ')
                Gateway      = if ($_.IPv4DefaultGateway) { $_.IPv4DefaultGateway.NextHop -join ', ' } else { 'None' }
                DNS          = ($_.DNSServer.ServerAddresses -join ', ')
                MAC          = $_.NetAdapter.LinkLayerAddress
                Status       = $_.NetAdapter.Status
            }
        }

        if (-not $NetInfo) {
            $NetInfo = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue | Select-Object @(
                @{N='Interface';E={$_.InterfaceAlias}},
                @{N='IPv4 Address';E={$_.IPAddress}},
                @{N='Subnet';E={$_.PrefixLength}},
                @{N='MAC';E={(Get-NetAdapter -InterfaceIndex $_.InterfaceIndex -ErrorAction SilentlyContinue).MacAddress}}
            )
        }
        
        if (-not $NetInfo) {
            $NetInfo = @(
                [PSCustomObject]@{
                    Interface = "Network information unavailable"
                    'IPv4 Address' = "Error retrieving"
                    Subnet = "N/A"
                    Gateway = "N/A"
                    DNS = "N/A"
                    MAC = "N/A"
                    Status = "N/A"
                }
            )
        }

        return $NetInfo
    } catch {
        $errorMsg = "Error collecting network information: $_"
        Log-Error -FunctionName "Get-NetworkInformation" -ErrorMessage $errorMsg
        
        return @(
            [PSCustomObject]@{
                Interface = "Error retrieving network info"
                'IPv4 Address' = "Error"
                Subnet = "Error"
                Gateway = "Error"
                DNS = "Error"
                MAC = "Error"
                Status = "Error"
            }
        )
    }
}

function Get-LocalUserAccounts {
    <#
    .SYNOPSIS
        Collects local user account information.
    #>
    try {
        $Users = Get-LocalUser -ErrorAction SilentlyContinue | Select-Object @(
            'Name',
            'FullName',
            'Description',
            @{N='Enabled';E={if ($_.Enabled) { 'Yes' } else { 'No' }}},
            @{N='Last Logon';E={if ($_.LastLogon) { $_.LastLogon } else { 'Never' }}},
            @{N='Password Changed';E={$_.PasswordLastSet}},
            @{N='Password Never Expires';E={if ($_.PasswordNeverExpires) { 'Yes' } else { 'No' }}},
            @{N='Account Locked';E={if ($_.Locked) { 'Yes' } else { 'No' }}}
        )

        if (-not $Users) {
            $Users = @(
                [PSCustomObject]@{
                    Name = "Local user information unavailable"
                    FullName = "N/A"
                    Description = "N/A"
                    Enabled = "N/A"
                    'Last Logon' = "N/A"
                    'Password Changed' = "N/A"
                    'Password Never Expires' = "N/A"
                    'Account Locked' = "N/A"
                }
            )
        }

        return $Users
    } catch {
        $errorMsg = "Error collecting local user accounts: $_"
        Log-Error -FunctionName "Get-LocalUserAccounts" -ErrorMessage $errorMsg
        
        return @(
            [PSCustomObject]@{
                Name = "Error retrieving user accounts"
                FullName = "Error"
                Description = "Error"
                Enabled = "Error"
                'Last Logon' = "Error"
                'Password Changed' = "Error"
                'Password Never Expires' = "Error"
                'Account Locked' = "Error"
            }
        )
    }
}

function Get-SecurityConfiguration {
    <#
    .SYNOPSIS
        Collects security-related configuration.
    #>
    $Firewall = $null
    $Defender = $null
    $SMB = $null
    $UAC = $null
    $AuditPolicy = $null
    
    # Firewall
    try {
        $Firewall = Get-NetFirewallProfile -ErrorAction SilentlyContinue | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
    } catch {
        $errorMsg = "Error collecting firewall information: $_"
        Log-Error -FunctionName "Get-SecurityConfiguration" -ErrorMessage $errorMsg
        $Firewall = [PSCustomObject]@{
            Name = "Firewall information unavailable"
            Enabled = "Error"
            DefaultInboundAction = "Error"
            DefaultOutboundAction = "Error"
        }
    }
    
    # Windows Defender
    try {
        if (Get-Command Get-MpComputerStatus -ErrorAction SilentlyContinue) {
            $DefStatus = Get-MpComputerStatus -ErrorAction SilentlyContinue
            $Defender = [PSCustomObject]@{
                'Antivirus Enabled'         = if ($DefStatus.AntivirusEnabled) { 'Yes' } else { 'No' }
                'Real-time Protection'      = if ($DefStatus.RealTimeProtectionEnabled) { 'Yes' } else { 'No' }
                'Antivirus Signature Age'   = if ($DefStatus.AntivirusSignatureAge) { "$($DefStatus.AntivirusSignatureAge) days" } else { 'N/A' }
                'Last Quick Scan'           = if ($DefStatus.LastQuickScanDateTime) { $DefStatus.LastQuickScanDateTime } else { 'N/A' }
                'Last Full Scan'            = if ($DefStatus.LastFullScanDateTime) { $DefStatus.LastFullScanDateTime } else { 'N/A' }
            }
        } else {
            $Defender = [PSCustomObject]@{
                'Antivirus Enabled'         = 'N/A (Defender not available)'
                'Real-time Protection'      = 'N/A'
                'Antivirus Signature Age'   = 'N/A'
                'Last Quick Scan'           = 'N/A'
                'Last Full Scan'            = 'N/A'
            }
        }
    } catch {
        $errorMsg = "Error collecting Defender information: $_"
        Log-Error -FunctionName "Get-SecurityConfiguration" -ErrorMessage $errorMsg
        $Defender = [PSCustomObject]@{
            'Antivirus Enabled'         = 'Error retrieving'
            'Real-time Protection'      = 'Error'
            'Antivirus Signature Age'   = 'Error'
            'Last Quick Scan'           = 'Error'
            'Last Full Scan'            = 'Error'
        }
    }
    
    # SMB Configuration
    try {
        $SMB = Get-SmbServerConfiguration -ErrorAction SilentlyContinue | Select-Object @(
            @{N='SMBv1 Enabled';E={if ($_.EnableSMB1Protocol) { 'Yes' } else { 'No' }}},
            @{N='SMBv2 Enabled';E={if ($_.EnableSMB2Protocol) { 'Yes' } else { 'No' }}},
            @{N='SMB Signing Required';E={if ($_.RequireSecuritySignature) { 'Yes' } else { 'No' }}},
            @{N='Inactive Sessions Timeout (min)';E={$_.AutoDisconnectTimeout}}
        )
    } catch {
        $errorMsg = "Error collecting SMB configuration: $_"
        Log-Error -FunctionName "Get-SecurityConfiguration" -ErrorMessage $errorMsg
        $SMB = [PSCustomObject]@{
            'SMBv1 Enabled' = "Error"
            'SMBv2 Enabled' = "Error"
            'SMB Signing Required' = "Error"
            'Inactive Sessions Timeout (min)' = "Error"
        }
    }
    
    # UAC Configuration
    try {
        $UAC = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -ErrorAction SilentlyContinue | Select-Object @(
            @{N='UAC Enabled';E={if ($_.EnableLUA -eq 1) { 'Yes' } else { 'No' }}},
            @{N='Admin Approval Mode';E={if ($_.ConsentPromptBehaviorAdmin -ne 0) { 'Yes' } else { 'No' }}},
            @{N='Prompt on Elevation';E={if ($_.PromptOnSecureDesktop -eq 1) { 'Yes' } else { 'No' }}}
        )
    } catch {
        $errorMsg = "Error collecting UAC configuration: $_"
        Log-Error -FunctionName "Get-SecurityConfiguration" -ErrorMessage $errorMsg
        $UAC = [PSCustomObject]@{
            'UAC Enabled' = "Error"
            'Admin Approval Mode' = "Error"
            'Prompt on Elevation' = "Error"
        }
    }
    
    # Audit Policy
    try {
        $AuditPolicy = auditpol /get /category:* 2>$null | Select-String "Logon" | Select-Object -First 3 | ForEach-Object {
            [PSCustomObject]@{ 'Audit Policy' = $_.ToString().Trim() }
        }
    } catch {
        $AuditPolicy = [PSCustomObject]@{ 'Audit Policy' = "Could not retrieve audit policy" }
    }

    $SecurityConfig = [PSCustomObject]@{
        Firewall    = $Firewall
        Defender    = $Defender
        SMB         = $SMB
        UAC         = $UAC
        AuditPolicy = $AuditPolicy
    }

    return $SecurityConfig
}

function Get-InstalledUpdates {
    <#
    .SYNOPSIS
        Collects recently installed updates.
    #>
    try {
        $Updates = Get-HotFix -ErrorAction SilentlyContinue | Sort-Object InstalledOn -Descending | Select-Object -First 20 | Select-Object @(
            'HotFixID',
            @{N='Installed On';E={$_.InstalledOn}},
            'Description',
            @{N='Installed By';E={$_.InstalledBy}}
        )

        if (-not $Updates) {
            $Updates = @(
                [PSCustomObject]@{
                    HotFixID = "No update information available"
                    'Installed On' = "N/A"
                    Description = "N/A"
                    'Installed By' = "N/A"
                }
            )
        }

        return $Updates
    } catch {
        $errorMsg = "Error collecting installed updates: $_"
        Log-Error -FunctionName "Get-InstalledUpdates" -ErrorMessage $errorMsg
        
        return @(
            [PSCustomObject]@{
                HotFixID = "Error retrieving updates"
                'Installed On' = "Error"
                Description = "Error"
                'Installed By' = "Error"
            }
        )
    }
}

function Get-SecurityFindings {
    <#
    .SYNOPSIS
        Analyzes collected data and generates security findings.
        Now includes EDR and Backup solution checks.
    #>
    $Findings = @()
    
    try {
        # 1. Check for disabled firewall profiles
        $FirewallProfiles = $null
        try {
            $FirewallProfiles = Get-NetFirewallProfile -ErrorAction SilentlyContinue | Where-Object { $_.Enabled -eq $false }
        } catch {}
        
        if ($FirewallProfiles -and $FirewallProfiles.Count -gt 0) {
            $Findings += [PSCustomObject]@{
                Severity    = 'High'
                ID          = 'SEC-001'
                Title       = 'Firewall Disabled on One or More Profiles'
                Description = "The following firewall profiles are disabled: $($FirewallProfiles.Name -join ', '). This exposes the system to network-based attacks."
                Remediation = 'Enable Windows Firewall for all profiles using: `Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True`'
                Category    = 'Network Security'
            }
        }

        # 2. Check SMBv1
        $SMBConfig = $null
        try {
            $SMBConfig = Get-SmbServerConfiguration -ErrorAction SilentlyContinue
        } catch {}
        
        if ($SMBConfig -and $SMBConfig.EnableSMB1Protocol) {
            $Findings += [PSCustomObject]@{
                Severity    = 'High'
                ID          = 'SEC-002'
                Title       = 'SMBv1 Protocol Enabled'
                Description = 'SMBv1 is an outdated and insecure protocol vulnerable to attacks like EternalBlue. It should be disabled.'
                Remediation = 'Disable SMBv1 using: `Set-SmbServerConfiguration -EnableSMB1Protocol $false` and reboot.'
                Category    = 'Protocol Security'
            }
        }

        # 3. Check for outdated Windows Defender signatures
        try {
            if (Get-Command Get-MpComputerStatus -ErrorAction SilentlyContinue) {
                $DefStatus = Get-MpComputerStatus -ErrorAction SilentlyContinue
                if ($DefStatus -and $DefStatus.AntivirusSignatureAge -gt 7) {
                    $Findings += [PSCustomObject]@{
                        Severity    = 'Medium'
                        ID          = 'SEC-003'
                        Title       = 'Outdated Antivirus Signatures'
                        Description = "Antivirus signatures are $($DefStatus.AntivirusSignatureAge) days old, reducing protection against new threats."
                        Remediation = 'Update Windows Defender signatures manually or ensure regular updates via Windows Update.'
                        Category    = 'Malware Protection'
                    }
                }
            }
        } catch {}

        # 4. Check UAC configuration
        $UACConfig = $null
        try {
            $UACConfig = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -ErrorAction SilentlyContinue
        } catch {}
        
        if ($UACConfig -and $UACConfig.EnableLUA -eq 0) {
            $Findings += [PSCustomObject]@{
                Severity    = 'High'
                ID          = 'SEC-004'
                Title       = 'User Account Control (UAC) Disabled'
                Description = 'UAC is disabled, allowing programs to run with elevated privileges without prompting, increasing malware risk.'
                Remediation = 'Enable UAC by setting HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA to 1 and reboot.'
                Category    = 'Access Control'
            }
        }

        # 5. Check for disk space issues
        $LowDisks = $null
        try {
            $LowDisks = Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | Where-Object {
                $_.Free -gt 0 -and (($_.Free / ($_.Used + $_.Free)) * 100) -lt 10
            }
        } catch {}
        
        if ($LowDisks -and $LowDisks.Count -gt 0) {
            $Findings += [PSCustomObject]@{
                Severity    = 'Medium'
                ID          = 'SEC-005'
                Title       = 'Low Disk Space on One or More Drives'
                Description = "The following drives have less than 10% free space: $($LowDisks.Name -join ', '). This can cause system instability and failed updates."
                Remediation = 'Clean up temporary files, uninstall unused applications, or increase disk capacity.'
                Category    = 'System Health'
            }
        }

        # 6. Check for default administrator account status
        $AdminAccount = $null
        try {
            $AdminAccount = Get-LocalUser -Name "Administrator" -ErrorAction SilentlyContinue
        } catch {}
        
        if ($AdminAccount -and $AdminAccount.Enabled -eq $true) {
            $Findings += [PSCustomObject]@{
                Severity    = 'Medium'
                ID          = 'SEC-006'
                Title       = 'Default Administrator Account Enabled'
                Description = 'The built-in Administrator account is enabled. This is a well-known account name targeted by attackers.'
                Remediation = 'Disable the built-in Administrator account or at least rename it to a non-standard name.'
                Category    = 'Account Security'
            }
        }

        # 7. Check for missing recent updates
        $LastUpdate = $null
        try {
            $LastUpdate = Get-HotFix -ErrorAction SilentlyContinue | Sort-Object InstalledOn -Descending | Select-Object -First 1
        } catch {}
        
        if ($LastUpdate -and $LastUpdate.InstalledOn) {
            $DaysSinceUpdate = (New-TimeSpan -Start $LastUpdate.InstalledOn -End (Get-Date)).Days
            if ($DaysSinceUpdate -gt 30) {
                $Findings += [PSCustomObject]@{
                    Severity    = 'High'
                    ID          = 'SEC-007'
                    Title       = 'System Not Updated Recently'
                    Description = "Last Windows update was installed $DaysSinceUpdate days ago. The system may be missing critical security patches."
                    Remediation = 'Run Windows Update immediately to install the latest security patches.'
                    Category    = 'Patch Management'
                }
            }
        }

        # 8. Check for risky startup applications
        $RiskyStartupCount = 0
        try {
            if ($Global:StartupApps) {
                $RiskyStartupCount = ($Global:StartupApps | Where-Object { $_.RiskLevel -eq "High" }).Count
            }
        } catch {}
        
        if ($RiskyStartupCount -gt 0) {
            $Findings += [PSCustomObject]@{
                Severity    = 'High'
                ID          = 'SEC-008'
                Title       = 'Potentially Risky Startup Applications'
                Description = "Found $RiskyStartupCount startup applications marked as potentially risky. These could be malware or unwanted software."
                Remediation = 'Review the Startup Applications section and investigate/remove suspicious entries.'
                Category    = 'Application Security'
            }
        }

        # 9. Check for low-security score applications
        $LowScoreApps = 0
        try {
            if ($Global:InstalledApps) {
                $LowScoreApps = ($Global:InstalledApps | Where-Object { $_.SecurityScore -le 3 }).Count
            }
        } catch {}
        
        if ($LowScoreApps -gt 5) {
            $Findings += [PSCustomObject]@{
                Severity    = 'Medium'
                ID          = 'SEC-009'
                Title       = 'Multiple Low-Security Applications Installed'
                Description = "Found $LowScoreApps applications with low security scores (≤3/10). These may pose security risks."
                Remediation = 'Review installed applications in the Applications section and consider removing or updating risky software.'
                Category    = 'Application Security'
            }
        }

        # 10. Check for recent critical security events
        $CriticalEvents = 0
        try {
            if ($Global:SecurityEvents) {
                $CriticalEvents = ($Global:SecurityEvents | Where-Object { $_.Severity -eq "Critical" }).Count
            }
        } catch {}
        
        if ($CriticalEvents -gt 0) {
            $Findings += [PSCustomObject]@{
                Severity    = 'High'
                ID          = 'SEC-010'
                Title       = 'Recent Critical Security Events Detected'
                Description = "Found $CriticalEvents critical security events in the logs. These require immediate investigation."
                Remediation = 'Review the Security Events section and investigate the critical events listed.'
                Category    = 'Event Monitoring'
            }
        }

        # 11. Check for missing EDR solution
        if ($Global:EDRInfo) {
            $NoEDR = $Global:EDRInfo | Where-Object { $_.EDRName -match "No EDR Detected" }
            if ($NoEDR) {
                $Findings += [PSCustomObject]@{
                    Severity    = 'High'
                    ID          = 'SEC-011'
                    Title       = 'No EDR Solution Detected'
                    Description = 'No Endpoint Detection and Response (EDR) solution was found on this system. EDR provides advanced threat detection and response capabilities.'
                    Remediation = 'Deploy an EDR solution such as Sophos, CrowdStrike, Microsoft Defender for Endpoint, or similar.'
                    Category    = 'Endpoint Security'
                }
            } else {
                # Check if EDR is active
                $InactiveEDR = $Global:EDRInfo | Where-Object { $_.Status -notmatch "Active|Running" }
                if ($InactiveEDR) {
                    $Findings += [PSCustomObject]@{
                        Severity    = 'Medium'
                        ID          = 'SEC-012'
                        Title       = 'EDR Solution Not Active'
                        Description = "EDR solution '$($InactiveEDR.EDRName)' is installed but not active/running. This reduces threat detection capabilities."
                        Remediation = 'Start the EDR services and verify they are running properly.'
                        Category    = 'Endpoint Security'
                    }
                } else {
                    # EDR is active - add positive finding
                    $ActiveEDR = $Global:EDRInfo | Where-Object { $_.Status -match "Active|Running" } | Select-Object -First 1
                    if ($ActiveEDR) {
                        $Findings += [PSCustomObject]@{
                            Severity    = 'Low'
                            ID          = 'SEC-013'
                            Title       = 'EDR Solution Active'
                            Description = "EDR solution '$($ActiveEDR.EDRName)' is active and running. This provides enhanced threat detection and response capabilities."
                            Remediation = 'Regularly review EDR alerts and ensure it is kept up to date.'
                            Category    = 'Endpoint Security - Positive'
                        }
                    }
                }
            }
        }

        # 12. Check for missing backup solution
        if ($Global:BackupInfo) {
            $NoBackup = $Global:BackupInfo | Where-Object { $_.BackupName -match "No Backup Solution Detected" }
            if ($NoBackup) {
                $Findings += [PSCustomObject]@{
                    Severity    = 'High'
                    ID          = 'SEC-014'
                    Title       = 'No Backup Solution Detected - CRITICAL'
                    Description = 'No backup solution was found on this system. Without backups, data loss from ransomware, hardware failure, or user error is catastrophic.'
                    Remediation = 'Immediately implement a backup solution such as Acronis, Veeam, or Windows Server Backup. Follow 3-2-1 backup rule: 3 copies, 2 different media, 1 offsite.'
                    Category    = 'Data Protection'
                }
            } else {
                # Check if backup solution is active
                $InactiveBackup = $Global:BackupInfo | Where-Object { $_.Status -notmatch "Active|Running" }
                if ($InactiveBackup) {
                    $Findings += [PSCustomObject]@{
                        Severity    = 'High'
                        ID          = 'SEC-015'
                        Title       = 'Backup Solution Not Active'
                        Description = "Backup solution '$($InactiveBackup.BackupName)' is installed but not active/running. Backups may not be occurring."
                        Remediation = 'Start the backup services and verify backup jobs are running successfully. Test restore procedures regularly.'
                        Category    = 'Data Protection'
                    }
                } else {
                    # Backup is active - add positive finding
                    $ActiveBackup = $Global:BackupInfo | Where-Object { $_.Status -match "Active|Running" } | Select-Object -First 1
                    if ($ActiveBackup) {
                        $Findings += [PSCustomObject]@{
                            Severity    = 'Low'
                            ID          = 'SEC-016'
                            Title       = 'Backup Solution Active'
                            Description = "Backup solution '$($ActiveBackup.BackupName)' is active and running. Regular backups help protect against data loss."
                            Remediation = 'Regularly test backup restores and ensure backups are stored in a secure, offsite location.'
                            Category    = 'Data Protection - Positive'
                        }
                    }
                }
            }
        }

        # If no critical findings, add a positive note
        if ($Findings.Count -eq 0) {
            $Findings += [PSCustomObject]@{
                Severity    = 'Low'
                ID          = 'SEC-000'
                Title       = 'No Critical Security Issues Detected'
                Description = 'Basic security checks passed. However, a more in-depth manual review is still recommended.'
                Remediation = 'Continue regular security maintenance and monitoring.'
                Category    = 'General'
            }
        }

    } catch {
        $errorMsg = "Error generating security findings: $_"
        Log-Error -FunctionName "Get-SecurityFindings" -ErrorMessage $errorMsg
        
        # Add at least one finding if there's an error
        $Findings += [PSCustomObject]@{
            Severity    = 'Medium'
            ID          = 'SEC-ERR'
            Title       = 'Error in Security Analysis'
            Description = "An error occurred during security analysis: $_"
            Remediation = 'Check the Execution Errors section for details and rerun the audit.'
            Category    = 'System Error'
        }
    }

    try {
        return $Findings | Sort-Object Severity -Descending
    } catch {
        return $Findings  # Return unsorted if sorting fails
    }
}

# ===============================
# REPORT SECTION FUNCTIONS
# ===============================

function Add-ReportSection {
    <#
    .SYNOPSIS
        Adds a collapsible section to the HTML report.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$Title,
        [Parameter(Mandatory = $false)]
        [PSObject]$Data,
        [Parameter(Mandatory = $false)]
        [string]$Icon = "fas fa-info-circle",
        [Parameter(Mandatory = $false)]
        [ValidateSet('low', 'medium', 'high', 'info')]
        [string]$RiskLevel = 'info',
        [Parameter(Mandatory = $false)]
        [switch]$Open,
        [Parameter(Mandatory = $false)]
        [string]$Notes,
        [Parameter(Mandatory = $false)]
        [string]$TableId
    )

    $SectionId = ($Title -replace '[^a-zA-Z0-9]', '').ToLower()
    $OpenAttr = if ($Open) { ' open' } else { '' }
    $TableAttr = if ($TableId) { " id='$TableId'" } else { '' }

    $SectionHtml = @"
        <div class="card">
            <details id="$SectionId"$OpenAttr>
                <summary>
                    <i class="$Icon"></i> $Title
                    <span class='badge badge-$RiskLevel'>$RiskLevel</span>
                </summary>
                <div class="summary-content">
"@

    if ($Notes) {
        $SectionHtml += "<div class='remediation' style='margin-bottom: 15px;'><strong>Note:</strong> $Notes</div>"
    }

    # Handle different data types
    if ($null -eq $Data) {
        $SectionHtml += "<p>No data available for this section.</p>"
    } elseif ($Data -is [System.Collections.IEnumerable] -and $Data -isnot [string]) {
        if ($Data.Count -gt 0) {
            $FirstItem = $Data | Select-Object -First 1
            if ($FirstItem -is [PSObject] -and ($FirstItem.PSObject.Properties | Measure-Object).Count -gt 0) {
                $SectionHtml += "<table$TableAttr>"
                $SectionHtml += "<thead><tr>"
                
                $Properties = $FirstItem.PSObject.Properties | Where-Object { $_.MemberType -eq 'NoteProperty' } | Select-Object -ExpandProperty Name
                foreach ($Prop in $Properties) {
                    $SectionHtml += "<th>$Prop</th>"
                }
                $SectionHtml += "</tr></thead><tbody>"
                
                foreach ($Item in $Data) {
                    $SectionHtml += "<tr>"
                    foreach ($Prop in $Properties) {
                        $Value = $Item.$Prop
                        if ($null -eq $Value) { $Value = '' }
                        
                        # Apply special formatting for security scores
                        if ($Prop -eq "SecurityScore" -and $Value -match "^[0-9]+$") {
                            $ScoreClass = "score-$([math]::Floor($Value/2)*2)"
                            if ($ScoreClass -eq "score-12") { $ScoreClass = "score-10" }
                            $Value = "<span class='score-badge $ScoreClass'>$Value/10</span>"
                        }
                        
                        # Apply special formatting for risk levels
                        if ($Prop -eq "RiskLevel") {
                            $BadgeClass = "badge-$($Value.ToLower())"
                            $Value = "<span class='badge $BadgeClass'>$Value</span>"
                        }
                        
                        # Apply special formatting for assessments
                        if ($Prop -eq "Assessment") {
                            if ($Value -match "Potentially Risky|Suspicious") {
                                $Value = "<span style='color: var(--danger); font-weight: 600;'>$Value</span>"
                            } elseif ($Value -match "Likely Safe") {
                                $Value = "<span style='color: var(--success); font-weight: 600;'>$Value</span>"
                            }
                        }
                        
                        $SectionHtml += "<td>$Value</td>"
                    }
                    $SectionHtml += "</tr>"
                }
                
                $SectionHtml += "</tbody></table>"
            } else {
                $SectionHtml += "<ul>"
                foreach ($Item in $Data) {
                    $SectionHtml += "<li>$Item</li>"
                }
                $SectionHtml += "</ul>"
            }
        } else {
            $SectionHtml += "<p>No items found.</p>"
        }
    } elseif ($Data -is [PSObject] -and ($Data.PSObject.Properties | Measure-Object).Count -gt 0) {
        $SectionHtml += "<table>"
        $SectionHtml += "<tbody>"
        
        $Properties = $Data.PSObject.Properties | Where-Object { $_.MemberType -eq 'NoteProperty' }
        foreach ($Prop in $Properties) {
            $Value = $Prop.Value
            if ($null -eq $Value) { $Value = '' }
            $SectionHtml += "<tr><th>$($Prop.Name)</th><td>$Value</td></tr>"
        }
        
        $SectionHtml += "</tbody></table>"
    } else {
        $SectionHtml += "<p>$Data</p>"
    }

    $SectionHtml += @"
                </div>
            </details>
        </div>
"@

    return $SectionHtml
}

function Add-SecurityEventsSection {
    <#
    .SYNOPSIS
        Adds a formatted security events section to the report.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [array]$SecurityEvents
    )

    $CriticalCount = ($SecurityEvents | Where-Object { $_.Severity -eq "Critical" }).Count
    $WarningCount = ($SecurityEvents | Where-Object { $_.Severity -eq "Warning" }).Count
    $ErrorCount = ($SecurityEvents | Where-Object { $_.Severity -eq "Error" }).Count
    
    $RiskLevel = if ($CriticalCount -gt 0) { "high" } elseif ($ErrorCount -gt 0) { "medium" } else { "low" }
    
    $SectionHtml = @"
        <div class="card">
            <details>
                <summary>
                    <i class="fas fa-exclamation-circle"></i> Security Events Analysis
                    <span class='badge badge-$RiskLevel'>$RiskLevel</span>
                </summary>
                <div class="summary-content">
                    <p><strong>Event Summary:</strong> Total: $($SecurityEvents.Count) | Critical: $CriticalCount | Errors: $ErrorCount | Warnings: $WarningCount</p>
                    <p><em>Note: Showing events from the last 7 days. Run as Administrator for full event log access.</em></p>
                    
                    <div class="event-log">
"@

    if ($SecurityEvents.Count -eq 0) {
        $SectionHtml += "<p>No security events found or event logs inaccessible.</p>"
    } else {
        foreach ($Event in $SecurityEvents) {
            $SectionHtml += @"
                        <div class="event-item $($Event.Class)">
                            <div class="event-time">
                                <strong>$($Event.Time)</strong> | Source: $($Event.Source) | Event ID: $($Event.EventID)
                            </div>
                            <div class="event-source">$($Event.Severity): $($Event.Message)</div>
                        </div>
"@
        }
    }

    $SectionHtml += @"
                    </div>
                    <div class="remediation" style="margin-top: 15px;">
                        <strong>Recommended Actions:</strong>
                        <ul style="margin-top: 5px; margin-left: 20px;">
                            <li>Investigate Critical events immediately</li>
                            <li>Review failed login attempts (Event ID 4625)</li>
                            <li>Monitor account changes (Event IDs 4720-4726)</li>
                            <li>Check for unexpected process creations (Event ID 4688)</li>
                        </ul>
                    </div>
                </div>
            </details>
        </div>
"@

    return $SectionHtml
}

function Add-StatsSection {
    <#
    .SYNOPSIS
        Adds a statistics overview section to the report.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [PSObject]$SystemInfo,
        [Parameter(Mandatory = $true)]
        [array]$Admins,
        [Parameter(Mandatory = $true)]
        [array]$RDPUsers,
        [Parameter(Mandatory = $true)]
        [array]$Findings,
        [Parameter(Mandatory = $true)]
        [array]$LocalUsers,
        [Parameter(Mandatory = $true)]
        [array]$InstalledApps,
        [Parameter(Mandatory = $true)]
        [array]$StartupApps,
        [Parameter(Mandatory = $true)]
        [array]$SecurityEvents
    )

    $TotalAdmins = ($Admins | Where-Object { $_.Name -notmatch "not found|No members" }).Count
    $TotalRDPUsers = ($RDPUsers | Where-Object { $_.Name -notmatch "not found|No members" }).Count
    $EnabledUsers = ($LocalUsers | Where-Object { $_.Enabled -eq 'Yes' }).Count
    $CriticalFindings = ($Findings | Where-Object { $_.Severity -eq 'High' }).Count
    $LowScoreApps = ($InstalledApps | Where-Object { $_.SecurityScore -le 3 }).Count
    $RiskyStartups = ($StartupApps | Where-Object { $_.RiskLevel -eq 'High' }).Count
    $CriticalEvents = ($SecurityEvents | Where-Object { $_.Severity -eq 'Critical' }).Count
    
    # Calculate overall security score
    $AppScore = 5  # Default if no apps found
    if ($InstalledApps.Count -gt 0 -and $InstalledApps[0].PSObject.Properties.Name -contains 'SecurityScore') { 
        $AppScore = [math]::Round(($InstalledApps | Measure-Object -Property SecurityScore -Average).Average, 1) 
    }
    
    $OverallScore = [math]::Round((100 - ($CriticalFindings * 5 + $RiskyStartups * 3 + $CriticalEvents * 4)), 0)
    if ($OverallScore -lt 0) { $OverallScore = 0 }
    if ($OverallScore -gt 100) { $OverallScore = 100 }
    
    $ScoreColor = if ($OverallScore -ge 80) { "var(--success)" } elseif ($OverallScore -ge 60) { "var(--warning)" } else { "var(--danger)" }
    $ScoreWidth = "$OverallScore%"
    
    # Get last update date safely
    $LastUpdate = "Unknown"
    try {
        $LastHotFix = Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1 -ErrorAction SilentlyContinue
        if ($LastHotFix -and $LastHotFix.InstalledOn) {
            $LastUpdate = $LastHotFix.InstalledOn.ToString("yyyy-MM-dd")
        }
    } catch {
        $LastUpdate = "Unknown"
    }
    
    $StatsHtml = @"
        <div class="card">
            <details open>
                <summary>
                    <i class="fas fa-chart-bar"></i> Executive Summary & Statistics
                    <span class="badge badge-info">Overview</span>
                </summary>
                <div class="summary-content">
                    <p>This report provides a comprehensive security assessment of <strong>$($SystemInfo.Hostname)</strong> ($($SystemInfo.'OS Name')). The system is $(if ($IsDomainController) { 'a Domain Controller' } else { 'a member/server' }) in the <strong>$($SystemInfo.Domain)</strong> domain.</p>
                    
                    <div style="background: var(--light); padding: 20px; border-radius: 10px; margin: 20px 0;">
                        <h3 style="margin-top: 0; color: var(--primary);">Overall Security Score: $OverallScore/100</h3>
                        <div class="security-score-bar">
                            <div class="security-score-fill score-$(if ($OverallScore -ge 80) { 'green' } elseif ($OverallScore -ge 60) { 'yellow' } else { 'red' })" style="width: $ScoreWidth;"></div>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-top: 5px; font-size: 0.9rem; color: var(--gray);">
                            <span>Low Risk</span>
                            <span>Medium Risk</span>
                            <span>High Risk</span>
                        </div>
                    </div>
                    
                    <div class="stats-grid">
                        <div class="stat-card">
                            <i class="fas fa-users" style="font-size: 2rem; color: var(--secondary);"></i>
                            <div class="stat-value">$TotalAdmins</div>
                            <div class="stat-label">Administrators</div>
                        </div>
                        <div class="stat-card">
                            <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger);"></i>
                            <div class="stat-value">$CriticalFindings</div>
                            <div class="stat-label">Critical Findings</div>
                        </div>
                        <div class="stat-card">
                            <i class="fas fa-shield-alt" style="font-size: 2rem; color: var(--warning);"></i>
                            <div class="stat-value">$LowScoreApps</div>
                            <div class="stat-label">Low-Score Apps</div>
                        </div>
                        <div class="stat-card">
                            <i class="fas fa-play-circle" style="font-size: 2rem; color: var(--danger);"></i>
                            <div class="stat-value">$RiskyStartups</div>
                            <div class="stat-label">Risky Startups</div>
                        </div>
                    </div>
                    
                    <table style="margin-top: 30px;">
                        <tr>
                            <th>Assessment Item</th>
                            <th>Status</th>
                            <th>Details</th>
                        </tr>
                        <tr>
                            <td>System Uptime</td>
                            <td>$($SystemInfo.'System Uptime')</td>
                            <td>Time since last reboot</td>
                        </tr>
                        <tr>
                            <td>Application Security</td>
                            <td>$AppScore/10 Avg Score</td>
                            <td>$($InstalledApps.Count) applications analyzed</td>
                        </tr>
                        <tr>
                            <td>Startup Security</td>
                            <td>$(if ($RiskyStartups -gt 0) { '⚠️ Warning' } else { '✅ Good' })</td>
                            <td>$($StartupApps.Count) startup items checked</td>
                        </tr>
                        <tr>
                            <td>Event Log Security</td>
                            <td>$(if ($CriticalEvents -gt 0) { '🔴 Critical' } else { '✅ Clean' })</td>
                            <td>$($SecurityEvents.Count) events analyzed</td>
                        </tr>
                        <tr>
                            <td>Last Windows Update</td>
                            <td>$LastUpdate</td>
                            <td>Most recent patch installation</td>
                        </tr>
                        <tr>
                            <td>Total User Accounts</td>
                            <td>$($LocalUsers.Count)</td>
                            <td>$EnabledUsers enabled, $($LocalUsers.Count - $EnabledUsers) disabled</td>
                        </tr>
                        <tr>
                            <td>Network Interfaces</td>
                            <td>$(try { (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue | Measure-Object).Count } catch { 'N/A' })</td>
                            <td>Active IPv4 network interfaces</td>
                        </tr>
                    </table>
                    
                    <div style="margin-top: 25px; padding: 15px; background: rgba(59, 130, 246, 0.1); border-radius: 8px; border-left: 4px solid var(--info);">
                        <h4 style="margin-top: 0; color: var(--info);"><i class="fas fa-lightbulb"></i> Quick Assessment</h4>
                        <p>
                            $(if ($OverallScore -ge 80) {
                                "✅ <strong>Good Security Posture:</strong> System shows strong security configuration with minimal critical issues."
                            } elseif ($OverallScore -ge 60) {
                                "⚠️ <strong>Moderate Security Concerns:</strong> Several areas need attention. Review findings and implement remediations."
                            } else {
                                "🔴 <strong>Critical Security Issues:</strong> Immediate attention required. Multiple high-risk findings detected."
                            })
                        </p>
                        <p style="margin-top: 10px; font-size: 0.9rem;">
                            <strong>Priority Actions:</strong>
                            $(if ($CriticalFindings -gt 0) { "1. Address $CriticalFindings critical findings<br>" })
                            $(if ($RiskyStartups -gt 0) { "2. Investigate $RiskyStartups risky startup applications<br>" })
                            $(if ($CriticalEvents -gt 0) { "3. Review $CriticalEvents critical security events<br>" })
                            $(if ($LowScoreApps -gt 0) { "4. Evaluate $LowScoreApps low-security applications" })
                        </p>
                    </div>
                </div>
            </details>
        </div>
"@

    return $StatsHtml
}

# ===============================
# NEW: EDR AND BACKUP DETECTION FUNCTIONS
# ===============================

function Get-EDRStatus {
    <#
    .SYNOPSIS
        Detects and reports on EDR (Endpoint Detection and Response) software status.
        Currently detects Sophos with extensibility for other EDRs.
    #>
    Write-Host "  [i] Checking for EDR solutions..." -ForegroundColor Cyan
    
    $EDRInfo = @()
    
    # 1. Check for Sophos EDR
    try {
        # Method 1: Check for Sophos services
        $SophosServices = Get-Service -ErrorAction SilentlyContinue | Where-Object {
            $_.DisplayName -like "*Sophos*" -or $_.Name -like "*Sophos*"
        }
        
        if ($SophosServices) {
            $SophosServiceStatus = @()
            foreach ($service in $SophosServices) {
                $SophosServiceStatus += "$($service.DisplayName): $($service.Status)"
            }
            
            # Method 2: Check for Sophos in registry
            $SophosRegistryPaths = @(
                "HKLM:\SOFTWARE\Sophos",
                "HKLM:\SOFTWARE\WOW6432Node\Sophos",
                "HKLM:\SOFTWARE\Sophos\Endpoint Defense",
                "HKLM:\SOFTWARE\Sophos\Sophos Anti-Virus"
            )
            
            $SophosRegistryInfo = @()
            foreach ($regPath in $SophosRegistryPaths) {
                if (Test-Path $regPath) {
                    try {
                        $regItems = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
                        if ($regItems) {
                            $SophosRegistryInfo += "Found: $regPath"
                        }
                    } catch {
                        # Silently continue if registry access fails
                    }
                }
            }
            
            # Method 3: Check for Sophos processes
            $SophosProcesses = Get-Process -ErrorAction SilentlyContinue | Where-Object {
                $_.ProcessName -like "*Sophos*" -or $_.Path -like "*Sophos*"
            } | Select-Object -First 5
            
            $SophosProcessList = if ($SophosProcesses) {
                ($SophosProcesses | ForEach-Object { $_.ProcessName }) -join ", "
            } else {
                "No active Sophos processes detected"
            }
            
            # Determine overall Sophos status
            $RunningServices = $SophosServices | Where-Object { $_.Status -eq "Running" }
            $SophosStatus = if ($RunningServices.Count -gt 0) { "Active" } else { "Installed but not running" }
            
            $EDRInfo += [PSCustomObject]@{
                EDRName        = "Sophos Endpoint Protection"
                Status         = $SophosStatus
                DetectionMethod = "Multiple checks"
                Services       = $SophosServiceStatus -join "; "
                Processes      = $SophosProcessList
                RegistryPaths  = if ($SophosRegistryInfo.Count -gt 0) { $SophosRegistryInfo -join "; " } else { "None found" }
                LastChecked    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                Notes          = if ($SophosStatus -eq "Active") { "EDR is active and can block known malware" } else { "EDR is installed but may not be protecting the system" }
            }
            
            Write-Host "  [+] Sophos EDR detected: $SophosStatus" -ForegroundColor Green
        } else {
            # Check for other EDR solutions (extensible)
            $OtherEDRServices = Get-Service -ErrorAction SilentlyContinue | Where-Object {
                $_.DisplayName -like "*CrowdStrike*" -or 
                $_.DisplayName -like "*Carbon Black*" -or 
                $_.DisplayName -like "*SentinelOne*" -or
                $_.DisplayName -like "*Microsoft Defender*" -or
                $_.DisplayName -like "*McAfee*" -or
                $_.DisplayName -like "*Symantec*" -or
                $_.DisplayName -like "*Kaspersky*"
            }
            
            if ($OtherEDRServices) {
                foreach ($service in $OtherEDRServices | Select-Object -First 3) {
                    $EDRInfo += [PSCustomObject]@{
                        EDRName        = $service.DisplayName
                        Status         = $service.Status
                        DetectionMethod = "Service detection"
                        Services       = "$($service.DisplayName): $($service.Status)"
                        Processes      = "Check specific EDR console"
                        RegistryPaths  = "Not scanned"
                        LastChecked    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                        Notes          = "Third-party EDR detected. Check vendor console for detailed status."
                    }
                }
                Write-Host "  [+] Other EDR solution(s) detected" -ForegroundColor Green
            }
        }
    } catch {
        $errorMsg = "Error checking for EDR solutions: $_"
        Log-Error -FunctionName "Get-EDRStatus" -ErrorMessage $errorMsg
    }
    
    # If no EDR found, add a placeholder
    if ($EDRInfo.Count -eq 0) {
        $EDRInfo += [PSCustomObject]@{
            EDRName        = "No EDR Detected"
            Status         = "Not Found"
            DetectionMethod = "Service and registry scan"
            Services       = "None"
            Processes      = "None"
            RegistryPaths  = "None"
            LastChecked    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            Notes          = "Consider deploying an EDR solution for advanced threat protection"
        }
        Write-Host "  [-] No EDR solution detected" -ForegroundColor Yellow
    }
    
    return $EDRInfo
}

function Get-BackupSolutionStatus {
    <#
    .SYNOPSIS
        Detects and reports on backup solution status.
        Currently detects Acronis with extensibility for other backup solutions.
    #>
    Write-Host "  [i] Checking for backup solutions..." -ForegroundColor Cyan
    
    $BackupInfo = @()
    
    # 1. Check for Acronis Backup
    try {
        # Method 1: Check for Acronis services
        $AcronisServices = Get-Service -ErrorAction SilentlyContinue | Where-Object {
            $_.DisplayName -like "*Acronis*" -or $_.Name -like "*Acronis*"
        }
        
        if ($AcronisServices) {
            $AcronisServiceStatus = @()
            foreach ($service in $AcronisServices) {
                $AcronisServiceStatus += "$($service.DisplayName): $($service.Status)"
            }
            
            # Method 2: Check for Acronis in registry
            $AcronisRegistryPaths = @(
                "HKLM:\SOFTWARE\Acronis",
                "HKLM:\SOFTWARE\WOW6432Node\Acronis",
                "HKLM:\SOFTWARE\Acronis\BackupAndRecovery",
                "HKLM:\SOFTWARE\Acronis\TrueImage"
            )
            
            $AcronisRegistryInfo = @()
            foreach ($regPath in $AcronisRegistryPaths) {
                if (Test-Path $regPath) {
                    try {
                        $regItems = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
                        if ($regItems) {
                            $AcronisRegistryInfo += "Found: $regPath"
                        }
                    } catch {
                        # Silently continue if registry access fails
                    }
                }
            }
            
            # Method 3: Check for Acronis in installed applications
            $AcronisApps = @()
            $RegPaths = @(
                "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
            )
            
            foreach ($Path in $RegPaths) {
                if (Test-Path $Path) {
                    $Apps = Get-ItemProperty $Path -ErrorAction SilentlyContinue | Where-Object {
                        $null -ne $_.DisplayName -and $_.DisplayName -match "Acronis"
                    }
                    foreach ($App in $Apps) {
                        $AcronisApps += "$($App.DisplayName) v$($App.DisplayVersion)"
                    }
                }
            }
            
            # Method 4: Check for Acronis processes
            $AcronisProcesses = Get-Process -ErrorAction SilentlyContinue | Where-Object {
                $_.ProcessName -like "*Acronis*" -or $_.Path -like "*Acronis*"
            } | Select-Object -First 5
            
            $AcronisProcessList = if ($AcronisProcesses) {
                ($AcronisProcesses | ForEach-Object { $_.ProcessName }) -join ", "
            } else {
                "No active Acronis processes detected"
            }
            
            # Determine overall Acronis status
            $RunningServices = $AcronisServices | Where-Object { $_.Status -eq "Running" }
            $AcronisStatus = if ($RunningServices.Count -gt 0) { "Active" } else { "Installed but not running" }
            
            $BackupInfo += [PSCustomObject]@{
                BackupName     = "Acronis Backup"
                Status         = $AcronisStatus
                DetectionMethod = "Multiple checks"
                Services       = if ($AcronisServiceStatus.Count -gt 0) { $AcronisServiceStatus -join "; " } else { "None found" }
                InstalledApps  = if ($AcronisApps.Count -gt 0) { $AcronisApps -join "; " } else { "None found" }
                Processes      = $AcronisProcessList
                RegistryPaths  = if ($AcronisRegistryInfo.Count -gt 0) { $AcronisRegistryInfo -join "; " } else { "None found" }
                LastChecked    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                Notes          = if ($AcronisStatus -eq "Active") { "Backup solution is active and protecting data" } else { "Backup solution is installed but may not be running backups" }
            }
            
            Write-Host "  [+] Acronis Backup detected: $AcronisStatus" -ForegroundColor Green
        } else {
            # Check for other backup solutions (extensible)
            $OtherBackupServices = Get-Service -ErrorAction SilentlyContinue | Where-Object {
                $_.DisplayName -like "*Veeam*" -or 
                $_.DisplayName -like "*Backup*" -or 
                $_.DisplayName -like "*Veritas*" -or
                $_.DisplayName -like "*Commvault*" -or
                $_.DisplayName -like "*Windows Backup*" -or
                $_.DisplayName -like "*Backup Exec*"
            }
            
            if ($OtherBackupServices) {
                foreach ($service in $OtherBackupServices | Select-Object -First 3) {
                    $BackupInfo += [PSCustomObject]@{
                        BackupName     = $service.DisplayName
                        Status         = $service.Status
                        DetectionMethod = "Service detection"
                        Services       = "$($service.DisplayName): $($service.Status)"
                        InstalledApps  = "Check installed programs"
                        Processes      = "Check specific backup console"
                        RegistryPaths  = "Not scanned"
                        LastChecked    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                        Notes          = "Third-party backup solution detected. Check backup logs for status."
                    }
                }
                Write-Host "  [+] Other backup solution(s) detected" -ForegroundColor Green
            }
        }
    } catch {
        $errorMsg = "Error checking for backup solutions: $_"
        Log-Error -FunctionName "Get-BackupSolutionStatus" -ErrorMessage $errorMsg
    }
    
    # Check for Windows built-in backup features
    try {
        # Check for Windows Server Backup (if server)
        $WSBService = Get-Service -Name "wbengine" -ErrorAction SilentlyContinue
        if ($WSBService) {
            $BackupInfo += [PSCustomObject]@{
                BackupName     = "Windows Server Backup"
                Status         = $WSBService.Status
                DetectionMethod = "Service detection"
                Services       = "$($WSBService.DisplayName): $($WSBService.Status)"
                InstalledApps  = "Windows Server Backup feature"
                Processes      = "wbengine.exe"
                RegistryPaths  = "Windows component"
                LastChecked    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                Notes          = "Built-in Windows Server Backup detected"
            }
            Write-Host "  [+] Windows Server Backup detected" -ForegroundColor Green
        }
    } catch {
        # Silent fail for this check
    }
    
    # If no backup solution found, add a placeholder
    if ($BackupInfo.Count -eq 0) {
        $BackupInfo += [PSCustomObject]@{
            BackupName     = "No Backup Solution Detected"
            Status         = "Not Found"
            DetectionMethod = "Service and registry scan"
            Services       = "None"
            InstalledApps  = "None"
            Processes      = "None"
            RegistryPaths  = "None"
            LastChecked    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            Notes          = "CRITICAL: No backup solution detected. Implement a backup strategy immediately."
        }
        Write-Host "  [-] No backup solution detected - CRITICAL FINDING" -ForegroundColor Red
    }
    
    return $BackupInfo
}

# ===============================
# CUSTOM REPORT SECTION FOR EDR AND BACKUP
# ===============================

function Add-EDRSection {
    <#
    .SYNOPSIS
        Adds a formatted EDR status section to the report.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [array]$EDRInfo
    )
    
    # Determine risk level based on EDR status
    $ActiveEDR = $EDRInfo | Where-Object { $_.Status -match "Active|Running" }
    $NoEDR = $EDRInfo | Where-Object { $_.EDRName -match "No EDR Detected" }
    
    if ($NoEDR) {
        $RiskLevel = "high"
        $RiskText = "No EDR"
    } elseif (-not $ActiveEDR) {
        $RiskLevel = "medium"
        $RiskText = "Inactive"
    } else {
        $RiskLevel = "low"
        $RiskText = "Protected"
    }
    
    $SectionHtml = @"
        <div class="card">
            <details>
                <summary>
                    <i class="fas fa-shield-virus"></i> Endpoint Detection & Response (EDR) Status
                    <span class='badge badge-$RiskLevel'>$RiskText</span>
                </summary>
                <div class="summary-content">
                    <p><strong>Importance:</strong> EDR solutions provide advanced threat detection, investigation, and response capabilities beyond traditional antivirus.</p>
                    
                    <table>
                        <thead>
                            <tr>
                                <th>EDR Name</th>
                                <th>Status</th>
                                <th>Detection Method</th>
                                <th>Services</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
"@
    
    foreach ($EDR in $EDRInfo) {
        $StatusClass = if ($EDR.Status -match "Active|Running") { "status-active" } 
                      elseif ($EDR.Status -match "Not Found") { "status-critical" } 
                      else { "status-inactive" }
        
        $SectionHtml += @"
                            <tr>
                                <td><strong>$($EDR.EDRName)</strong></td>
                                <td><span class="$StatusClass">$($EDR.Status)</span></td>
                                <td>$($EDR.DetectionMethod)</td>
                                <td>$($EDR.Services)</td>
                                <td>$($EDR.Notes)</td>
                            </tr>
"@
    }
    
    $SectionHtml += @"
                        </tbody>
                    </table>
                    
                    <div class="remediation" style="margin-top: 15px;">
                        <strong>EDR Best Practices:</strong>
                        <ul style="margin-top: 5px; margin-left: 20px;">
                            <li>Ensure EDR is actively monitoring all endpoints</li>
                            <li>Regularly review EDR alerts and incidents</li>
                            <li>Keep EDR signatures and engine updated</li>
                            <li>Integrate EDR with SIEM for centralized monitoring</li>
                            <li>Test EDR detection capabilities regularly</li>
                        </ul>
                    </div>
                    
                    <div style="margin-top: 15px; padding: 12px; background: rgba(59, 130, 246, 0.1); border-radius: 8px; border-left: 4px solid var(--info);">
                        <strong><i class="fas fa-lightbulb"></i> Security Impact:</strong>
                        <p style="margin-top: 5px;">
                            $(if ($ActiveEDR) {
                                "✅ <strong>Enhanced Protection:</strong> Active EDR provides advanced threat detection, behavioral analysis, and incident response capabilities."
                            } elseif ($NoEDR) {
                                "🔴 <strong>High Risk:</strong> Without EDR, the system relies only on basic antivirus which may miss advanced threats like fileless malware and zero-day attacks."
                            } else {
                                "⚠️ <strong>Reduced Protection:</strong> EDR is installed but not active. Enable it to restore advanced threat protection."
                            })
                        </p>
                    </div>
                </div>
            </details>
        </div>
"@
    
    return $SectionHtml
}

function Add-BackupSection {
    <#
    .SYNOPSIS
        Adds a formatted Backup solution status section to the report.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [array]$BackupInfo
    )
    
    # Determine risk level based on backup status
    $ActiveBackup = $BackupInfo | Where-Object { $_.Status -match "Active|Running" }
    $NoBackup = $BackupInfo | Where-Object { $_.BackupName -match "No Backup Solution Detected" }
    
    if ($NoBackup) {
        $RiskLevel = "high"
        $RiskText = "CRITICAL"
    } elseif (-not $ActiveBackup) {
        $RiskLevel = "medium"
        $RiskText = "Inactive"
    } else {
        $RiskLevel = "low"
        $RiskText = "Protected"
    }
    
    $SectionHtml = @"
        <div class="card">
            <details>
                <summary>
                    <i class="fas fa-database"></i> Backup Solution Status
                    <span class='badge badge-$RiskLevel'>$RiskText</span>
                </summary>
                <div class="summary-content">
                    <p><strong>Importance:</strong> Regular backups are essential for disaster recovery, ransomware protection, and data integrity.</p>
                    
                    <table>
                        <thead>
                            <tr>
                                <th>Backup Solution</th>
                                <th>Status</th>
                                <th>Detection Method</th>
                                <th>Installed Components</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
"@
    
    foreach ($Backup in $BackupInfo) {
        $StatusClass = if ($Backup.Status -match "Active|Running") { "status-active" } 
                      elseif ($Backup.Status -match "Not Found") { "status-critical" } 
                      else { "status-inactive" }
        
        $SectionHtml += @"
                            <tr>
                                <td><strong>$($Backup.BackupName)</strong></td>
                                <td><span class="$StatusClass">$($Backup.Status)</span></td>
                                <td>$($Backup.DetectionMethod)</td>
                                <td>$($Backup.InstalledApps)</td>
                                <td>$($Backup.Notes)</td>
                            </tr>
"@
    }
    
    $SectionHtml += @"
                        </tbody>
                    </table>
                    
                    <div class="remediation" style="margin-top: 15px;">
                        <strong>Backup Best Practices (3-2-1 Rule):</strong>
                        <ul style="margin-top: 5px; margin-left: 20px;">
                            <li><strong>3 Copies:</strong> Keep at least 3 copies of your data</li>
                            <li><strong>2 Different Media:</strong> Store copies on at least 2 different types of media</li>
                            <li><strong>1 Offsite:</strong> Keep at least 1 copy offsite (cloud or physical)</li>
                            <li>Test restore procedures regularly (quarterly minimum)</li>
                            <li>Encrypt backups containing sensitive data</li>
                            <li>Monitor backup job success/failure alerts</li>
                        </ul>
                    </div>
                    
                    <div style="margin-top: 15px; padding: 12px; background: rgba(59, 130, 246, 0.1); border-radius: 8px; border-left: 4px solid var(--info);">
                        <strong><i class="fas fa-lightbulb"></i> Business Impact:</strong>
                        <p style="margin-top: 5px;">
                            $(if ($ActiveBackup) {
                                "✅ <strong>Data Protected:</strong> Active backup solution provides protection against data loss from ransomware, hardware failure, or accidental deletion."
                            } elseif ($NoBackup) {
                                "🔴 <strong>Extreme Risk:</strong> NO BACKUPS DETECTED! Data loss would be catastrophic. Implement a backup solution IMMEDIATELY."
                            } else {
                                "⚠️ <strong>Risk of Data Loss:</strong> Backup solution is installed but not active. Start backups immediately to protect data."
                            })
                        </p>
                    </div>
                    
                    <div style="margin-top: 15px; padding: 12px; background: rgba(245, 158, 11, 0.1); border-radius: 8px; border-left: 4px solid var(--warning);">
                        <strong><i class="fas fa-exclamation-triangle"></i> Ransomware Consideration:</strong>
                        <p style="margin-top: 5px;">Ensure backups are immutable or air-gapped to prevent ransomware from encrypting backup files. Test that you can restore from backups without the backup software itself.</p>
                    </div>
                </div>
            </details>
        </div>
"@
    
    return $SectionHtml
}

# ===============================
# HTML REPORT STYLING & HEADER (with error reporting section)
# ===============================
$HtmlHeader = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CloudTechtiq | Security Audit Report</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #0A2540;
            --secondary: #0055A4;
            --success: #10B981;
            --warning: #F59E0B;
            --danger: #DC2626;
            --info: #3B82F6;
            --light: #F5F7FA;
            --dark: #1F2937;
            --gray: #6B7280;
            --border: #E5E7EB;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', system-ui, sans-serif; }
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #333;
            line-height: 1.6;
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 1400px;
            margin: 30px auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid var(--border);
        }
        .header {
            background: linear-gradient(90deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
        }
        .header h1 {
            font-size: 2.8rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 5px;
        }
        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        .badge-low { background: var(--success); color: white; }
        .badge-medium { background: var(--warning); color: white; }
        .badge-high { background: var(--danger); color: white; }
        .badge-info { background: var(--info); color: white; }
        .score-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            min-width: 50px;
            text-align: center;
        }
        .score-10 { background: #10B981; color: white; }
        .score-8 { background: #34D399; color: white; }
        .score-6 { background: #F59E0B; color: white; }
        .score-4 { background: #F97316; color: white; }
        .score-2 { background: #DC2626; color: white; }
        .score-0 { background: #6B7280; color: white; }
        .controls {
            padding: 20px 40px;
            background: var(--light);
            border-bottom: 1px solid var(--border);
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: var(--secondary);
            color: white;
        }
        .btn-primary:hover { background: var(--primary); transform: translateY(-2px); }
        .btn-success {
            background: var(--success);
            color: white;
        }
        .btn-warning {
            background: var(--warning);
            color: white;
        }
        .content { padding: 30px 40px; }
        .card {
            background: white;
            border-radius: 16px;
            padding: 0;
            margin-bottom: 30px;
            border: 1px solid var(--border);
            overflow: hidden;
            transition: box-shadow 0.3s;
        }
        .card:hover { box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08); }
        details {
            border-bottom: 1px solid var(--border);
        }
        details:last-of-type { border-bottom: none; }
        summary {
            padding: 24px 30px;
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--primary);
            cursor: pointer;
            list-style: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background 0.2s;
        }
        summary::-webkit-details-marker { display: none; }
        summary:hover { background: rgba(10, 37, 64, 0.04); }
        summary i { margin-right: 15px; color: var(--secondary); }
        .summary-content {
            padding: 0 30px 30px 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th {
            background: var(--light);
            color: var(--dark);
            font-weight: 700;
            text-align: left;
            padding: 16px;
            border-bottom: 2px solid var(--border);
        }
        td {
            padding: 16px;
            border-bottom: 1px solid var(--border);
            vertical-align: top;
        }
        tr:hover { background: rgba(10, 37, 64, 0.02); }
        .finding-item {
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 10px;
            border-left: 6px solid;
            background: var(--light);
        }
        .finding-high { border-left-color: var(--danger); }
        .finding-medium { border-left-color: var(--warning); }
        .finding-low { border-left-color: var(--success); }
        .finding-title { font-weight: 700; font-size: 1.1rem; margin-bottom: 8px; display: flex; align-items: center; gap: 10px; }
        .finding-desc { color: var(--dark); margin-bottom: 10px; }
        .remediation { background: rgba(16, 185, 129, 0.1); padding: 15px; border-radius: 8px; margin-top: 10px; border-left: 4px solid var(--success); }
        .error-section {
            background: rgba(220, 38, 38, 0.1);
            border-left: 6px solid var(--danger);
            padding: 20px;
            margin: 20px 0;
            border-radius: 10px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            text-align: center;
            border: 1px solid var(--border);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
        }
        .stat-value {
            font-size: 3rem;
            font-weight: 800;
            color: var(--secondary);
            line-height: 1;
            margin: 15px 0;
        }
        .stat-label {
            font-size: 1rem;
            color: var(--gray);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .footer {
            text-align: center;
            padding: 30px;
            color: var(--gray);
            border-top: 1px solid var(--border);
            background: var(--light);
            font-size: 0.95rem;
        }
        .event-log {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 10px;
            margin-top: 15px;
        }
        .event-item {
            padding: 12px;
            margin-bottom: 8px;
            border-left: 4px solid;
            background: var(--light);
            border-radius: 6px;
        }
        .event-critical { border-left-color: var(--danger); }
        .event-error { border-left-color: #EF4444; }
        .event-warning { border-left-color: var(--warning); }
        .event-info { border-left-color: var(--info); }
        .event-success { border-left-color: var(--success); }
        .event-time { font-size: 0.85rem; color: var(--gray); margin-bottom: 4px; }
        .event-source { font-weight: 600; color: var(--dark); }
        .event-message { margin-top: 5px; font-size: 0.95rem; }
        @media (max-width: 768px) {
            .container { margin: 10px; border-radius: 15px; }
            .header { padding: 30px 20px; }
            .header h1 { font-size: 2rem; flex-direction: column; gap: 10px; }
            .controls, .content { padding: 20px; }
            .stats-grid { grid-template-columns: 1fr; }
            summary { padding: 20px; font-size: 1.1rem; }
            .summary-content { padding: 0 20px 20px 20px; }
        }
        .pulse { animation: pulse 2s infinite; }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .security-score-bar {
            height: 10px;
            background: #E5E7EB;
            border-radius: 5px;
            margin: 10px 0;
            overflow: hidden;
        }
        .security-score-fill {
            height: 100%;
            border-radius: 5px;
            transition: width 0.5s ease;
        }
        .score-green { background: var(--success); }
        .score-yellow { background: var(--warning); }
        .score-red { background: var(--danger); }
        .status-active { color: var(--success); font-weight: 600; }
        .status-inactive { color: var(--warning); font-weight: 600; }
        .status-critical { color: var(--danger); font-weight: 600; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-shield-alt"></i> Security Audit Report</h1>
            <p>Comprehensive analysis of system configuration and security posture</p>
            <p>Generated: <script>document.write(new Date().toLocaleString());</script></p>
            <p>Target System: <span id="targetSystem"></span></p>
        </div>
        <div class="controls">
            <button class="btn btn-primary" onclick="toggleAll(true)">
                <i class="fas fa-expand"></i> Expand All
            </button>
            <button class="btn btn-success" onclick="toggleAll(false)">
                <i class="fas fa-compress"></i> Collapse All
            </button>
            <button class="btn btn-warning" onclick="window.print()">
                <i class="fas fa-print"></i> Print Report
            </button>
        </div>
        <div class="content">
            <!-- CONTENT WILL BE INJECTED HERE BY POWERSHELL -->
            <!-- ERROR SECTION WILL BE INJECTED HERE IF ERRORS OCCURRED -->
        </div>
        <div class="footer">
            <p><i class="fas fa-lock"></i> <strong>CloudTechtiq Pvt. Ltd.</strong> | Confidential Security Audit</p>
            <p>© <script>document.write(new Date().getFullYear());</script> | This report is generated automatically. Findings should be reviewed by a security professional.</p>
        </div>
    </div>

    <script>
        function toggleAll(state) {
            document.querySelectorAll('details').forEach(detail => {
                detail.open = state;
            });
        }
        
        function highlightRows(searchTerm, className) {
            const rows = document.querySelectorAll('tr');
            rows.forEach(row => {
                if (row.textContent.toLowerCase().includes(searchTerm.toLowerCase())) {
                    row.classList.add(className);
                }
            });
        }
        
        function filterTable(tableId, searchId) {
            const input = document.getElementById(searchId);
            const filter = input.value.toUpperCase();
            const table = document.getElementById(tableId);
            const tr = table.getElementsByTagName("tr");
            
            for (let i = 1; i < tr.length; i++) {
                const td = tr[i].getElementsByTagName("td");
                let showRow = false;
                
                for (let j = 0; j < td.length; j++) {
                    if (td[j]) {
                        const txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            showRow = true;
                            break;
                        }
                    }
                }
                
                tr[i].style.display = showRow ? "" : "none";
            }
        }
        
        window.addEventListener('load', function() {
            setTimeout(() => toggleAll(false), 100);
        });
    </script>
</body>
</html>
"@

# ===============================
# MAIN EXECUTION WITH ENHANCED ERROR HANDLING
# ===============================

Write-Host "`n"
Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   CloudTechtiq Enhanced Security Auditor v4.2                    ║" -ForegroundColor Cyan
Write-Host "║   Now with EDR & Backup Solution Detection                       ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host "`n"

Write-Host "[i] Starting comprehensive security audit..." -ForegroundColor Yellow
Write-Host "[-] Script will continue even if some components fail." -ForegroundColor Gray

# Initialize global variables with defaults
$Global:InstalledApps = @()
$Global:StartupApps = @()
$Global:SecurityEvents = @()
$Global:EDRInfo = @()
$Global:BackupInfo = @()

# Collect all data with error handling - NOW WITH 12 STEPS
$dataCollectionSteps = @(
    @{Name = "system information"; ScriptBlock = { Get-SystemInformation }; Var = "SystemInfo" }
    @{Name = "disk usage"; ScriptBlock = { Get-DiskInformation }; Var = "DiskInfo" }
    @{Name = "network configuration"; ScriptBlock = { Get-NetworkInformation }; Var = "NetworkInfo" }
    @{Name = "local user accounts"; ScriptBlock = { Get-LocalUserAccounts }; Var = "LocalUsers" }
    @{Name = "Administrators group members"; ScriptBlock = { Get-EnhancedGroupMembers -GroupName "Administrators" }; Var = "Admins" }
    @{Name = "Remote Desktop Users group members"; ScriptBlock = { Get-EnhancedGroupMembers -GroupName "Remote Desktop Users" }; Var = "RDPUsers" }
    @{Name = "security configuration"; ScriptBlock = { Get-SecurityConfiguration }; Var = "SecurityConfig" }
    @{Name = "installed applications"; ScriptBlock = { Get-InstalledApplications }; Var = "InstalledApps" }
    @{Name = "startup applications"; ScriptBlock = { Get-StartupApplications }; Var = "StartupApps" }
    @{Name = "security events"; ScriptBlock = { Get-SecurityEvents }; Var = "SecurityEvents" }
    @{Name = "EDR solution status"; ScriptBlock = { Get-EDRStatus }; Var = "EDRInfo" }
    @{Name = "backup solution status"; ScriptBlock = { Get-BackupSolutionStatus }; Var = "BackupInfo" }
)

$stepCount = 1
foreach ($step in $dataCollectionSteps) {
    Write-Host "[$stepCount/$($dataCollectionSteps.Count)] Collecting $($step.Name)..." -ForegroundColor Green
    try {
        $result = & $step.ScriptBlock
        Set-Variable -Name $step.Var -Value $result -Scope Script
        if ($step.Var -eq "InstalledApps") { $Global:InstalledApps = $result }
        if ($step.Var -eq "StartupApps") { $Global:StartupApps = $result }
        if ($step.Var -eq "SecurityEvents") { $Global:SecurityEvents = $result }
        if ($step.Var -eq "EDRInfo") { $Global:EDRInfo = $result }
        if ($step.Var -eq "BackupInfo") { $Global:BackupInfo = $result }
    } catch {
        $errorMsg = "Error collecting $($step.Name): $_"
        Log-Error -FunctionName "Main-DataCollection" -ErrorMessage $errorMsg
        # Set default values
        switch ($step.Var) {
            "SystemInfo" { $SystemInfo = [PSCustomObject]@{ Hostname = $env:COMPUTERNAME; 'OS Name' = "Unknown" } }
            "DiskInfo" { $DiskInfo = @() }
            "NetworkInfo" { $NetworkInfo = @() }
            "LocalUsers" { $LocalUsers = @() }
            "Admins" { $Admins = @() }
            "RDPUsers" { $RDPUsers = @() }
            "SecurityConfig" { $SecurityConfig = [PSCustomObject]@{} }
            "InstalledApps" { $Global:InstalledApps = @() }
            "StartupApps" { $Global:StartupApps = @() }
            "SecurityEvents" { $Global:SecurityEvents = @() }
            "EDRInfo" { $Global:EDRInfo = @(
                [PSCustomObject]@{
                    EDRName = "Error retrieving EDR info"
                    Status = "Error"
                    DetectionMethod = "Error"
                    Services = "Error"
                    Processes = "Error"
                    RegistryPaths = "Error"
                    LastChecked = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                    Notes = "Could not retrieve EDR information due to an error"
                }
            )}
            "BackupInfo" { $Global:BackupInfo = @(
                [PSCustomObject]@{
                    BackupName = "Error retrieving backup info"
                    Status = "Error"
                    DetectionMethod = "Error"
                    Services = "Error"
                    InstalledApps = "Error"
                    Processes = "Error"
                    RegistryPaths = "Error"
                    LastChecked = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                    Notes = "Could not retrieve backup information due to an error"
                }
            )}
        }
    }
    $stepCount++
}

Write-Host "`n[i] Analyzing collected data for security findings..." -ForegroundColor Yellow
try {
    $SecurityFindings = Get-SecurityFindings
} catch {
    $errorMsg = "Error generating security findings: $_"
    Log-Error -FunctionName "Main-Findings" -ErrorMessage $errorMsg
    $SecurityFindings = @(
        [PSCustomObject]@{
            Severity    = 'High'
            ID          = 'SEC-ERR'
            Title       = 'Error in Security Analysis'
            Description = "Could not generate security findings due to an error."
            Remediation = 'Check system permissions and try running as Administrator.'
            Category    = 'System Error'
        }
    )
}

Write-Host "`n[i] Generating HTML report..." -ForegroundColor Yellow

# Build the report content with error section if needed
$ReportContent = ""

# Add error section if there were any errors during execution
if ($Script:ExecutionErrors.Count -gt 0) {
    $errorSection = @"
        <div class="card">
            <details open>
                <summary>
                    <i class="fas fa-exclamation-triangle"></i> Execution Errors & Warnings
                    <span class='badge badge-high'>Errors: $($Script:ExecutionErrors.Count)</span>
                </summary>
                <div class="summary-content">
                    <div class="error-section">
                        <p><strong>Note:</strong> The following errors occurred during script execution. The report was still generated, but some data may be incomplete.</p>
                        <table>
                            <thead>
                                <tr>
                                    <th>Timestamp</th>
                                    <th>Function</th>
                                    <th>Error Type</th>
                                    <th>Message</th>
                                </tr>
                            </thead>
                            <tbody>
"@
    
    # Fix: Use a different variable name to avoid conflict with PowerShell's $error variable
    foreach ($err in $Script:ExecutionErrors) {
        $errorSection += @"
                                <tr>
                                    <td>$($err.Timestamp)</td>
                                    <td>$($err.Function)</td>
                                    <td><span class='badge badge-$(if ($err.Type -eq 'Error') { 'high' } else { 'medium' })'>$($err.Type)</span></td>
                                    <td>$($err.Message)</td>
                                </tr>
"@
    }
    
    $errorSection += @"
                            </tbody>
                        </table>
                        <div class="remediation" style="margin-top: 15px;">
                            <strong>Recommended Actions:</strong>
                            <ul style="margin-top: 5px; margin-left: 20px;">
                                <li>Run the script as Administrator to access all system information</li>
                                <li>Check PowerShell execution policy: `Get-ExecutionPolicy`</li>
                                <li>Ensure you have appropriate permissions on the system</li>
                                <li>Some errors may be expected on locked-down systems</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </details>
        </div>
"@
    $ReportContent += $errorSection
}

# Add stats/executive summary first
try {
    $statsSection = Add-StatsSection -SystemInfo $SystemInfo -Admins $Admins -RDPUsers $RDPUsers -Findings $SecurityFindings -LocalUsers $LocalUsers -InstalledApps $Global:InstalledApps -StartupApps $Global:StartupApps -SecurityEvents $Global:SecurityEvents
    $ReportContent += $statsSection
} catch {
    $errorMsg = "Error generating stats section: $_"
    Log-Error -FunctionName "Main-StatsSection" -ErrorMessage $errorMsg
    $ReportContent += "<div class='error-section'><p>Error generating executive summary section.</p></div>"
}

# Add security findings
try {
    $findingsSection = Add-ReportSection -Title "Security Findings & Recommendations" -Data $SecurityFindings -Icon "fas fa-exclamation-triangle" -RiskLevel "high" -Open
    $ReportContent += $findingsSection
} catch {
    $errorMsg = "Error generating findings section: $_"
    Log-Error -FunctionName "Main-FindingsSection" -ErrorMessage $errorMsg
}

# Add EDR section
try {
    $edrSection = Add-EDRSection -EDRInfo $Global:EDRInfo
    $ReportContent += $edrSection
} catch {
    $errorMsg = "Error generating EDR section: $_"
    Log-Error -FunctionName "Main-EDRSection" -ErrorMessage $errorMsg
    $ReportContent += "<div class='card'><div class='error-section'><p>Error generating EDR Status section.</p></div></div>"
}

# Add Backup section
try {
    $backupSection = Add-BackupSection -BackupInfo $Global:BackupInfo
    $ReportContent += $backupSection
} catch {
    $errorMsg = "Error generating Backup section: $_"
    Log-Error -FunctionName "Main-BackupSection" -ErrorMessage $errorMsg
    $ReportContent += "<div class='card'><div class='error-section'><p>Error generating Backup Solution Status section.</p></div></div>"
}

# Try to add all other sections with individual error handling
$sectionDefinitions = @(
    @{Title = "Installed Applications Security Analysis"; Data = $Global:InstalledApps; Icon = "fas fa-box"; RiskLevel = "medium"; Open = $true; Notes = "Security score: 10=Excellent, 5=Average, 1=Poor. Review low-score applications."; TableId = "applicationsTable"}
    @{Title = "Startup Applications Review"; Data = $Global:StartupApps; Icon = "fas fa-play"; RiskLevel = "medium"; Notes = "Review 'Potentially Risky' startup items. 'Likely Safe' items are from known trusted vendors."; TableId = "startupTable"}
    @{Title = "System Information"; Data = $SystemInfo; Icon = "fas fa-desktop"; RiskLevel = "low"}
    @{Title = "Disk Information"; Data = $DiskInfo; Icon = "fas fa-hdd"; RiskLevel = "medium"; Notes = "Drives with less than 10% free space may cause system instability."}
    @{Title = "Network Configuration"; Data = $NetworkInfo; Icon = "fas fa-network-wired"; RiskLevel = "medium"}
    @{Title = "Local User Accounts"; Data = $LocalUsers; Icon = "fas fa-user"; RiskLevel = "medium"; Notes = "Check for disabled accounts and accounts with password never expires set."}
    @{Title = "Administrators Group Members"; Data = $Admins; Icon = "fas fa-user-shield"; RiskLevel = "high"; Open = $true; Notes = "All users and groups with administrative privileges."}
    @{Title = "Remote Desktop Users"; Data = $RDPUsers; Icon = "fas fa-desktop"; RiskLevel = "medium"; Notes = "Users and groups allowed to connect via Remote Desktop. Review for least privilege."}
)

foreach ($section in $sectionDefinitions) {
    try {
        $sectionHtml = Add-ReportSection @section
        $ReportContent += $sectionHtml
    } catch {
        $errorMsg = "Error generating section '$($section.Title)': $_"
        Log-Error -FunctionName "Main-Section-$($section.Title)" -ErrorMessage $errorMsg
        $ReportContent += "<div class='card'><div class='error-section'><p>Error generating section: $($section.Title)</p></div></div>"
    }
}

# Add security events section
try {
    $eventsSection = Add-SecurityEventsSection -SecurityEvents $Global:SecurityEvents
    $ReportContent += $eventsSection
} catch {
    $errorMsg = "Error generating security events section: $_"
    Log-Error -FunctionName "Main-SecurityEventsSection" -ErrorMessage $errorMsg
}

# Try to add security configuration sections
if ($SecurityConfig) {
    $securitySections = @(
        @{Title = "Firewall Configuration"; Data = $SecurityConfig.Firewall; Icon = "fas fa-fire"; RiskLevel = "high"}
        @{Title = "Windows Defender Status"; Data = $SecurityConfig.Defender; Icon = "fas fa-shield-alt"; RiskLevel = "high"}
        @{Title = "SMB Protocol Configuration"; Data = $SecurityConfig.SMB; Icon = "fas fa-exchange-alt"; RiskLevel = "medium"; Notes = "SMBv1 should be disabled due to security vulnerabilities."}
        @{Title = "User Account Control (UAC)"; Data = $SecurityConfig.UAC; Icon = "fas fa-user-lock"; RiskLevel = "high"}
    )
    
    foreach ($section in $securitySections) {
        try {
            if ($section.Data) {
                $sectionHtml = Add-ReportSection @section
                $ReportContent += $sectionHtml
            }
        } catch {
            $errorMsg = "Error generating security config section '$($section.Title)': $_"
            Log-Error -FunctionName "Main-SecurityConfig-$($section.Title)" -ErrorMessage $errorMsg
        }
    }
}

# Add installed updates
try {
    $Updates = Get-InstalledUpdates
    $updatesSection = Add-ReportSection -Title "Recent Windows Updates" -Data $Updates -Icon "fas fa-sync-alt" -RiskLevel "low"
    $ReportContent += $updatesSection
} catch {
    $errorMsg = "Error generating updates section: $_"
    Log-Error -FunctionName "Main-UpdatesSection" -ErrorMessage $errorMsg
}

# If it's a Domain Controller, add AD-specific checks
if ($IsDomainController) {
    Write-Host "[+] Domain Controller detected - adding AD-specific checks..." -ForegroundColor Cyan
    
    try {
        $DCFindings = @(
            [PSCustomObject]@{
                Severity    = 'Medium'
                ID          = 'DC-001'
                Title       = 'Domain Controller Detected'
                Description = 'This system is a Domain Controller. Additional domain-level security review is recommended.'
                Remediation = 'Perform comprehensive AD security audit including GPOs, account policies, and privileged groups.'
                Category    = 'Domain Security'
            }
        )
        
        $DCSection = Add-ReportSection -Title "Domain Controller Information" -Data $DCFindings -Icon "fas fa-server" -RiskLevel "high" -Open
        $ReportContent += $DCSection
    } catch {
        $errorMsg = "Error generating DC section: $_"
        Log-Error -FunctionName "Main-DCSection" -ErrorMessage $errorMsg
    }
}

# Combine header, content, and close HTML
try {
    $FullHtml = $HtmlHeader -replace '<!-- CONTENT WILL BE INJECTED HERE BY POWERSHELL -->', $ReportContent
    $FullHtml = $FullHtml -replace '<span id="targetSystem"></span>', "$($env:COMPUTERNAME) ($(if($SystemInfo.'OS Name') { $SystemInfo.'OS Name' } else { 'Windows' }))"
    
    # Add search functionality for tables
    $SearchScript = @"
<script>
    // Add search boxes to application and startup tables
    document.addEventListener('DOMContentLoaded', function() {
        const appsTable = document.querySelector('table[id="applicationsTable"]');
        const startupTable = document.querySelector('table[id="startupTable"]');
        
        if (appsTable) {
            const appsSearch = document.createElement('div');
            appsSearch.innerHTML = '<input type="text" id="searchApps" placeholder="Search applications..." style="padding: 8px; width: 100%; margin-bottom: 10px; border: 1px solid var(--border); border-radius: 5px;">';
            appsTable.parentNode.insertBefore(appsSearch, appsTable);
            
            document.getElementById('searchApps').addEventListener('keyup', function() {
                filterTable('applicationsTable', 'searchApps');
            });
        }
        
        if (startupTable) {
            const startupSearch = document.createElement('div');
            startupSearch.innerHTML = '<input type="text" id="searchStartup" placeholder="Search startup items..." style="padding: 8px; width: 100%; margin-bottom: 10px; border: 1px solid var(--border); border-radius: 5px;">';
            startupTable.parentNode.insertBefore(startupSearch, startupTable);
            
            document.getElementById('searchStartup').addEventListener('keyup', function() {
                filterTable('startupTable', 'searchStartup');
            });
        }
    });
</script>
"@

    $FullHtml = $FullHtml -replace '</body>', "$SearchScript</body>"
    
    # Save the report
    $FullHtml | Out-File -FilePath $ReportPath -Encoding UTF8 -ErrorAction Stop
    
    Write-Host "`n" + ("="*70) -ForegroundColor Green
    Write-Host "✅ SECURITY AUDIT COMPLETED (WITH ERROR RECOVERY)!" -ForegroundColor Green
    Write-Host ("="*70) -ForegroundColor Green
    
    if ($Script:ExecutionErrors.Count -gt 0) {
        Write-Host "⚠️  Note: $($Script:ExecutionErrors.Count) errors occurred during execution." -ForegroundColor Yellow
        Write-Host "   Check the 'Execution Errors & Warnings' section in the report." -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "`n" + ("="*70) -ForegroundColor Red
    Write-Host "❌ CRITICAL ERROR: Could not generate HTML report!" -ForegroundColor Red
    Write-Host ("="*70) -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    
    # Try to create a simple error report
    try {
        $ErrorReport = @"
<html>
<head><title>CloudTechtiq - Audit Error</title></head>
<body style="font-family: Arial, sans-serif; padding: 20px;">
    <h1 style="color: #d00;">❌ Security Audit Failed</h1>
    <p>An error occurred while generating the security audit report.</p>
    <div style="background: #fcc; padding: 15px; border-left: 5px solid #d00; margin: 20px 0;">
        <h3>Error Details:</h3>
        <p><strong>Message:</strong> $_</p>
        <p><strong>Time:</strong> $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
        <p><strong>Computer:</strong> $env:COMPUTERNAME</p>
    </div>
    <h3>Troubleshooting Steps:</h3>
    <ol>
        <li>Run PowerShell as Administrator</li>
        <li>Check disk space on your Desktop</li>
        <li>Verify PowerShell execution policy: <code>Get-ExecutionPolicy</code></li>
        <li>Try running from a different location</li>
    </ol>
    <p>Contact support if the issue persists.</p>
</body>
</html>
"@
        $ErrorReportPath = "$env:USERPROFILE\Desktop\CloudTechtiq_Audit_ERROR_$Date.html"
        $ErrorReport | Out-File -FilePath $ErrorReportPath -Encoding UTF8
        Write-Host "⚠️  Error report saved to: $ErrorReportPath" -ForegroundColor Yellow
    } catch {
        Write-Host "❌ Could not even create error report!" -ForegroundColor Red
    }
    
    exit 1
}

Write-Host "`n📋 REPORT SUMMARY:" -ForegroundColor White
Write-Host "   - System: $(if($SystemInfo.Hostname) { $SystemInfo.Hostname } else { $env:COMPUTERNAME })" -ForegroundColor White
Write-Host "   - Applications: $(if($Global:InstalledApps) { $Global:InstalledApps.Count } else { 0 }) analyzed" -ForegroundColor White
Write-Host "   - Startup Items: $(if($Global:StartupApps) { $Global:StartupApps.Count } else { 0 }) checked" -ForegroundColor White
Write-Host "   - Security Events: $(if($Global:SecurityEvents) { $Global:SecurityEvents.Count } else { 0 }) reviewed" -ForegroundColor White
Write-Host "   - EDR Status: $(if($Global:EDRInfo -and $Global:EDRInfo[0].EDRName -notmatch 'Error|No EDR') { 'Detected' } else { 'Not detected' })" -ForegroundColor White
Write-Host "   - Backup Status: $(if($Global:BackupInfo -and $Global:BackupInfo[0].BackupName -notmatch 'Error|No Backup') { 'Detected' } else { 'Not detected' })" -ForegroundColor White
Write-Host "   - Total Findings: $(if($SecurityFindings) { $SecurityFindings.Count } else { 0 })" -ForegroundColor White
Write-Host "`n📄 Report saved to: $ReportPath" -ForegroundColor White

# Check for critical issues
if ($Global:BackupInfo -and $Global:BackupInfo[0].BackupName -match "No Backup Solution Detected") {
    Write-Host "`n🔴 CRITICAL ISSUE: No backup solution detected!" -ForegroundColor Red
    Write-Host "   This is a severe risk. Implement a backup solution immediately." -ForegroundColor Red
}

if ($Global:EDRInfo -and $Global:EDRInfo[0].EDRName -match "No EDR Detected") {
    Write-Host "`n⚠️  WARNING: No EDR solution detected" -ForegroundColor Yellow
    Write-Host "   Consider deploying an EDR for advanced threat protection." -ForegroundColor Yellow
}

Write-Host "`n🚀 NEXT STEPS:" -ForegroundColor White
Write-Host "   1. Open the HTML report for detailed analysis" -ForegroundColor White
Write-Host "   2. Review the 'Execution Errors' section if present" -ForegroundColor White
Write-Host "   3. Address any missing EDR or Backup solutions immediately" -ForegroundColor White
Write-Host "   4. Implement all recommended remediations" -ForegroundColor White

# Optional: Open the report automatically
try {
    $OpenReport = Read-Host "`nOpen the report now? (Y/N)"
    if ($OpenReport -eq 'Y' -or $OpenReport -eq 'y') {
        Start-Process $ReportPath -ErrorAction SilentlyContinue
    }
} catch {
    Write-Host "  [!] Could not open report automatically" -ForegroundColor Yellow
}

Write-Host "`n[i] Audit script completed. Thank you for using CloudTechtiq Security Auditor v4.2!" -ForegroundColor Cyan
Write-Host "[i] Script executed with $($Script:ExecutionErrors.Count) errors/warnings." -ForegroundColor $(if ($Script:ExecutionErrors.Count -gt 0) { "Yellow" } else { "Green" })
```
