---
icon: building-shield
---

# Create a retention policy for Exchange Online

### Step 1: Create a retention tag <a href="#step-1-create-a-retention-tag" id="step-1-create-a-retention-tag"></a>

#### Use the Microsoft Purview portal to create a retention tag <a href="#use-the-microsoft-purview-portal-to-create-a-retention-tag" id="use-the-microsoft-purview-portal-to-create-a-retention-tag"></a>

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/) and navigate to **Solutions** > **Data lifecycle management** > **Exchange (legacy)** > **MRM Retention tags**, and then select **+ New tag**.
2. On the **Define how the tag will be applied** page, select one of the following options, and then select **Next**:
   *   <mark style="color:$warning;">**Automatically to entire mailbox (default)**</mark><mark style="color:$warning;">: Select this option to create a default policy tag (DPT). You can use DPTs to create a default deletion policy and a default archive policy, which applies to all items in the mailbox.</mark>

       <mark style="color:$warning;">You can't use this configuration to create a DPT to delete voice mail items. For details about how to create a DPT to delete voice mail items, see the Exchange Online PowerShell example on this page.</mark>
   *   <mark style="color:$warning;">**Automatically to default folder**</mark><mark style="color:$warning;">: Select this option to create a retention policy tag (RPT) for a default folder such as</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">**Inbox**</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">or</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">**Deleted Items**</mark><mark style="color:$warning;">, and then select the folder.</mark>

       <mark style="color:$warning;">You can create RPTs only with the</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">**Delete and allow recovery**</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">or</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">**Permanently delete**</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">retention actions.</mark>
   * <mark style="color:$warning;">**By users to items and folders (personal)**</mark><mark style="color:$warning;">: Select this option to create personal tags. These tags allow Outlook and Outlook on the web (formerly known as Outlook Web App. or OWA) users to apply archive or deletion settings to a message or folders that are different from the settings applied to the parent folder or the entire mailbox.</mark>
3.  On the **Define retention settings** page title and options will vary depending on the type of tag you selected. Complete the following fields, and then select **Next**:

    * **Retention Period**: Select one of the following options:
      * <mark style="color:$warning;">**When the item reaches the following age (in days)**</mark><mark style="color:$warning;">: Select this option and specify the number of days to retain items before they're moved or deleted. The retention age for all supported items except Calendar and Tasks is calculated from the date an item is received or created. Retention age for Calendar and Tasks items is calculated from the end date.</mark>
      * <mark style="color:$warning;">**Never**</mark><mark style="color:$warning;">: Select this option to specify that items should never be deleted or moved to the archive.</mark>
    *   **Retention Action**: Select one of the following actions to be taken after the item reaches its retention period:

        * <mark style="color:$warning;">**Delete and allow recovery**</mark><mark style="color:$warning;">: Select this action to delete items but allow users to recover them using the</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">**Recover Deleted Items**</mark> <mark style="color:$warning;"></mark><mark style="color:$warning;">option in Outlook or Outlook on the web. Items are retained until the deleted item retention period configured for the mailbox database or the mailbox user is reached.</mark>
        *   <mark style="color:$warning;">**Permanently delete**</mark><mark style="color:$warning;">: Select this option to permanently delete the item from the mailbox database.</mark>



        <mark style="color:purple;">**Important**</mark>

    <mark style="color:purple;">**While mailboxes or items are subject to holds such as Microsoft 365 retention policies or retention labels, or litigation hold, they won't be permanently deleted and will continue to be returned in eDiscovery searches.**</mark>



    * <mark style="color:$warning;">**Move item to archive**</mark><mark style="color:$warning;">: This action is available only if you're creating a DPT or a personal tag. Select this action to move items to the user's archive mailbox.</mark>
4. On the **Name your tag** page, enter a name and optional description, and then select **Next**:
   * <mark style="color:$warning;">**Name**</mark><mark style="color:$warning;">: Enter a name for the retention tag. The tag name is for display purposes and doesn't have any impact on the folder or item a tag is applied to. Consider that the personal tags you provision for users are available in Outlook and Outlook on the web.</mark>
   * <mark style="color:$warning;">**Description**</mark><mark style="color:$warning;">: User this optional field to enter any administrative notes or comments. The field isn't displayed to users.</mark>
5. Review and submit to create the tag with your chosen configuration.



***

### Step 2: Create a retention policy <a href="#step-2-create-a-retention-policy" id="step-2-create-a-retention-policy"></a>

#### Use the Microsoft Purview portal to create a retention policy <a href="#use-the-microsoft-purview-portal-to-create-a-retention-policy" id="use-the-microsoft-purview-portal-to-create-a-retention-policy"></a>

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/) and navigate to **Solutions** > **Data lifecycle management** > **Exchange (legacy)** > **MRM Retention policies**, and then select **New policy**.
2.  On the **Configure your policy** page, enter a name for the retention policy, and then select **+ Add tag** to select the tags you want to add to this retention policy.

    You can create a retention policy without adding any retention tags to it, but items in the mailbox to which the policy is applied won't be moved or deleted. You can also add and remove retention tags from a retention policy after it's created.
3.  On the **Choose retention tags** page, select the tags you want, and then select **Add**.

    A retention policy can contain the following tags:

    * One DPT with the **Move item to archive** action.
    * One DPT with the **Delete and allow recovery** or **Permanently delete** actions.
    * One DPT for voice mail messages with the **Delete and allow recovery** or **Permanently delete** actions.
    * One RPT per default folder such as **Inbox** to delete items.
    * Any number of personal tags.

{% hint style="warning" %}
Although you can add any number of personal tags to a retention policy, having many personal tags with different retention settings can confuse users. We recommend linking no more than ten personal tags to a retention policy.
{% endhint %}

4. Review and submit to create your retention policy with your configurations.

You can create a retention policy without adding any retention tags to it, but items in the mailbox to which the policy is applied won't be moved or deleted. You can also add and remove retention tags from a retention policy after it's created.



***

### Step 3: Apply a retention policy to mailbox users <a href="#step-3-apply-a-retention-policy-to-mailbox-users" id="step-3-apply-a-retention-policy-to-mailbox-users"></a>

\
After you create a retention policy, you must apply it to mailbox users. You can apply different retention policies to different set of users. For detailed instructions, see [Apply a retention policy to mailboxes](https://learn.microsoft.com/en-us/exchange/security-and-compliance/messaging-records-management/apply-retention-policy).

\


After you create retention tags, add them to a retention policy, and apply the policy to a mailbox user, the next time the MRM mailbox assistant processes the mailbox, messages are moved or deleted based on settings you configured in the retention tags.

To verify that you have applied the retention policy, do the following:

1.  Replace \<Mailbox Identity> with the name, email address, or alias of the mailbox, and run the following command in Exchange Online PowerShell command to run the MRM assistant manually against a single mailbox:

    ```powershell
    Start-ManagedFolderAssistant -Identity "<Mailbox Identity>"
    ```
2. Log on to the mailbox using Outlook or Outlook on the web and verify that messages are deleted or moved to an archive in accordance with the policy configuration.



***

## REFERENCES

* [https://learn.microsoft.com/en-us/exchange/security-and-compliance/messaging-records-management/create-a-retention-policy](https://learn.microsoft.com/en-us/exchange/security-and-compliance/messaging-records-management/create-a-retention-policy)
