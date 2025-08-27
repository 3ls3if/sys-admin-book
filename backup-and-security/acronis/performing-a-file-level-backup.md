---
icon: file-circle-check
---

# Performing a file-level backup

## Instructions



1.  Go back to the service console (SC).

    Please select _DEVICES_ -> _All devices_ in the blue main menu on the left.

<figure><img src="../../.gitbook/assets/image (18) (1) (1).png" alt=""><figcaption></figcaption></figure>

2. In the device view select the new machine and click the "Gear" on the top right side, select Protect on the popping up menu (if the machine is not yet their, please check Activities and wait some Minutes for the system to finalize registration process)

<figure><img src="../../.gitbook/assets/image (19) (1) (1).png" alt=""><figcaption></figcaption></figure>

3. Create a new Protection plan for Backup.

<figure><img src="../../.gitbook/assets/image (20) (1) (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
**Please use the following details:**

Protection Plan name: ses-hrzps3d0o-file (If the correct vm session ID is not shown, please click the gear on top to find you actual ID.)

Backup > What to back up: Files/folders – C:\Backupfiles

Backup > Where to back up: Cloud Storage

Backup > Schedule: Daily, Monday to Friday at 12.30pm

Backup > How long to keep: By number of copies, 5 copies

Backup > Encryption: Enable, set a password (Acronis123) and select AES256

Keep all other Backup module settings on defaults

Disable all other modules (except for Backup)
{% endhint %}

<figure><img src="../../.gitbook/assets/image (21) (1) (1).png" alt=""><figcaption></figcaption></figure>

4. Once the Protection Plan has been created, run it once manually to create a backup.

