---
icon: folder-user
---

# Create Bulk Contacts



<figure><img src="../../.gitbook/assets/Screenshot 2026-02-15 at 4.45.15 PM.png" alt=""><figcaption></figcaption></figure>

## PowerShell Script

```
# ===============================
# CONFIGURATION
# ===============================
 
$CsvPath = "C:\Users\test\Desktop\bulk_contacts\Import_Contact_Template.csv"
$LogFile = "C:\Users\test\Desktop\log.txt"
 
# ===============================
# CONNECT TO EXCHANGE ONLINE
# ===============================
 
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
 
# ===============================
# IMPORT CONTACTS
# ===============================
 
$Contacts = Import-Csv -Path $CsvPath
 
foreach ($Contact in $Contacts) {
 
    try {
 
        # Check if contact already exists
        $ExistingContact = Get-MailContact -Filter "ExternalEmailAddress -eq '$($Contact.Email)'" -ErrorAction SilentlyContinue
 
        if ($ExistingContact) {
            Write-Host "Already exists: $($Contact.DisplayName)" -ForegroundColor Yellow
            Add-Content -Path $LogFile -Value "$(Get-Date) - Skipped (Exists): $($Contact.DisplayName)"
            continue
        }
 
        # Create Mail Contact
        New-MailContact `
            -Name $Contact.DisplayName `
            -DisplayName $Contact.DisplayName `
            -ExternalEmailAddress $Contact.Email
 
        Write-Host "Created: $($Contact.DisplayName)" -ForegroundColor Green
        Add-Content -Path $LogFile -Value "$(Get-Date) - Created: $($Contact.DisplayName)"
 
    }
    catch {
        Write-Host "Error creating $($Contact.DisplayName): $_" -ForegroundColor Red
        Add-Content -Path $LogFile -Value "$(Get-Date) - ERROR: $($Contact.DisplayName) - $_"
    }
}
 
# ===============================
# DISCONNECT
# ===============================
 
Disconnect-ExchangeOnline -Confirm:$false
Write-Host "Import completed."
```
