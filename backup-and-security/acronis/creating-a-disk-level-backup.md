---
icon: album
---

# Creating a disk-level backup

## Instructions



1.  Go back to the service console (SC).

    Please select _DEVICES_-> _All devices_ in the blue main menu on the left.
2. In the device view select the new machine and select _Protect_ on the right popping up menu.

<figure><img src="../../.gitbook/assets/image (22) (1) (1).png" alt=""><figcaption></figcaption></figure>

3. Create a new Protection plan for Backup.

{% hint style="warning" %}
**Please use the following details:**



Protection Plan name: ses-hrzps3d0o-disk (_If the correct vm session ID is not shown, please click the gear on top to find you actual ID.)_

Backup > What to back up: Disk 1 (which contains both System Reserved and C volume)

Backup > Where to back up: Cloud Storage

Backup > Schedule: Daily, Monday to Friday at 12.30pm

Backup > How long to keep: By backup age, single rule, 6 month

Backup > Encryption: Enable, set a password (_Acronis123_) and select AES256

Keep all other Backup module settings on defaults

Disable all other modules (except for Backup)
{% endhint %}

<figure><img src="../../.gitbook/assets/image (23) (1).png" alt=""><figcaption></figcaption></figure>

