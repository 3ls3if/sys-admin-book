---
icon: apple
---

# Intune Policies for MacOS

### 1. **Device Configuration Profiles (Settings and Restrictions)**

#### Purpose: Configure system settings, restrict features

* **General Settings**
  * Set custom name, wallpaper
  * Configure login window preferences
  * Prevent local account creation
* **Device Restrictions**
  * Disable camera, iCloud sync, Siri, AirDrop, Bluetooth, etc.
  * Restrict app installation
  * Prevent users from modifying Wi-Fi, VPN, or proxy settings
  * Disable System Preferences access
  * Block USB drives and external media
* **Security Settings**
  * Require FileVault (disk encryption)
  * Require password after sleep or screen saver
  * Set password complexity requirements
  * Block Touch ID for login
  * Disable system diagnostics submission
* **System Preferences Restrictions**
  * Prevent access to Network, Security, or Users & Groups panes

***

### 2. **Compliance Policies**

#### Purpose: Define what makes a device "compliant"

* Require:
  * Password + complexity
  * Encryption (FileVault enabled)
  * Minimum macOS version
  * Antivirus status
  * Company Portal app installed
  * Not jailbroken/rooted
* Custom compliance messaging
* Mark as non-compliant → trigger Conditional Access (block apps/resources)

***

### 3. **App Protection Policies (MAM)**

#### Purpose: Control data access inside apps (mainly for Office apps)

* Prevent copy/paste between personal and work apps
* Require encryption for app data
* Require PIN or biometric to open apps
* Wipe corporate data if the app is inactive or the device is unenrolled
* Prevent saving to local storage

{% hint style="warning" %}
_Note: Limited to Intune-managed apps like Microsoft 365 (Word, Outlook, Excel, etc.)_
{% endhint %}

***

### 4. **App Configuration Policies**

#### Purpose: Pre-configure app settings for users

* Pre-sign-in URLs, default tenant ID (for Teams, Outlook, etc.)
* Automatically sign users into Office apps
* Block specific features within apps (e.g., signatures in Outlook)
* Set up VPN settings for apps

***

### 5. **Shell Script Deployment**

#### Purpose: Push custom scripts to Macs for extra control

* Remove admin rights from user
* Configure system preferences
* Block USB storage
* Set proxy settings
* Disable terminal or system processes
* Modify plist files or local configuration files

***

### 6. **Endpoint Security Policies**

#### Purpose: Harden the OS and ensure security posture

* **Antivirus (if 3rd party installed like SentinelOne, CrowdStrike)**
* **Disk Encryption (FileVault)**
  * Enable and escrow recovery keys
  * Require for compliance
* **Firewall Settings**
  * Enable macOS firewall
  * Configure incoming/outgoing rules
* **Attack Surface Reduction**
  * Configure system integrity protection
  * Block sharing features

***

### 7. **Conditional Access Policies (via Azure AD)**

#### Purpose: Control access to company resources based on device compliance

* Only allow access if:
  * Device is compliant
  * Device is Intune-enrolled
  * Device is from a known location
* Block access to:
  * Outlook
  * SharePoint
  * Teams
  * Other SaaS apps (Salesforce, Dropbox, etc.)

***

### 8. **Application Deployment Policies**

#### Purpose: Install apps silently or on-demand

* **VPP Apps (Apple Business Manager)**
  * Microsoft 365
  * Company Portal
  * Antivirus
* **.pkg file uploads**
  * Custom apps
  * CLI tools
* **App install behavior**
  * Required or available
  * Install during check-in
  * Notify on install or silent

***

### 9. **Enrollment Profiles**

#### Purpose: Control user experience during device setup

* Create standard user during setup (no admin rights)
* Skip Setup Assistant screens (Apple ID, Siri, etc.)
* Lock MDM enrollment (cannot remove)
* Assign profiles to ADE-enrolled devices



***

## REFERENCES

* [https://www.anoopcnair.com/device-restriction-settings-offered-by-intune/](https://www.anoopcnair.com/device-restriction-settings-offered-by-intune/)
* [https://www.stanfieldit.com/microsoft-intune-features/](https://www.stanfieldit.com/microsoft-intune-features/)
