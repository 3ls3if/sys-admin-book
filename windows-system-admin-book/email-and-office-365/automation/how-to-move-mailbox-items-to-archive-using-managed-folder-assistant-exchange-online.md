---
icon: file-arrow-down
---

# How to Move Mailbox Items to Archive Using Managed Folder Assistant (Exchange Online)

## How to Move Mailbox Items to Archive Using Managed Folder Assistant (Exchange Online)

Managing mailbox size is a common administrative task in **Microsoft 365**. One of the most effective ways to automatically move older emails to the Online Archive is by using the **Managed Folder Assistant (MFA)** in Exchange Online or Microsoft Exchange Server.

This article explains how MFA works, prerequisites you must configure, and how to force archive processing using PowerShell.

***

### What Is Managed Folder Assistant?

**Managed Folder Assistant (MFA)** is a background process in Exchange that:

* Applies retention policies
* Enforces retention tags
* Moves eligible items to the Online Archive
* Deletes items when retention periods expire

Running this command:

```powershell
Start-ManagedFolderAssistant -Identity username
```

forces immediate processing of retention policies for a specific mailbox.

***

## Prerequisites Before Running MFA

MFA does **nothing** unless proper retention policies and archive settings are configured. Before running the command, ensure the following are in place.

***

### Step 1: Verify the Archive Mailbox Is Enabled

First, confirm the user has an Online Archive mailbox:

```powershell
Get-Mailbox username | Select ArchiveStatus
```

If the archive is not enabled, activate it:

```powersshell
Enable-Mailbox username -Archive
```

Allow 15–30 minutes for provisioning before proceeding.

***

### Step 2: Confirm a Retention Policy Is Assigned

Check which retention policy is applied:

```powershell
Get-Mailbox username | Select RetentionPolicy
```

If no policy is assigned, set one:

```powershell
Set-Mailbox username -RetentionPolicy "Default MRM Policy"
```

To see available retention policies:

```powershell
Get-RetentionPolicy
```

Without a retention policy, MFA will not process the mailbox.

***

### Step 3: Ensure the Policy Contains an Archive Tag

A retention policy must include a tag configured to move items to archive.

Check the policy’s tags:

```powershell
Get-RetentionPolicy "Default MRM Policy" | Select RetentionPolicyTagLinks
```

Then review the specific tag:

```powershell
Get-RetentionPolicyTag "Tag Name" | fl Name,Type,RetentionAction,AgeLimitForRetention
```

You must see:

```
RetentionAction : MoveToArchive
```

Example configuration:

* RetentionAction = MoveToArchive
* AgeLimitForRetention = 2 years

If no archive tag exists, items will never move.

***

## Forcing Archive Processing

Once everything is configured properly, run:

```powershell
Start-ManagedFolderAssistant -Identity username
```

#### When to Use -FullCrawl

Use this option only when:

* Retention settings were recently modified
* The mailbox has never been processed
* There is a large backlog of items

```powershell
Start-ManagedFolderAssistant -Identity username -FullCrawl
```

⚠️ Note: `-FullCrawl` is resource-intensive and may fail on very large mailboxes.

***

## How Long Does It Take?

Processing time depends on:

* Mailbox size
* Number of items
* Microsoft 365 backend load

It may take minutes or several hours. The process runs server-side and produces no real-time progress output.

***

## Monitoring Archive Growth

You can check mailbox and archive size before and after processing:

```powershell
Get-MailboxStatistics username | fl TotalItemSize
Get-MailboxStatistics username -Archive | fl TotalItemSize
```

An increase in Archive size confirms items are being moved.

***

## Important Notes

* MFA only processes items older than the configured retention age.
* It does not move items manually unless a retention tag applies.
* Users can apply personal retention tags if allowed.
* Archive must be fully provisioned before running MFA.

***

## Connecting to Exchange Online

Before running these commands, connect to Exchange Online PowerShell:

```powershell
Connect-ExchangeOnline
```

Ensure you are logged in with Exchange Admin or Global Admin permissions.

***

## Conclusion

Using **Managed Folder Assistant** is the correct and supported way to move mailbox items to the Online Archive in Exchange. However, it only works when:

1. Archive mailbox is enabled
2. A retention policy is assigned
3. The policy contains a `MoveToArchive` tag

Once configured correctly, MFA can efficiently manage mailbox growth and enforce compliance automatically.
