---
icon: arrow-up-to-line
---

# Import PST to Exchange Online (Microsoft O365)

## Preparing for the Import

Before you embark on the **PST to Office 365 migration** journey, it's essential to lay the groundwork. Here are some key steps to prepare for a successful import:

1. <mark style="color:green;">**Identify Your PST Files:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Locate the PST files that you want to transfer to Office 365. These files might be stored on your local computer, network drives, or external storage devices.</mark>
2. <mark style="color:green;">**Check File Size and Content:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Assess the size and complexity of your PST files. Large files or those containing complex structures may require specialized migration tools or additional planning.</mark>
3. <mark style="color:green;">**Plan Your Import Strategy:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Decide where you want to import the PST data within your Office 365 tenant. You can choose individual mailboxes, shared folders, or specific locations based on your organization's structure. Consider factors like user permissions, data security, and compliance requirements when making this decision.</mark>

By following these steps, you'll ensure a smooth and efficient **PST to Office 365 migration** process.

## Network Upload Method to Import PST to Office 365

### Prerequisites

* <mark style="color:green;">**Office 365 admin access**</mark> <mark style="color:green;"></mark><mark style="color:green;">with the required permissions.</mark>
* <mark style="color:green;">**Azure AzCopy Tool**</mark> <mark style="color:green;"></mark><mark style="color:green;">installed to facilitate PST uploads.</mark>
* <mark style="color:green;">**PST file(s)**</mark> <mark style="color:green;"></mark><mark style="color:green;">prepared and located in a network folder.</mark>

### Step 1: Assign Mailbox Import Export Role

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Office 365 Admin Center**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Exchange Admin Center**</mark> <mark style="color:green;"></mark><mark style="color:green;">(EAC).</mark>
3. <mark style="color:green;">Navigate to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Permissions**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Admin Roles**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Select the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Mailbox Import Export**</mark> <mark style="color:green;"></mark><mark style="color:green;">role or create a new role group if needed.</mark>
5. <mark style="color:green;">Add your user account to the role.</mark>

### Step 2: Download and Install Azure AzCopy Tool

1. <mark style="color:green;">Download the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Azure AzCopy**</mark> <mark style="color:green;"></mark><mark style="color:green;">tool from Microsoft's official website.</mark>
2. <mark style="color:green;">Install the tool on your computer.</mark>

### Step 3: Create the Import Job in Office 365

1. <mark style="color:green;">In the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Microsoft 365 Admin Center**</mark><mark style="color:green;">, go to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Compliance Admin Center**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Navigate to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Information Governance**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Import**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**+New Import Job**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Name the job and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">.</mark>

### Step 4: Upload PST Files to Microsoft 365 Using AzCopy

1. <mark style="color:green;">Download the</mark> <mark style="color:green;"></mark><mark style="color:green;">**SAS URL**</mark> <mark style="color:green;"></mark><mark style="color:green;">(Shared Access Signature URL) provided by Office 365 in the Import Job Wizard.</mark>
2. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Command Prompt**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**PowerShell**</mark> <mark style="color:green;"></mark><mark style="color:green;">with admin rights.</mark>
3. <mark style="color:green;">Use the following command to upload your PST file:</mark>

```powershell
AzCopy.exe /Source:"C:\PathToYourPSTFile" /Dest:"https://<SAS URL>" /V:"C:\logfile.log"

OR

azcopy.exe copy "\\FILESERVER1\PSTs" "https://3c3e5952a2764023ad14984.blob.core.windows.net/ingestiondata?sv=2012-02-12&amp;se=9999-12-31T23%3A59%3A59Z&amp;sr=c&amp;si=IngestionSasForAzCopy201601121920498117&amp;sig=Vt5S4hVzlzMcBkuH8bH711atBffdrOS72TlV1mNdORg%3D"
```

1. <mark style="color:green;">Monitor the upload progress, and once done, verify that the upload is successful.</mark>

### Step 5: Map PST Files to User Mailboxes

1. <mark style="color:green;">After the upload is complete, return to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Import Job Wizard**</mark> <mark style="color:green;"></mark><mark style="color:green;">in the Compliance Admin Center.</mark>
2. <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**I have uploaded my files**</mark> <mark style="color:green;"></mark><mark style="color:green;">and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Download the</mark> [<mark style="color:red;">**PST Mapping Template**</mark>](https://go.microsoft.com/fwlink/p/?LinkId=544717) <mark style="color:green;">(a CSV file) provided by Microsoft.</mark>
4. <mark style="color:green;">Fill in the necessary fields in the CSV file, including:</mark>

* <mark style="color:orange;">**Workload**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">(Mailbox).</mark>
* <mark style="color:orange;">**FilePath**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">(Location of the uploaded PST file).</mark>
* <mark style="color:orange;">**Mailbox**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">(User's email address to map the PST).</mark>
* <mark style="color:orange;">**TargetRootFolder**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">(Specify the folder in which to import the PST).</mark>
* <mark style="color:orange;">**IsArchive**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">(whether to import into archive mailboxes).</mark>

```
# CSV FILE FORMAT

Workload,FilePath,Name,Mailbox,IsArchive,TargetRootFolder,ContentCodePage,SPFileContainer,SPManifestContainer,SPSiteUrl
Exchange,,annb.pst,annb@contoso.onmicrosoft.com,FALSE,/,,,,
Exchange,,annb_archive.pst,annb@contoso.onmicrosoft.com,TRUE,,,,,
```

### Step 6: Validate the CSV File and Start the Import

1. <mark style="color:green;">Upload the filled-out CSV file to the Import Job.</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Validate**</mark> <mark style="color:green;"></mark><mark style="color:green;">to check for any issues with the mapping.</mark>
3. <mark style="color:green;">Once validated successfully, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**Import data to mailboxes**</mark> <mark style="color:green;"></mark><mark style="color:green;">and review the settings.</mark>
5. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Finish**</mark> <mark style="color:green;"></mark><mark style="color:green;">to start the import.</mark>

### Step 7: Monitor the Import Job

1. <mark style="color:green;">You can monitor the status of the import in the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Import**</mark> <mark style="color:green;"></mark><mark style="color:green;">tab of the Compliance Admin Center.</mark>
2. <mark style="color:green;">Once the import is completed, verify the content by accessing the users' mailboxes.</mark>

{% hint style="success" %}
This completes the process of importing PST files to Office 365 using the Network Upload method.
{% endhint %}





***

## REFERENCES

* [https://www.linkedin.com/pulse/import-pst-office-365-comprehensive-guide-seamless-data-jha-malnf/](https://www.linkedin.com/pulse/import-pst-office-365-comprehensive-guide-seamless-data-jha-malnf/)
* [https://www.linkedin.com/pulse/exchange-online-pst-import-made-simple-pradeep-katiyar-gf5if/](https://www.linkedin.com/pulse/exchange-online-pst-import-made-simple-pradeep-katiyar-gf5if/)
* [https://learn.microsoft.com/en-us/purview/importing-pst-files-to-office-365](https://learn.microsoft.com/en-us/purview/importing-pst-files-to-office-365)
* [https://learn.microsoft.com/en-us/purview/use-network-upload-to-import-pst-files](https://learn.microsoft.com/en-us/purview/use-network-upload-to-import-pst-files)
