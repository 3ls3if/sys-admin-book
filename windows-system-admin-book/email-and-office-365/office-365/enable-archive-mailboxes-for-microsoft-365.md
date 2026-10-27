---
icon: folder-arrow-down
---

# Enable archive mailboxes for Microsoft 365

## What is an **archive mailbox**?

{% hint style="success" %}
Email archiving in Microsoft 365 (also called _In-Place Archiving_) provides users with more mailbox storage space. For more information, see [Learn about archive mailboxes](https://learn.microsoft.com/en-us/purview/archive-mailboxes).
{% endhint %}

An **archive mailbox** is like an extra storage space for your emails in Microsoft Exchange Online (used with Outlook, Microsoft 365, etc.). It's often called **"In-Place Archive"**.

When it's **enabled** for a user, older emails that meet certain rules (called **archive policies**) are automatically **moved from the primary mailbox to the archive mailbox**. This helps keep the main mailbox cleaner and can help with performance or compliance.

## What does the **default archive policy** do?

By default:

* <mark style="color:green;">Emails that are</mark> <mark style="color:green;"></mark><mark style="color:green;">**2 years old or older**</mark> <mark style="color:green;"></mark><mark style="color:green;">(from the date they were sent or created) are</mark> <mark style="color:green;"></mark><mark style="color:green;">**moved to the archive mailbox**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">This is done</mark> <mark style="color:green;"></mark><mark style="color:green;">**automatically**</mark><mark style="color:green;">, based on a policy that’s already applied to most Exchange Online mailboxes.</mark>

{% hint style="warning" %}
#### Example:

Let’s say a user receives or writes an email on **April 10, 2023**.\
With the default policy:

* That email will stay in the **main mailbox** until **April 10, 2025**.
* After that, it will be automatically **moved to the archive mailbox**.
{% endhint %}

{% hint style="warning" %}
#### When does this happen?

This happens **after you enable the archive mailbox** for that user.\
If the archive isn't enabled, **no automatic move will occur**, even if the policy exists.
{% endhint %}

## How to enable an archive mailbox

1. <mark style="color:green;">Sign in to the</mark> [<mark style="color:green;">Exchange admin center</mark>](https://go.microsoft.com/fwlink/p/?linkid=2059104) <mark style="color:green;">(EAC) and navigate to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Recipients**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Mailboxes**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">In the list of mailboxes, select the user to enable their mailbox for archive.</mark>
3. <mark style="color:green;">In the flyout pane, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Others**</mark><mark style="color:green;">, and under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Mailbox archive**</mark><mark style="color:green;">, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manage mailbox archive**</mark><mark style="color:green;">:</mark>

![Manage mailbox archive for a selected user.](https://learn.microsoft.com/en-us/purview/media/manage-mailbox-archive-option.png)

4. <mark style="color:green;">On the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manage mailbox archive**</mark> <mark style="color:green;"></mark><mark style="color:green;">pane, turn on</mark> <mark style="color:green;"></mark><mark style="color:green;">**Mailbox archive**</mark><mark style="color:green;">, and then</mark> <mark style="color:green;"></mark><mark style="color:green;">**Save**</mark><mark style="color:green;">.</mark>

{% hint style="success" %}
It might take a few moments to create the archive mailbox. When it's created, **Active** is displayed in the **Archive status** column for the selected user, although you might need to refresh the page to see the change of status.
{% endhint %}



***

## REFERENCES

* [https://learn.microsoft.com/en-us/purview/enable-archive-mailboxes](https://learn.microsoft.com/en-us/purview/enable-archive-mailboxes)
