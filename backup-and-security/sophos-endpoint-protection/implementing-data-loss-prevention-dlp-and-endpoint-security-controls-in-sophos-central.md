---
icon: database
---

# Implementing Data Loss Prevention (DLP) and Endpoint Security Controls in Sophos Central

## Implementing Data Loss Prevention (DLP) and Endpoint Security Controls in Sophos Central

Organizations today face increasing risks related to unauthorized data transfers, removable media usage, risky applications, and non-business internet activity. To strengthen endpoint security and reduce the risk of data leakage, a layered security approach was implemented using Sophos Central and Sophos Intercept X Advanced.

This article explains the complete configuration implemented for Data Loss Prevention (DLP), USB control, web filtering, and application restriction within the Sophos environment, along with the exact configuration steps followed.

***

## 1. Peripheral Control (USB & Device Control)

One of the most common methods of data leakage is through removable storage devices such as USB drives and external hard disks. To address this, a strict peripheral control policy was implemented.

### Configuration Summary

#### Blocked Devices

* Removable storage devices
* MTP/PTP devices

#### Allowed Devices

* Bluetooth
* Camera
* Optical drives
* Wireless devices
* Floppy drives
* Infrared devices
* Modems

### Security Outcome

* USB storage devices are blocked by default for all users
* Unauthorized file copying to external devices is restricted
* Approved devices can be allowed through exemptions

***

## Steps to Configure Peripheral Control

### Step 1: Open Sophos Central

Login to Sophos Central Admin Portal.

***

### Step 2: Navigate to Device Control

Go to:

```
Endpoint Protection → Policies → Peripheral Control
```

***

### Step 3: Create a New Policy

Click:

```
Add Policy
```

Policy Name:

```
USB Restriction Policy
```

***

### Step 4: Configure Peripheral Types

#### Set the following to BLOCK:

* Removable storage
* MTP/PTP

#### Set the following to ALLOW:

* Bluetooth
* Camera
* Optical drive
* Wireless
* Floppy drive
* Infrared
* Modem

***

### Step 5: Save and Assign Policy

* Save the policy
* Assign to:
  * All users/devices

***

### Step 6: Configure Authorized Devices (Optional)

Go to:

```
Global Settings → Peripheral Exemptions
```

Add:

* Device Serial Number
* Vendor ID
* Hardware ID

Assign exemptions to authorized users/devices.

***

## 2. Application Control

Application Control helps prevent unauthorized or risky software from running on endpoints.

### Blocked Application Categories

* Download managers
* File-sharing applications
* Games
* Jailbreak software
* FTP clients
* Telnet clients
* Selected system tools

### Security Outcome

* Games and unauthorized software are blocked
* File-sharing applications are restricted
* Risky utilities are controlled

***

## Steps to Configure Application Control

### Step 1: Navigate to Application Control

Go to:

```
Endpoint Protection → Policies → Application Control
```

***

### Step 2: Create Policy

Click:

```
Add Policy
```

Policy Name:

```
Application Restriction Policy
```

***

### Step 3: Select Application Categories

Enable blocking for:

* Download managers
* File sharing applications
* Games
* Jailbreak software
* FTP clients
* Telnet clients
* System tools (partial)

***

### Step 4: Enable Detection Option

Enable:

```
Block detected applications when users access them
```

***

### Step 5: Save and Assign

* Save policy
* Assign to required users/devices

***

## 3. Web Control

Web Control helps prevent access to malicious, risky, or non-productive websites.

### Blocked Categories

* Social networking
* Adult content
* Gaming
* Risky downloads
* File-sharing websites
* High-bandwidth sites

### Security Outcome

* Non-work-related browsing is reduced
* Risky websites are restricted
* Productivity is improved

***

## Steps to Configure Web Control

### Step 1: Navigate to Web Control

Go to:

```
Endpoint Protection → Policies → Web Control
```

***

### Step 2: Create New Policy

Click:

```
Add Policy
```

Policy Name:

```
Restricted Web Access
```

***

### Step 3: Configure Categories

#### Set to BLOCK:

* Social networking
* Adult & inappropriate
* Excessive bandwidth
* Gaming
* File sharing
* Risky downloads

