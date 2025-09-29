---
icon: cloud-sun
---

# Unable to Delete Mails from Outlook Web: Delayed hold and Delay Release hold Remove

{% hint style="warning" %}
Check there is Delayed hold and Delay Release hold applied on the mailbox, and also Single Item recovery enabled.
{% endhint %}

{% hint style="warning" %}
> To get the items deleted from deleted items folder to reduce the size of items in Discovery hold and Recoverable folder, we will need to remove the hold assigned on the mailbox.&#x20;
>
> **NOTE:** To keep you advised, once the Holds are removed the emails will be deleted from Discovery hold and Recoverable folder permanently and will not be able to recover.
>
> Please remove the holds only with the owner's consent.
{% endhint %}

> **Check and Disable Litigation hold.**
>
> * `Get-Mailbox <username> | FL LitigationHoldEnabled`&#x20;
> * `Set-Mailbox <username> -LitigationHoldEnabled $false`
>
> &#x20;**Checked and Disable Single item recovery hold.**&#x20;
>
> * `Get-Mailbox <username> | FL SingleItemRecoveryEnabled,RetainDeletedItemsFor`
> * `Set-Mailbox <username> -SingleItemRecoveryEnabled $false -RetainDeletedItemsFor 00`
>
> **NOTE:** It might take up to 240 minutes to disable single item recovery. Don't delete items in the Recoverable Items folder until this period has elapsed. Once the Single item recovery hold is removed, there are chances that Delay Hold and Delay Release Hold may apply for protection of our account. Check the Delay Hold and Delay Release Hold by below command.
>
> * `Get-Mailbox <username> | FL DelayHoldApplied,DelayReleaseHoldApplied`
> * `Get-Mailbox <username> | FL *HoldApplied*`
>
> &#x20;Once you confirm Delay Hold and Delay Release Hold are applied, remove the hold by below commands.
>
> * `Set-Mailbox <username> -RemoveDelayHoldApplied`
> * `Set-Mailbox <username> -RemoveDelayReleaseHoldApplied`
>
> This will take time for the size to decrease as the hold removed may take time propagate as noted above. Once all Hold are removed, Run the Managed Folder Assistant 4-5 times to start the MRM process.
>
> `Start-ManagedFolderAssistant -identity` [`User@domain.com`](mailto:User@domain.com) `-holdcleanu`
>
> `Start-ManagedFolderAssistant -identity` [`User@domain.com`](mailto:User@domain.com) `-FullCrawl`

