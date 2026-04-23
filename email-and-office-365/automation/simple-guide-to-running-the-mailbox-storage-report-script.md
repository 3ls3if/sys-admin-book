---
icon: hard-drive
---

# Simple Guide to Running the Mailbox Storage Report Script

### Simple Guide to Running the Mailbox Storage Report Script

Managing mailbox storage in Exchange Online is an essential task for administrators, especially when keeping track of usage, quotas, and potential storage risks. The provided PowerShell script offers a straightforward way to generate a detailed mailbox storage report with minimal setup and effort.

This guide walks you through how to use the script and what to expect from it.

***

### Script

```powershell
# Ultra-simple version - just basic info
function Get-BasicMailboxStorage {
    # Connect
    Connect-ExchangeOnline
    Write-Host "Getting mailbox list..." -ForegroundColor Yellow
    $mailboxes = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox
    $results = @()
    foreach ($mbx in $mailboxes) {
        Write-Host "Processing: $($mbx.DisplayName)" -ForegroundColor Gray
        $stats = Get-MailboxStatistics -Identity $mbx.Identity -ErrorAction SilentlyContinue
        if ($stats) {
            $results += [PSCustomObject]@{
                Name = $mbx.DisplayName
                Email = $mbx.PrimarySmtpAddress
                Size = $stats.TotalItemSize.ToString()
                Items = $stats.ItemCount
                DeletedItems = $stats.DeletedItemCount
                Quota = $mbx.ProhibitSendReceiveQuota.ToString()
                WarningQuota = $mbx.IssueWarningQuota.ToString()
                Archive = $mbx.ArchiveStatus
            }
        }
    }
    # Export results
    $results | Export-Csv "MailboxReport_$(Get-Date -Format yyyyMMdd).csv" -NoTypeInformation
    # Display sample
    $results | Select-Object -First 10 | Format-Table -AutoSize
    Write-Host "Report saved to: MailboxReport_$(Get-Date -Format yyyyMMdd).csv" -ForegroundColor Green
}
 
Get-BasicMailboxStorage
```



#### Getting Started

To begin, open **PowerShell as an Administrator**. This ensures you have the necessary permissions to connect to Exchange Online and retrieve mailbox data.

**Once PowerShell is open:**

1. **Copy the entire script (it’s recommended to use the first version provided).**
2. **Paste it directly into the PowerShell window.**
3. **Run the script.**

When prompted, enter your **admin credentials** to establish a connection to Exchange Online.

***

#### What Happens During Execution

After authentication, the script will begin processing all user mailboxes in your organization.

Here’s what it does step by step:

* **Connects securely to Exchange Online**
* **Retrieves a full list of user mailboxes**
* **Processes each mailbox individually**
* **Displays progress updates, including percentage completion**
* **Collects key data such as:**
  * **Mailbox size**
  * **Item count**
  * **Deleted items**
  * **Quota limits**
  * **Archive status**

Depending on your environment size, the process will take approximately **5–10 minutes** for 200+ mailboxes.

***

#### Output and Reporting

Once the script completes:

* A **CSV report** is automatically generated in the same folder where the script was run
* The file name includes a timestamp for easy tracking
* A preview of the data is displayed in the PowerShell window

Additionally, the script provides:

* **Summary statistics**
* Identification of mailboxes approaching capacity
* Highlighting of mailboxes exceeding **85% usage**, helping you quickly spot potential issues

At the end, you’ll also be prompted to disconnect your session.

***

#### Why This Script Is Useful

This script is especially helpful for:

* Routine mailbox storage audits
* Identifying users close to quota limits
* Capacity planning
* Maintaining healthy mailbox usage across the organization

It removes the need for manual checks and consolidates everything into a clean, exportable report.

***

#### Troubleshooting

If you encounter any issues while running the script, it’s often related to the Exchange Online module version.

You can verify and update it using the following commands:

```powershell
# Check your module version
Get-Module ExchangeOnlineManagement -ListAvailable

# Update if needed
Update-Module ExchangeOnlineManagement -Force
```

Keeping the module updated ensures compatibility and reduces connection or execution errors.

***

#### Final Thoughts

This script provides a simple yet effective way to monitor mailbox storage across your organization. With minimal setup and clear output, it’s a practical tool for administrators who need quick visibility into mailbox usage and potential storage risks.

Run it periodically to stay ahead of quota issues and maintain a smooth Exchange Online environment.