#### Set to ALLOW:

* Business-related websites

#### Set Productivity Categories:

* Custom (based on business requirements)

***

### Step 4: Save and Assign

* Save policy
* Assign to users/devices

***

### Step 5: Configure HTTPS Inspection (Optional)

Go to:

```
Endpoint Protection → Policies → Threat Protection
```

Enable:

* HTTPS Decryption

This allows Sophos to inspect encrypted traffic for Web Control enforcement.

***

## 4. Data Loss Prevention (DLP)

A DLP policy named **“DLP India”** was created to monitor and control sensitive information transfers.

***

## DLP Detection Method

The current DLP implementation is based on:

* File content inspection
* Confidential document markers
* Strong confidential phrases

The policy is **not based on file extensions or file types**.

***

## Configured Detection Markers

* Confidential document markers \[India]
* Restricted confidential markers \[India]
* Universal control markers
* Strong phrase-based markers

***

## Monitored Channels

* Email clients
* Web browsers
* Browser external processes
* Instant messaging
* Voice over IP
* Removable storage

***

## Configured Action

Current action:

```
Allow transfer after user confirmation
```

Users receive a warning before transferring sensitive data.

***

## Steps to Configure DLP

### Step 1: Navigate to DLP

Go to:

```
Endpoint Protection → Policies → Data Loss Prevention
```

***

### Step 2: Create New DLP Rule

Click:

```
Add Policy
```

Policy Name:

```
DLP India
```

***

### Step 3: Configure Conditions

Enable:

* Confidential document markers \[India]
* Confidential document markers restricted \[India]
* CTRL:X / CTRL:XX / CTRL:XXX markers
* Strong phrase confidential markers

***

### Step 4: Configure Channels

Enable monitoring for:

* Email client
* Internet browser
* Browser external processes
* Instant messaging
* Voice over IP
* Removable storage

***

### Step 5: Configure Action

Set action to:

```
Allow transfer if user confirms
```

Optional alternatives:

* Block transfer
* Log only

***

### Step 6: Save and Assign Policy

* Save policy
* Assign to required endpoints/users

***

## File Content DLP vs File Type DLP

The current DLP policy works using **content inspection** rather than file extensions.

### Current Implementation

Sophos scans:

* Sensitive phrases
* Confidential markers
* Internal document indicators

This means:

* A confidential PDF, DOCX, or TXT file can still trigger DLP if sensitive content exists.

***

## Optional File Type DLP

If file-type-based restrictions are required, Sophos policies can be customized to block or allow specific file formats such as:

* PDF
* DOCX
* XLSX
* ZIP
* PST
* CAD files

To configure file-type DLP properly, organizations should define:

* Which file types must be blocked
* Which file types are allowed
* Which users/departments need exceptions

***

## Known Limitation of Intercept X Advanced

Sophos Intercept X Advanced provides practical DLP-related controls but does not include advanced enterprise DLP features such as:

* Regex matching
* File fingerprinting
* Exact data matching
* Advanced keyword analysis

For advanced DLP requirements, organizations may consider:

* Sophos DLP add-on
* Microsoft Purview DLP integration

***

## Best Practices After Deployment

### 1. Monitor Before Full Enforcement

Run policies in monitoring/warning mode before applying strict blocking.

***

### 2. Test DLP Rules

Use sample confidential documents to validate detection accuracy.

***

### 3. Maintain Device Exemptions

Review authorized USB devices regularly.

***

### 4. Review Web Policies

Adjust productivity categories as business needs evolve.

***

### 5. Conduct User Awareness Training

Educate employees about:

* USB restrictions
* DLP alerts
* Acceptable internet usage

***

## Conclusion

The implemented Sophos configuration establishes a strong baseline for endpoint protection and practical Data Loss Prevention using layered security controls.

By combining:

* Peripheral Control
* Application Control
* Web Filtering
* DLP Monitoring
* Controlled Data Transfers

organizations can significantly reduce the risk of unauthorized data leakage and strengthen endpoint governance.

Although full enterprise DLP capabilities may require additional licensing or third-party integration, the current implementation provides an effective and manageable security framework suitable for many business environments.
