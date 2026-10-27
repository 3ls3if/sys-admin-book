---
icon: key
---

# How to Reset the SmarterMail Administrator Password

## How to Reset the SmarterMail Administrator Password

If the SmarterMail system administrator password has been lost or forgotten, it can be reset directly on the server by editing the configuration files used by SmarterMail. This process requires **local server access** and should only be performed by an **authorized system administrator**.

SmarterMail securely stores passwords using salted cryptographic hashing rather than reversible encryption. Because of this, passwords cannot be recovered—only reset.

***

### Important Notes Before You Begin

* You **must have access to the SmarterMail server** (Windows or Linux).
* The SmarterMail service must be **stopped** before editing configuration files.
* This process resets the administrator password; it does not reveal the old one.
* Always back up configuration files before making changes.

***

### Default Administrator Password Hash

To reset the administrator password, SmarterMail allows you to replace the existing password hash with a known default value.

**Default Admin Password Hash:**

**Password: admin**

```
1000:7Zf5bDhx+pB+3pSt9bFzbnnn9uiZi25P:+esCLUvFa/lw8c1+UMk+guGeHFfQ7Asc
```

Once this hash is applied, you can log in and immediately set a new secure password.



***

### Resetting the Admin Password on Windows

#### Step 1: Stop the SmarterMail Service

1. Open **Windows Services**.
2. Locate **SmarterMail**.
3. Right-click and select **Stop**.

#### Step 2: Locate the Configuration File

Navigate to:

```
C:\Program Files (x86)\SmarterTools\SmarterMail\Service\Settings\administrators.json
```

(Some installations may store administrator settings under a `Settings` subfolder.)

#### Step 3: Edit the Admin Password Hash

1. Open `administrators.json` in a text editor such as **Notepad++** (run as Administrator).
2. Locate the administrator account entry.
3. Replace the existing password hash with the default hash listed above.
4. Save the file.

<figure><img src="../../.gitbook/assets/Screenshot 2026-01-29 at 9.16.20 PM.png" alt=""><figcaption></figcaption></figure>

#### Step 4: Restart SmarterMail

1. Return to **Windows Services**.
2. Start the **SmarterMail** service.
3. Log in to SmarterMail using the administrator account.
4. Immediately change the password to a strong, unique value.



***

## REFERENCES

* [https://portal.smartertools.com/kb/a2739/reset-administrator-username-and-password.aspx%7D](https://portal.smartertools.com/kb/a2739/reset-administrator-username-and-password.aspx%7D)
* [https://portal.smartertools.com/kb/a3718/reset-administrator-username-and-password-linux-.aspx%7D](https://portal.smartertools.com/kb/a3718/reset-administrator-username-and-password-linux-.aspx%7D)&#x20;
* [https://www.iqcomputing.com/support/articles/reset-forgotten-smartermail-password/](https://www.iqcomputing.com/support/articles/reset-forgotten-smartermail-password/)
