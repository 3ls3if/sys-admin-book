---
icon: windows
---

# One Drive to One Drive \[SharePoint Migration Tool]

## Using SharePoint Migration Tool (SPMT)

#### **Pre-requisites**

* <mark style="color:yellow;">Microsoft 365 tenant access for both source and target users</mark>
* <mark style="color:yellow;">Admin or delegated permissions</mark>
* <mark style="color:yellow;">SharePoint Migration Tool installed</mark> <mark style="color:blue;">(</mark>[<mark style="color:blue;">Download it here</mark>](https://www.microsoft.com/en-us/download/details.aspx?id=54257)<mark style="color:blue;">)</mark>
* <mark style="color:yellow;">Source and target OneDrive URLs</mark>

{% hint style="success" %}
First login to onedrive in your local machine and copy the file path.
{% endhint %}

**Step 1: Install and Launch SPMT**

* <mark style="color:green;">Download and install SPMT from Microsoft.</mark>
* <mark style="color:green;">Launch the tool and sign in with your</mark> <mark style="color:green;"></mark><mark style="color:green;">**Destination onedrive account**</mark><mark style="color:green;">.</mark>

**Step 2: Select Migration Type**

* <mark style="color:green;">Click on</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Start new migration”**</mark>
* <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**“File Share”**</mark> <mark style="color:green;"></mark><mark style="color:green;">as the source (for local OneDrive data exported)</mark>

**Step 3: Prepare Source Data**

* <mark style="color:green;">Locate and select the folder where the user's OneDrive data is saved (usually under</mark> <mark style="color:green;"></mark><mark style="color:green;">`C:\Users\username\OneDrive`</mark><mark style="color:green;">)</mark>
* <mark style="color:green;">**Optional:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Copy any</mark> <mark style="color:green;"></mark><mark style="color:green;">`.pst`</mark> <mark style="color:green;"></mark><mark style="color:green;">files from Outlook if needed.</mark>

**Step 4: Set Destination**

* <mark style="color:green;">In the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Target Site URL**</mark><mark style="color:green;">, enter the</mark> <mark style="color:green;"></mark><mark style="color:green;">**OneDrive for Business URL of the destination user**</mark>\ <mark style="color:green;">Format:</mark> <mark style="color:green;"></mark><mark style="color:green;">`https://tenantname-my.sharepoint.com/personal/username_domain_com`</mark>&#x20;
* <mark style="color:green;">Or you can enter the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Destination OneDrive**</mark> <mark style="color:green;"></mark><mark style="color:green;">email account.</mark>

**Step 5: Start Migration**

* <mark style="color:green;">Confirm mapping and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Next"**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**"Migrate"**</mark>
* <mark style="color:green;">SPMT will move data from source to target OneDrive</mark>



***

## REFERENCES

* [https://learn.microsoft.com/en-us/sharepointmigration/mm-setup-clients](https://learn.microsoft.com/en-us/sharepointmigration/mm-setup-clients)
* [https://learn.microsoft.com/en-us/sharepointmigration/migrating-content-to-onedrive-for-business](https://learn.microsoft.com/en-us/sharepointmigration/migrating-content-to-onedrive-for-business)
* [https://learn.microsoft.com/en-us/sharepointmigration/mm-get-started](https://learn.microsoft.com/en-us/sharepointmigration/mm-get-started)
* [https://learn.microsoft.com/en-us/sharepointmigration/introducing-the-sharepoint-migration-tool](https://learn.microsoft.com/en-us/sharepointmigration/introducing-the-sharepoint-migration-tool)
* [https://techcommunity.microsoft.com/blog/spblog/mover-migration-now-available-worldwide/1185228](https://techcommunity.microsoft.com/blog/spblog/mover-migration-now-available-worldwide/1185228)
* [https://learn.microsoft.com/en-us/sharepointmigration/new-and-improved-features-in-the-sharepoint-migration-tool](https://learn.microsoft.com/en-us/sharepointmigration/new-and-improved-features-in-the-sharepoint-migration-tool)
