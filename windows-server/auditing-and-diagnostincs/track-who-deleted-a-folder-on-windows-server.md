---
icon: trash-can-list
---

# Track Who Deleted a Folder on Windows Server

## Track Who Deleted a Folder on Windows Server

### 1. **Ensure Audit Object Access Is Enabled**

On the system where the folder existed:

1. Open **Group Policy Editor** (`gpedit.msc`)
2.  Navigate to:

    ```
    Computer Configuration > Windows Settings > Security Settings > Local Policies > Audit Policy
    ```
3. Enable:
   * **Audit object access** (Set to **Success** and **Failure**)
4. Run `gpupdate /force` in Command Prompt to apply changes.

{% hint style="warning" %}
Note: This must have been enabled **before** the deletion to capture the event.
{% endhint %}



### 2. **Set Auditing on the Specific Folder**

(Only works if set before the deletion)

1. Right-click the folder `Test Folder` → **Properties**
2. Go to **Security > Advanced > Auditing**
3. Add an audit entry for:
   * **Everyone** or specific users
   * **Delete** and **Delete Subfolders and Files**



### **3. Check the Event Viewer Logs**

1. Open **Event Viewer** (`eventvwr.msc`)
2.  Go to:

    ```
    Windows Logs > Security
    ```
3. Look for:
   * **Event ID 4660** – Object deleted
   * **Event ID 4656** – Access attempt (including delete)
   * **Event ID 4663** – Access to an object (file/folder)
4.  Use filters or search for keywords like:

    ```
    Test Folder
    ```
5. The **“Subject”** field shows which **user** performed the deletion.



{% hint style="danger" %}
#### If Auditing Was Not Enabled Before

Unfortunately, if auditing wasn’t enabled **before** the folder was deleted, **you won’t be able to see who deleted it using built-in logs**.
{% endhint %}



{% hint style="warning" %}
#### Alternative Options

* **Check backup software logs** (if used)
* **Check logs on FTP servers or file sync apps**, if this folder was accessed via those
* Use third-party tools like:
  * **ManageEngine FileAudit Plus**
  * **Netwrix Auditor**
  * **LepideAuditor**
{% endhint %}

