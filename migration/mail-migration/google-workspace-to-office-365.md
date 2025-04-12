---
icon: g
---

# Google Workspace to Office 365

{% embed url="https://www.youtube.com/watch?v=LjxJo7fEwEM&ab_channel=SpecSpace" %}

***

## Manually Migrate from Google Workspace to Office 365

Before we start the procedure, ensure you have the following prerequisites:

* <mark style="color:green;">**M365 Exchange Global Admin Account Access**</mark>
* <mark style="color:green;">**Super Admin Account Access in Google Workspace**</mark>

We have divided this procedure into several parts for a clear understanding. Follow these steps:

## Part 1: Adding Office 365 Domain and Users

**For Domain:**

1. <mark style="color:green;">**Log in**</mark> <mark style="color:green;"></mark><mark style="color:green;">to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Microsoft 365 Admin Center**</mark> <mark style="color:green;"></mark><mark style="color:green;">and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Settings -> Domain**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Hit</mark> <mark style="color:green;"></mark><mark style="color:green;">**+ Add Domain**</mark><mark style="color:green;">, enter a name, and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Use this Domain**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Then,</mark> <mark style="color:green;"></mark><mark style="color:green;">**verify your domain > Verify > Continue > Done**</mark><mark style="color:green;">.</mark>

**Note:** Only verify the domain by adding **TXT records** and don’t update **MX records**.

**For Users:**

1. <mark style="color:green;">In the</mark> <mark style="color:green;"></mark><mark style="color:green;">**M365 Admin Center**</mark><mark style="color:green;">, press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Users**</mark> <mark style="color:green;"></mark><mark style="color:green;">and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Active Users**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add a User**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add multiple Users**</mark> <mark style="color:green;"></mark><mark style="color:green;">and provide the required details.</mark>
3. <mark style="color:green;">Hit</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">, choose a</mark> <mark style="color:green;"></mark><mark style="color:green;">**location**</mark><mark style="color:green;">, and assign</mark> <mark style="color:green;"></mark><mark style="color:green;">**licenses**</mark><mark style="color:green;">. Tap</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Assign</mark> <mark style="color:green;"></mark><mark style="color:green;">**user roles**</mark> <mark style="color:green;"></mark><mark style="color:green;">(optional), click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">, and hit</mark> <mark style="color:green;"></mark><mark style="color:green;">**Finish > Close**</mark><mark style="color:green;">.</mark>
5. <mark style="color:green;">Further, create a</mark> <mark style="color:green;"></mark><mark style="color:green;">**CSV**</mark> <mark style="color:green;"></mark><mark style="color:green;">file with</mark> <mark style="color:green;"></mark><mark style="color:green;">**Username (Source email)**</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">**Email Address (Destination)**</mark> <mark style="color:green;"></mark><mark style="color:green;">fields.</mark>

## Part 2: Create a Migration Batch to Migrate Google Workspace to Office 365

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Exchange Admin Center**</mark> <mark style="color:green;"></mark><mark style="color:green;">and tap</mark> <mark style="color:green;"></mark><mark style="color:green;">**Migration >> Add Migration Batch**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Here, provide a unique</mark> <mark style="color:green;"></mark><mark style="color:green;">**name**</mark> <mark style="color:green;"></mark><mark style="color:green;">and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Migrate to Exchange Online**</mark> <mark style="color:green;"></mark><mark style="color:green;">path.</mark>
3. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark> <mark style="color:green;"></mark><mark style="color:green;">and pick</mark> <mark style="color:green;"></mark><mark style="color:green;">**Google Workspace (Gmail) migration > Next**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Afterward, in</mark> <mark style="color:green;"></mark><mark style="color:green;">**Prerequisites**</mark><mark style="color:green;">, expand</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manually configure your Google**</mark>

**Workspace for migration**.

1. <mark style="color:orange;">Later, configure the following:</mark>

* <mark style="color:orange;">Creating a Google Service Account</mark>
* <mark style="color:orange;">Enabling API Usage for Project</mark>
* <mark style="color:orange;">Granting Access to Google tenants for service accounts. Tap Next.</mark>

2\. <mark style="color:green;">Furthermore, create a</mark> <mark style="color:green;"></mark><mark style="color:green;">**new migration endpoint**</mark> <mark style="color:green;"></mark><mark style="color:green;">and hit</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">.</mark>

3\. <mark style="color:green;">In</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add Users**</mark><mark style="color:green;">, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Import CSV**</mark> <mark style="color:green;"></mark><mark style="color:green;">and upload the earlier created</mark> <mark style="color:green;"></mark><mark style="color:green;">**CSV**</mark><mark style="color:green;">. Hit</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next.**</mark>

4\. <mark style="color:green;">Subsequently, set a</mark> <mark style="color:green;"></mark><mark style="color:green;">**target delivery domain**</mark> <mark style="color:green;"></mark><mark style="color:green;">from the list in</mark> <mark style="color:green;"></mark><mark style="color:green;">**Configuration**</mark> <mark style="color:green;"></mark><mark style="color:green;">and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**mailboxes**</mark> <mark style="color:green;"></mark><mark style="color:green;">to migrate. Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">.</mark>

5\. <mark style="color:green;">At last, in the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Schedule Batch Migration**</mark> <mark style="color:green;"></mark><mark style="color:green;">tab,</mark>

* <mark style="color:red;">Select an</mark> <mark style="color:red;"></mark><mark style="color:red;">**email address**</mark> <mark style="color:red;"></mark><mark style="color:red;">to get the report</mark>
* <mark style="color:red;">Pick</mark> <mark style="color:red;"></mark><mark style="color:red;">**Automatically Start and End the Batch**</mark> <mark style="color:red;"></mark><mark style="color:red;">as</mark> <mark style="color:red;"></mark><mark style="color:red;">**Migration Batch Fields**</mark>
* <mark style="color:red;">Set a</mark> <mark style="color:red;"></mark><mark style="color:red;">**timezone**</mark> <mark style="color:red;"></mark><mark style="color:red;">and hit</mark> <mark style="color:red;"></mark><mark style="color:red;">**Save > Done**</mark><mark style="color:red;">.</mark>

## Part 3: Updating MX Records to Migrate Email from Google Workspace to Office 365

1. <mark style="color:green;">Move to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**M365 Admin Center**</mark> <mark style="color:green;"></mark><mark style="color:green;">and tap</mark> <mark style="color:green;"></mark><mark style="color:green;">**Settings -> Domain.**</mark>
2. <mark style="color:green;">Here, select the</mark> <mark style="color:green;"></mark><mark style="color:green;">**domain**</mark> <mark style="color:green;"></mark><mark style="color:green;">to add an</mark> <mark style="color:green;"></mark><mark style="color:green;">**MX record**</mark> <mark style="color:green;"></mark><mark style="color:green;">and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manage DNS**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Select an option to</mark> <mark style="color:green;"></mark><mark style="color:green;">**connect DNS**</mark> <mark style="color:green;"></mark><mark style="color:green;">and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Continue > Continue > Finish**</mark><mark style="color:green;">.</mark>

{% hint style="warning" %}
Your manual procedure for migration ends here. You have an alternative freeway too, i.e. using **Powershell commands**. However, it is quite complex.
{% endhint %}



***

## REFERENCES

* [https://www.linkedin.com/pulse/how-migrate-google-workspace-office-365-easy-steps-lovely-baghel-sfijf/](https://www.linkedin.com/pulse/how-migrate-google-workspace-office-365-easy-steps-lovely-baghel-sfijf/)
* [https://support.google.com/a/answer/7378726?hl=en](https://support.google.com/a/answer/7378726?hl=en)
