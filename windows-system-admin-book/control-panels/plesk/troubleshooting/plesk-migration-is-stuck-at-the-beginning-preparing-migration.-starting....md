---
icon: briefcase
---

# Plesk migration is stuck at the beginning: Preparing migration. Starting...

## Symptoms

*   Migration is stuck at the following stage:

    Preparing migration\
    Starting...
*   In an attempt to access some Plesk folders, e.g. `%plesk_dir%\admin\bin\`, on the destination server under the Administrator account, the UAC (User Account Control) pop-up window appears:

    You don't currently have permission to access this folder. Click Continue to permanently get access to this folder.
* In an attempt to reload source data via command line the next error occurs:

```
"%plesk_dir%\admin\plib\modules\panel-migrator\backend\plesk-migrator.bat" generate-migration-list "%plesk_dir%/var/modules/panel-migrator/sessions/20170906170318/config.ini" --migration-list-format=json --migration-list-file="%plesk_dir%/var/modules/panel-migrator/sessions/20170906170318\migration-list-raw.json" --skip-services-checks --include-existing-subscriptions --overwrite --reload-source-data

[INFO] Initialize Plesk Migrator
[INFO] Target Plesk host: 203.0.113.2
[ERROR] Internal Plesk Migrator error: '[Errno 13] Permission denied: u'C:\\Program Files (x86)\\Plesk\\version'', migration is aborted. See the traceback in debug log for more information.
```

### Cause

Due to the enabled **User Account Control: Admin Approval Mode for the built-in Administrator account** policy, Plesk Migrator privileges elevation attempts are blocked.

This is a Plesk bug **PMT-3847** which is planned to be fixed in future product updates.

***

## Resolution

1. Connect to the server via [RDP](https://plesk-new.zendesk.com/hc/en-us/articles/12377247797271).
2. Modify the security policy:

### **If the server is not in domain**

1. [Open Command Prompt](https://plesk-new.zendesk.com/hc/en-us/articles/12377222144023-How-to-start-a-command-prompt-as-an-Administrator).
2.  Open Local Security Policy:

    secpol.msc
3. Navigate to **Security Settings > Local Policies > Security Options**
4. Double-click on the **User Account Control: Admin Approval Mode for the built-in Administrator** policy, select the **Disabled** option and click on the **OK** button:

### If the server is in domain

1. [Open Command Prompt](https://plesk-new.zendesk.com/hc/en-us/articles/12377222144023-How-to-start-a-command-prompt-as-an-Administrator).
2. Enter **gpedit.msc** and press the **Enter** button
3. Navigate the console tree to **Local Computer Policy\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**
4. Double-click on the **User Account Control: Admin Approval Mode for the built-in Administrator** policy, select the **Disabled** option and click on the **OK** button
5. Go back to [Command Prompt](https://plesk-new.zendesk.com/hc/en-us/articles/12377222144023-How-to-start-a-command-prompt-as-an-Administrator) and apply updated policy by executing the following command:

```
gpupdate

Updating policy...

Computer Policy update has completed successfully.
User Policy update has completed successfully.
```



***

## REFERENCES

* [https://support.plesk.com/hc/en-us/articles/12377463490327-Plesk-migration-is-stuck-at-the-beginning-Preparing-migration-Starting](https://support.plesk.com/hc/en-us/articles/12377463490327-Plesk-migration-is-stuck-at-the-beginning-Preparing-migration-Starting)
