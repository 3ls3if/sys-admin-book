---
icon: g
---

# Migrate Hostinger Email to Google Workspace or Gmail Account

## **Easy Ways to Migrate Hostinger Email to Google Workspace**

\
Prominently, there are two main ways to perform migration. However, the right method depends on your requirement–whether you’re moving just one account or an entire business domain. But, before you proceed with migration, go through the prerequisites mentioned below.

**Pre-Migration To Do’s**

* Must have a backup ready for your Hostinger mailbox in case of accidental data loss.
* Secondly, make sure you have created a specific Gmail account for each Hostinger user.
* Also, you have to enable IMAP in Hostinger mailboxes for smooth migration.
* Keep all your login credentials, like usernames, passwords, and mail server details, in a safe place.



***

## Migrate Emails from Hostinger to Google Workspace via Google Admin Console

Follow the process below to start:

1. <mark style="color:$success;">Log in to</mark> [<mark style="color:$success;">**Google Admin Console**</mark>](https://admin.google.com/)<mark style="color:$success;">.</mark>&#x20;
2. <mark style="color:$success;">Go to Data Migration Service.</mark>
3. <mark style="color:$success;">Select</mark> <mark style="color:$success;"></mark><mark style="color:$success;">**Email**</mark> <mark style="color:$success;"></mark><mark style="color:$success;">as the Migration Source.</mark>
4. <mark style="color:$success;">Choose IMAP as the connection protocol.</mark>
5. <mark style="color:$success;">Enter Hostinger mail server details:</mark>

* <mark style="color:$success;">**IMAP Server:**</mark> <mark style="color:$success;"></mark><mark style="color:$success;">imap.hostinger.com</mark>
* <mark style="color:$success;">**Port:**</mark> <mark style="color:$success;"></mark><mark style="color:$success;">993 (SSL enabled)</mark>

6. <mark style="color:$success;">Provide Hostinger email address and password.</mark>
7. <mark style="color:$success;">Select the users you want to migrate to Google Workspace.</mark>
8. <mark style="color:$success;">Start the migration and track progress.</mark>

However, this process is risky if not performed properly.

{% hint style="warning" %}
**Real-World Case Example**

An evolving design agency chose to via Google Admin Console. The process lasted for 36 hours, and immediately after migration, the following happened:

* Many incoming client emails bounced due to incomplete DNS propagation.
* Due to improper sync, accounts were cluttered by duplicates.
* Also, some emails were missing & many important attachments were damaged.
{% endhint %}

***

## Transfer Hostinger Email to Gmail for Personal Accounts

This process is an ideal choice for a small volume of data, or personal accounts:

1. <mark style="color:$success;">Log in to your Gmail account.</mark>
2. <mark style="color:$success;">Open Settings > click See All Settings.</mark>
3. <mark style="color:$success;">Next, click</mark> <mark style="color:$success;"></mark><mark style="color:$success;">**Accounts and Import**</mark><mark style="color:$success;">.</mark>
4. <mark style="color:$success;">Under Check mail from other accounts, select</mark> <mark style="color:$success;"></mark><mark style="color:$success;">**Add a mail account.**</mark>
5. <mark style="color:$success;">After that, enter your source Hostinger email ID.</mark>
6. <mark style="color:$success;">Select</mark> <mark style="color:$success;"></mark><mark style="color:$success;">**Import emails using POP3**</mark><mark style="color:$success;">.</mark>
7. <mark style="color:$success;">Enter the following details:</mark>

* <mark style="color:$success;">**POP3 Server:**</mark> <mark style="color:$success;"></mark><mark style="color:$success;">pop.hostinger.com</mark>
* <mark style="color:$success;">**Port:**</mark> <mark style="color:$success;"></mark><mark style="color:$success;">995</mark>
* <mark style="color:$success;">**Username:**</mark> <mark style="color:$success;"></mark><mark style="color:$success;">Full email address</mark>
* <mark style="color:$success;">**Password**</mark><mark style="color:$success;">: Your Hostinger email password</mark>

8. <mark style="color:$success;">You can choose to leave a copy on the server or not.</mark>
9. <mark style="color:$success;">Start Migration.</mark>

Finally, Gmail will begin to fetch your Hostinger emails and show them in your Gmail mailbox.

{% hint style="warning" %}
**Hidden Challenges During Migration**

* DNS propagation delays are a challenge
* Emails go missing, and attachments are corrupt.&#x20;
* May cause email forwarding conflicts
* Missed creating app-specific passwords
{% endhint %}

***

## REFERENCES

* [https://www.macsonik.com/blog/migrate-hostinger-email-to-google-workspace/](https://www.macsonik.com/blog/migrate-hostinger-email-to-google-workspace/)
