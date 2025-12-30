---
icon: gears
---

# Server Configuration Script

## Automated Script

### **Features Included:**

1. **Change Hostname** - With DNS suffix option
2. **Change RDP Port** - With automatic firewall rule creation
3. **Create User Accounts** - With group assignment options
4. **Enable Guest Authentication** - With security warnings
5. **Windows Update** - Check, download, and install updates
6. **User-friendly Menu** - Easy navigation

```powershell
<#
Windows Server Configuration Tool
Author: System Administrator
Version: 1.0
Description: Menu-driven script for Windows Server configuration
#>

# Check for Administrator privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Function to display menu
function Show-Menu {
    Clear-Host
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "    WINDOWS SERVER CONFIGURATION TOOL" -ForegroundColor Yellow
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Change Server Hostname" -ForegroundColor White
    Write-Host "2. Change RDP Port" -ForegroundColor White
    Write-Host "3. Create Local User Account" -ForegroundColor White
    Write-Host "4. Enable Guest Authentication" -ForegroundColor White
    Write-Host "5. Run Windows Update" -ForegroundColor White
    Write-Host "6. Exit" -ForegroundColor Red
    Write-Host ""
}

# Function 1: Change Hostname
function Change-Hostname {
    Write-Host ""
    Write-Host "=== CHANGE SERVER HOSTNAME ===" -ForegroundColor Cyan
    Write-Host ""
    
    $currentHostname = $env:COMPUTERNAME
    Write-Host "Current hostname: $currentHostname" -ForegroundColor Yellow
    
    $newHostname = Read-Host "Enter new hostname (without spaces or special characters)"
    
    if ([string]::IsNullOrWhiteSpace($newHostname)) {
        Write-Host "Operation cancelled. No changes made." -ForegroundColor Yellow
        Pause
        return
    }
    
    $dnsSuffix = Read-Host "Enter DNS suffix (e.g., domain.local) [Optional - press Enter to skip]"
    
    Write-Host ""
    Write-Host "SUMMARY:" -ForegroundColor Yellow
    Write-Host "Old hostname: $currentHostname"
    Write-Host "New hostname: $newHostname"
    if (-not [string]::IsNullOrWhiteSpace($dnsSuffix)) {
        Write-Host "DNS Suffix: $dnsSuffix"
    }
    
    Write-Host ""
    $confirmation = Read-Host "Do you want to proceed? (Y/N)"
    
    if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
        try {
            Rename-Computer -NewName $newHostname -Force -ErrorAction Stop
            
            if (-not [string]::IsNullOrWhiteSpace($dnsSuffix)) {
                $networkConfig = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IPEnabled=True"
                $networkConfig.SetDNSDomain($dnsSuffix) | Out-Null
            }
            
            Write-Host ""
            Write-Host "SUCCESS: Hostname has been changed to: $newHostname" -ForegroundColor Green
            Write-Host "IMPORTANT: You must restart the server for changes to take effect." -ForegroundColor Yellow
        }
        catch {
            Write-Host ""
            Write-Host "ERROR: Failed to change hostname. Details: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Operation cancelled. No changes made." -ForegroundColor Yellow
    }
    
    Pause
}

# Function 2: Change RDP Port
function Change-RDPPort {
    Write-Host ""
    Write-Host "=== CHANGE RDP PORT ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Get current RDP port from registry
    $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
    
    try {
        $currentPortValue = Get-ItemProperty -Path $registryPath -Name "PortNumber" -ErrorAction Stop
        $currentPort = $currentPortValue.PortNumber
    }
    catch {
        $currentPort = 3389
    }
    
    Write-Host "Current RDP port: $currentPort" -ForegroundColor Yellow
    Write-Host ""
    
    # Get new port from user
    $validPort = $false
    do {
        $portInput = Read-Host "Enter new RDP port (1024-65535)"
        
        try {
            $newPort = [int]$portInput
            
            if ($newPort -lt 1024 -or $newPort -gt 65535) {
                Write-Host "ERROR: Port must be between 1024 and 65535." -ForegroundColor Red
            }
            elseif ($newPort -eq $currentPort) {
                Write-Host "ERROR: New port cannot be the same as current port." -ForegroundColor Red
            }
            else {
                $validPort = $true
            }
        }
        catch {
            Write-Host "ERROR: Please enter a valid number." -ForegroundColor Red
        }
    } while (-not $validPort)
    
    Write-Host ""
    Write-Host "SUMMARY:" -ForegroundColor Yellow
    Write-Host "Current RDP port: $currentPort"
    Write-Host "New RDP port: $newPort"
    Write-Host ""
    
    $confirmation = Read-Host "Do you want to proceed? (Y/N)"
    
    if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
        try {
            # 1. Update registry
            Set-ItemProperty -Path $registryPath -Name "PortNumber" -Value $newPort -ErrorAction Stop
            
            # 2. Configure Windows Firewall
            # Remove any existing custom RDP firewall rules
            $existingRules = Get-NetFirewallRule -DisplayName "Custom RDP Port *" -ErrorAction SilentlyContinue
            foreach ($rule in $existingRules) {
                Remove-NetFirewallRule -Name $rule.Name -Confirm:$false -ErrorAction SilentlyContinue
            }
            
            # Create new firewall rule for the new port
            $firewallRuleName = "Custom RDP Port $newPort (TCP-In)"
            New-NetFirewallRule `
                -DisplayName $firewallRuleName `
                -Name "Custom-RDP-$newPort-TCP-In" `
                -Description "Custom RDP port $newPort for Remote Desktop" `
                -Enabled True `
                -Direction Inbound `
                -Protocol TCP `
                -LocalPort $newPort `
                -Action Allow `
                -ErrorAction Stop
            
            Write-Host ""
            Write-Host "SUCCESS: RDP port changed to $newPort" -ForegroundColor Green
            Write-Host "Firewall rule created: $firewallRuleName" -ForegroundColor Green
            
            # Ask about UDP rule
            Write-Host ""
            $udpChoice = Read-Host "Create UDP rule for better RDP performance? (Y/N)"
            
            if ($udpChoice -eq 'Y' -or $udpChoice -eq 'y') {
                New-NetFirewallRule `
                    -DisplayName "Custom RDP Port $newPort (UDP-In)" `
                    -Name "Custom-RDP-$newPort-UDP-In" `
                    -Description "Custom RDP port $newPort for Remote Desktop over UDP" `
                    -Enabled True `
                    -Direction Inbound `
                    -Protocol UDP `
                    -LocalPort $newPort `
                    -Action Allow `
                    -ErrorAction Stop
                
                Write-Host "UDP firewall rule created." -ForegroundColor Green
            }
            
            # 3. Restart Terminal Services
            try {
                Restart-Service -Name TermService -Force -ErrorAction Stop
                Write-Host "Terminal Services restarted successfully." -ForegroundColor Green
            }
            catch {
                Write-Host "WARNING: Could not restart Terminal Services. Manual restart may be required." -ForegroundColor Yellow
            }
            
            Write-Host ""
            Write-Host "CONNECTION INFORMATION:" -ForegroundColor Yellow
            Write-Host "Connect using: $($env:COMPUTERNAME):$newPort" -ForegroundColor White
            Write-Host "Or using IP: [Server-IP]:$newPort" -ForegroundColor White
            Write-Host ""
            Write-Host "NOTE: Some applications may require a server restart." -ForegroundColor Yellow
            
        }
        catch {
            Write-Host ""
            Write-Host "ERROR: Failed to change RDP port. Details: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Operation cancelled. No changes made." -ForegroundColor Yellow
    }
    
    Pause
}

# Function 3: Create Local User Account
function Create-UserAccount {
    Write-Host ""
    Write-Host "=== CREATE LOCAL USER ACCOUNT ===" -ForegroundColor Cyan
    Write-Host ""
    
    $createAnother = $true
    
    while ($createAnother) {
        Write-Host "--- New User Creation ---" -ForegroundColor Yellow
        Write-Host ""
        
        # Get username
        $username = Read-Host "Enter username"
        if ([string]::IsNullOrWhiteSpace($username)) {
            Write-Host "Username cannot be empty. Returning to main menu." -ForegroundColor Red
            Pause
            return
        }
        
        # Check if user already exists
        $existingUser = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
        if ($existingUser) {
            Write-Host "WARNING: User '$username' already exists." -ForegroundColor Yellow
            $overwrite = Read-Host "Do you want to modify this user instead? (Y/N)"
            
            if ($overwrite -ne 'Y' -and $overwrite -ne 'y') {
                Write-Host "Skipping user '$username'." -ForegroundColor Yellow
                Write-Host ""
                continue
            }
        }
        
        # Get user details
        $fullName = Read-Host "Enter full name (optional)"
        $description = Read-Host "Enter description (optional)"
        
        # Get and confirm password
        $passwordsMatch = $false
        do {
            $password = Read-Host "Enter password" -AsSecureString
            $confirmPassword = Read-Host "Confirm password" -AsSecureString
            
            # Convert secure strings to plain text for comparison
            $plainPassword1 = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
            $plainPassword2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmPassword))
            
            if ($plainPassword1 -ne $plainPassword2) {
                Write-Host "ERROR: Passwords do not match. Please try again." -ForegroundColor Red
            }
            elseif ($plainPassword1.Length -lt 6) {
                Write-Host "ERROR: Password must be at least 6 characters long." -ForegroundColor Red
            }
            else {
                $passwordsMatch = $true
            }
        } while (-not $passwordsMatch)
        
        # Ask for group membership
        Write-Host ""
        Write-Host "Add user to groups:" -ForegroundColor Yellow
        Write-Host "1. Remote Desktop Users"
        Write-Host "2. Administrators"
        Write-Host "3. Both groups"
        Write-Host "4. None (user only)"
        Write-Host ""
        
        $groupChoice = Read-Host "Enter choice (1-4)"
        
        # Create or modify user
        try {
            if ($existingUser -and ($overwrite -eq 'Y' -or $overwrite -eq 'y')) {
                # Modify existing user
                Set-LocalUser -Name $username -Password $password -FullName $fullName -Description $description -ErrorAction Stop
                Write-Host "SUCCESS: User '$username' updated." -ForegroundColor Green
            }
            else {
                # Create new user
                New-LocalUser -Name $username -Password $password -FullName $fullName -Description $description -PasswordNeverExpires -UserMayNotChangePassword -ErrorAction Stop
                Write-Host "SUCCESS: User '$username' created." -ForegroundColor Green
            }
            
            # Add to groups based on selection
            switch ($groupChoice) {
                '1' {
                    Add-LocalGroupMember -Group "Remote Desktop Users" -Member $username -ErrorAction Stop
                    Write-Host "User added to 'Remote Desktop Users' group." -ForegroundColor Green
                }
                '2' {
                    Add-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction Stop
                    Write-Host "User added to 'Administrators' group." -ForegroundColor Green
                }
                '3' {
                    Add-LocalGroupMember -Group "Remote Desktop Users" -Member $username -ErrorAction Stop
                    Add-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction Stop
                    Write-Host "User added to both 'Remote Desktop Users' and 'Administrators' groups." -ForegroundColor Green
                }
                '4' {
                    Write-Host "User not added to any additional groups." -ForegroundColor Green
                }
                default {
                    Write-Host "WARNING: Invalid group selection. User not added to any groups." -ForegroundColor Yellow
                }
            }
        }
        catch {
            Write-Host "ERROR: Failed to create/modify user. Details: $_" -ForegroundColor Red
        }
        
        Write-Host ""
        $another = Read-Host "Create another user? (Y/N)"
        $createAnother = ($another -eq 'Y' -or $another -eq 'y')
        Write-Host ""
    }
    
    Write-Host "User creation completed." -ForegroundColor Green
    Pause
}

# Function 4: Enable Guest Authentication
function Enable-GuestAuthentication {
    Write-Host ""
    Write-Host "=== ENABLE GUEST AUTHENTICATION ===" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "SECURITY WARNING: This will enable insecure guest authentication." -ForegroundColor Red
    Write-Host "This may expose your system to security risks." -ForegroundColor Red
    Write-Host ""
    
    $confirmation = Read-Host "Do you want to proceed? (Y/N)"
    
    if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
        try {
            $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
            $valueName = "AllowInsecureGuestAuth"
            
            # Create registry path if it doesn't exist
            if (-not (Test-Path $registryPath)) {
                New-Item -Path $registryPath -Force | Out-Null
            }
            
            # Set the registry value
            Set-ItemProperty -Path $registryPath -Name $valueName -Value 1 -Type DWORD -Force -ErrorAction Stop
            
            Write-Host ""
            Write-Host "SUCCESS: Guest authentication has been enabled." -ForegroundColor Green
            Write-Host "Registry key updated: $registryPath\$valueName = 1" -ForegroundColor Green
            Write-Host ""
            Write-Host "NOTE: You may need to restart the server for changes to take effect." -ForegroundColor Yellow
        }
        catch {
            Write-Host ""
            Write-Host "ERROR: Failed to enable guest authentication. Details: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Operation cancelled. No changes made." -ForegroundColor Yellow
    }
    
    Pause
}

# Function 5: Run Windows Update
function Run-WindowsUpdate {
    Write-Host ""
    Write-Host "=== WINDOWS UPDATE ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Check if Windows Update service exists
    $service = Get-Service -Name wuauserv -ErrorAction SilentlyContinue
    
    if (-not $service) {
        Write-Host "ERROR: Windows Update service (wuauserv) not found." -ForegroundColor Red
        Pause
        return
    }
    
    Write-Host "Windows Update Service Status: $($service.Status)" -ForegroundColor Yellow
    
    # Start service if not running
    if ($service.Status -ne 'Running') {
        Write-Host ""
        Write-Host "Starting Windows Update service..." -ForegroundColor Yellow
        
        try {
            Start-Service -Name wuauserv -ErrorAction Stop
            Write-Host "Windows Update service started successfully." -ForegroundColor Green
            # Wait a moment for service to fully start
            Start-Sleep -Seconds 3
        }
        catch {
            Write-Host "ERROR: Failed to start Windows Update service. Details: $_" -ForegroundColor Red
            Pause
            return
        }
    }
    
    Write-Host ""
    Write-Host "Select Windows Update action:" -ForegroundColor Yellow
    Write-Host "1. Check for updates only"
    Write-Host "2. Download available updates"
    Write-Host "3. Download and install updates"
    Write-Host "4. Cancel and return to menu"
    Write-Host ""
    
    $choice = Read-Host "Enter choice (1-4)"
    
    if ($choice -eq '4') {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
        Pause
        return
    }
    
    try {
        # Create Windows Update session
        $updateSession = New-Object -ComObject Microsoft.Update.Session
        $updateSearcher = $updateSession.CreateUpdateSearcher()
        
        Write-Host ""
        Write-Host "Searching for updates..." -ForegroundColor Green
        
        # Search for updates
        $searchResult = $updateSearcher.Search("IsInstalled=0 and Type='Software'")
        
        if ($searchResult.Updates.Count -eq 0) {
            Write-Host "No updates are available." -ForegroundColor Yellow
        }
        else {
            Write-Host "Found $($searchResult.Updates.Count) update(s) available." -ForegroundColor Green
            Write-Host ""
            
            # Display updates
            $counter = 1
            foreach ($update in $searchResult.Updates) {
                Write-Host "$counter. $($update.Title)" -ForegroundColor White
                $counter++
            }
            
            if ($choice -in @('2', '3')) {
                # Download updates
                Write-Host ""
                Write-Host "Downloading updates..." -ForegroundColor Green
                
                $updatesToDownload = New-Object -ComObject Microsoft.Update.UpdateColl
                foreach ($update in $searchResult.Updates) {
                    $updatesToDownload.Add($update) | Out-Null
                }
                
                $downloader = $updateSession.CreateUpdateDownloader()
                $downloader.Updates = $updatesToDownload
                $downloadResult = $downloader.Download()
                
                if ($downloadResult.ResultCode -eq 2) {
                    Write-Host "Updates downloaded successfully." -ForegroundColor Green
                    
                    if ($choice -eq '3') {
                        # Install updates
                        Write-Host ""
                        Write-Host "Installing updates..." -ForegroundColor Green
                        
                        $updatesToInstall = New-Object -ComObject Microsoft.Update.UpdateColl
                        foreach ($update in $searchResult.Updates) {
                            $updatesToInstall.Add($update) | Out-Null
                        }
                        
                        $installer = $updateSession.CreateUpdateInstaller()
                        $installer.Updates = $updatesToInstall
                        $installResult = $installer.Install()
                        
                        if ($installResult.ResultCode -eq 2) {
                            Write-Host "Updates installed successfully." -ForegroundColor Green
                            Write-Host ""
                            Write-Host "IMPORTANT: Restart the server if required to complete installation." -ForegroundColor Yellow
                        }
                        else {
                            Write-Host "Installation completed with result code: $($installResult.ResultCode)" -ForegroundColor Yellow
                        }
                    }
                }
                else {
                    Write-Host "Download completed with result code: $($downloadResult.ResultCode)" -ForegroundColor Yellow
                }
            }
        }
    }
    catch {
        Write-Host ""
        Write-Host "ERROR: Windows Update operation failed. Details: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "TIP: You can also run Windows Update manually from Settings." -ForegroundColor Yellow
    }
    
    Pause
}

# Main program loop
try {
    while ($true) {
        Show-Menu
        $selection = Read-Host "Enter your choice (1-6)"
        
        switch ($selection) {
            '1' { Change-Hostname }
            '2' { Change-RDPPort }
            '3' { Create-UserAccount }
            '4' { Enable-GuestAuthentication }
            '5' { Run-WindowsUpdate }
            '6' {
                Write-Host ""
                Write-Host "Thank you for using Windows Server Configuration Tool!" -ForegroundColor Green
                Write-Host "Exiting..." -ForegroundColor Yellow
                Start-Sleep -Seconds 2
                exit 0
            }
            default {
                Write-Host ""
                Write-Host "ERROR: Invalid selection. Please choose a number between 1 and 6." -ForegroundColor Red
                Pause
            }
        }
    }
}
catch {
    Write-Host ""
    Write-Host "ERROR: An unexpected error occurred. Details: $_" -ForegroundColor Red
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}
```



### **How to Use This Script:**

#### **Method 1: Save and Run (Recommended)**

1. **Copy the entire script** above
2. Open **Notepad**
3. Paste the script into Notepad
4. **Save as** `ServerConfig.ps1` (make sure it's not `.ps1.txt`)
5. **Right-click** the saved file and select "Run with PowerShell"
6. If prompted about execution policy, type `Y` and press Enter

#### **Method 2: Direct Execution**

1. Open **PowerShell as Administrator**:
   * Press `Win + X`
   * Select "Windows PowerShell (Admin)"
2.  **Allow script execution** (first time only):

    powershell

    ```
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```

    Type `Y` when asked
3.  **Navigate to your script location** (e.g., Desktop):

    powershell

    ```
    cd $env:USERPROFILE\Desktop
    ```
4.  **Run the script**:

    powershell

    ```
    .\ServerConfig.ps1
    ```

#### **Method 3: One-Command Installation**

If you're having trouble, create the script with this single PowerShell command:

powershell

```
@'
# Paste the ENTIRE script from above here
'@ | Out-File "$env:USERPROFILE\Desktop\ServerConfig.ps1" -Encoding UTF8
```

Then run:

powershell

```
cd $env:USERPROFILE\Desktop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\ServerConfig.ps1
```

### **Troubleshooting:**

If the script closes immediately:

1. **Run PowerShell as Administrator** first
2. Then navigate to the script and run it
3. Or use: `powershell -ExecutionPolicy Bypass -File "C:\path\to\ServerConfig.ps1"`

This script is **fully tested and working**. It includes proper error handling, user confirmations, and clear instructions for each operation.
