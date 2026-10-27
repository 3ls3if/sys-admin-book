---
icon: folder
---

# How to Apply Retention Tags to Non-Default Folders in Office 365

### Types of Retention Tags

1. **Default Policy Tag (DPT)** – automatically set to entire mailbox and will be used to tag untagged items that neither have an RPT or any personal retention tags applied.
2. **Retention Policy Tag** – automatically applied to default folders in a user’s mailbox. Here is a list of default folders in Outlook:

* Archive
* Calendar
* Conversation History
* Deleted Items
* Drafts
* Inbox
* Junk E-mail
* Outbox
* Recoverable Items
* Sent Items
* Sync Issues
* Tasks

3. **Personal Tag** – manually set by users in either Outlook or Outlook Web Access. It can be applied both to folders, including created folders, and individual messages.

![Retention](https://vastitservices.com/wp-content/uploads/2022/05/retention1.jpg)

\
How-To Steps to Apply Retention Tags to Non-Default Folders

**1. `New-RetentionPolicyTag -Name “EVaultRetention” -Type Archive -AgeLimitForRetention 2556 -RetentionAction DeleteAndAllowRecovery`**

The command will create a retention policy tag (RPT) that will delete after 7 years to just the Archive default folder (**-Type Archive**)

**2. `Set-RetentionPolicy “My Policy” -RetentionPolicyTagLinks EVaultRetention”`**

The command will link our newly created RPT to a policy of your choosing. It can be applied to the default policy or a new one.

**3. `$UserMailboxes = Get-Mailbox -Filter {(RecipientTypeDetails -eq ‘UserMailbox’)} $UserMailboxes | Set-Mailbox –RetentionPolicy “My Policy”`**&#x20;

The command will apply the My Policy retention policy to all mailboxes

OR

**`Set-Mailbox`** [**`name@domain.com`**](mailto:name@domain.com) **`-RetentionPolicy “My Policy”`**

Which would set the My Policy retention policy to a specific mailbox

**4. `Start-ManagedFolderAssistant -Identity`** [**`name@domain.com`**](mailto:name@domain.com)

This will push about the above changes to a single mailbox. If you remove the -Identity switch and just execute “**Start-ManaagedFolderAssistant”** it will apply all mailboxes.



***

## REFERENCES

* [https://vastitservices.com/blog/how-to-apply-retention-tags-to-non-default-folders-in-office-365/](https://vastitservices.com/blog/how-to-apply-retention-tags-to-non-default-folders-in-office-365/)
* [https://learn.microsoft.com/en-us/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies](https://learn.microsoft.com/en-us/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies)
