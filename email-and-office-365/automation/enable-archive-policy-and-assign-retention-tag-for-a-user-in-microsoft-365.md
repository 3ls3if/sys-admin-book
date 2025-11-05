---
icon: folder-arrow-up
---

# Enable Archive Policy & Assign Retention Tag for a User in Microsoft 365

#### **1. Install Exchange Online Module**

Run PowerShell as Administrator and install the required module:

```powershell
Install-Module -Name ExchangeOnlineManagement
```

* Type **Y** when prompted for installation confirmation.
* Type **Yes** when asked for repository installation.

***

#### **2. Connect to Exchange Online**

```powershell
Connect-ExchangeOnline
```

You’ll be prompted to log in with your Microsoft 365 admin credentials.

***

#### **3. Enable Archive Mailbox**

Enable archive mailbox for the user:

```powershell
Enable-Mailbox -Identity "user@domain.com" -Archive
```

Verify archive status:

```powershell
Get-Mailbox -Identity "user@domain.com" | FL ArchiveStatus
```

✅ _You can also verify the archive folder in Outlook after a few minutes._

***

#### **4. Enable Auto-Expanding Archive**

```powershell
Enable-Mailbox -Identity "user@domain.com" -AutoExpandingArchive
```

🕒 Allow \~30 minutes for the change to take effect.

***

#### **5. Create Retention Tag**

Create a retention tag to move items to archive after 1 year:

```powershell
New-RetentionPolicyTag -Name "Move to Archive After 1 Year" -Type All -AgeLimitForRetention 365 -RetentionAction MoveToArchive
```

**If an error occurs:**

```powershell
Enable-OrganizationCustomization
```

Then re-run the Retention Tag command above.

***

#### **6. Create and Assign Retention Policy**

Create a new retention policy and link the tag:

```powershell
New-RetentionPolicy -Name "Archive 1 Year Policy" -RetentionPolicyTagLinks "Move to Archive After 1 Year"
```

Assign the policy to a specific mailbox:

```powershell
Set-Mailbox -Identity "user@domain.com" -RetentionPolicy "Archive 1 Year Policy"
```

***

#### **7. Force Apply Retention Policy (Optional)**

Manually trigger Managed Folder Assistant (if allowed):

```powershell
Start-ManagedFolderAssistant -Identity "user@domain.com"
```

⚠️ _Note: MFA runs automatically every 7 days per mailbox. Manual triggering may fail if backend restrictions apply._

***

#### **8. Verify Archive & Policy Status**

Check if archive and auto-expanding archive are enabled:

```powershell
Get-Mailbox -Identity "user@domain.com" | FL ArchiveStatus, AutoExpandingArchiveEnabled
```

Check mailbox statistics (archive progress, size, etc.):

```powershell
Get-MailboxStatistics -Identity "user@domain.com" -Archive | Select DisplayName, ItemCount, TotalItemSize, LastLogonTime
```

***

#### **9. Important Notes**

* Archiving does **not happen instantly** — allow up to **12–24 hours** for the Managed Folder Assistant to process.
* MFA runs automatically once every 7 days per mailbox.
* Archive ensures compliance and helps optimize mailbox storage.

***

#### ✅ **End Result**

After completing all steps:

* The **archive mailbox** and **auto-expanding archive** are enabled.
* The **retention policy** automatically moves emails older than 1 year to the archive folder.
* Mailbox data is now **compliant, optimized, and efficiently managed**.
