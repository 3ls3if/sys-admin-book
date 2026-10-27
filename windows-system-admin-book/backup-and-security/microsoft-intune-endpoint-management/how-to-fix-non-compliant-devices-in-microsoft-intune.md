---
icon: octagon-check
---

# How to Fix Non-Compliant Devices in Microsoft Intune

## How to Fix Non-Compliant Devices in Microsoft Intune

Microsoft Intune helps organizations manage and secure corporate devices by enforcing security and compliance policies. When a device does not meet one or more configured requirements, Intune marks it as **Non-Compliant**.

A non-compliant device may be restricted from accessing corporate resources depending on the organization's Conditional Access policies. Therefore, identifying and resolving compliance issues at the endpoint is an important part of maintaining a secure IT environment.

In this blog, we will understand why devices become non-compliant in Microsoft Intune and how end users can troubleshoot and restore their devices to a **Compliant** state.

### What Does "Non-Compliant" Mean in Microsoft Intune?

A device is marked as **Non-Compliant** when it fails to meet one or more requirements defined in an Intune compliance policy.

Common compliance requirements include:

* Device encryption must be enabled.
* Windows security updates must be installed.
* Antivirus protection must be enabled.
* Microsoft Defender must meet the organization's security requirements.
* A secure password or PIN must be configured.
* The device must meet the required operating system version.
* The device must be actively managed by Intune.
* Other organization-specific security requirements must be satisfied.

The exact reason for non-compliance depends on the compliance policies configured by the organization's Intune administrator.

### Why Is Device Compliance Important?

Device compliance provides an additional security layer for corporate environments.

For example, an organization can configure a policy requiring:

**Windows Device → Encryption Enabled → Antivirus Enabled → Security Updates Installed → Compliant**

Conditional Access can then use this compliance status when determining whether a user or device should be allowed to access organizational resources.

This helps organizations reduce the risk of compromised or unsecured devices accessing corporate data.

### How to Check the Compliance Status

Users can check their device status through the **Company Portal** application.

#### Step 1: Open Company Portal

Open **Company Portal** on the affected Windows computer and sign in using the organization's Microsoft 365 account.

#### Step 2: Open Devices

Navigate to the **Devices** section and select the affected computer.

The device should display its current compliance status.

If the device is marked **Non-Compliant**, Company Portal may provide additional information about the requirement that needs to be addressed.

### How to Synchronize the Device with Intune

Sometimes a device has already been remediated but Intune has not yet received the updated status.

In such cases, manually synchronizing the device can help.

#### Method 1: Sync from Windows Settings

On the affected computer:

**Settings → Accounts → Access work or school**

Select the organizational account connected to Intune and click:

**Info → Sync**

Windows will then initiate a synchronization with the organization's management service.

#### Method 2: Sync from Company Portal

Open **Company Portal**, select the affected device, and use the available **Sync** option.

This allows the device to communicate with Intune and retrieve the latest policies.

### Restart the Computer

After performing a synchronization, restart the computer.

A restart can be useful when the compliance requirement involves:

* Windows updates
* Security services
* Encryption
* Device configuration
* Security policies
* System-level settings

After restarting, allow some time for the device to synchronize and for Intune to re-evaluate its compliance status.

### Common Non-Compliance Issues

#### 1. Pending Windows Updates

A device may become non-compliant if the organization requires a specific Windows version or security patch level.

Check:

**Settings → Windows Update**

Install all required updates and restart the computer if prompted.

After the update process is completed, synchronize the device with Intune.

#### 2. BitLocker or Device Encryption Is Disabled

If the organization's compliance policy requires encryption, the device may be marked as non-compliant when encryption is disabled.

Check the organization's required encryption settings and enable BitLocker/device encryption where applicable.

> Note: Encryption should be enabled according to the organization's security policy and recovery-key management requirements.

#### 3. Antivirus or Microsoft Defender Is Disabled

An Intune compliance policy may require antivirus protection to be active.

Check:

**Windows Security → Virus & threat protection**

Ensure that the required security protection is enabled.

If the organization uses a third-party endpoint security product, verify that it is correctly configured and recognized according to the organization's Intune policy.

#### 4. Password or PIN Requirements

The compliance policy may require specific authentication requirements, such as:

* Minimum password length
* Password complexity
* Windows Hello PIN
* Device lock requirements

Review the compliance details shown in Company Portal and configure the required authentication method.

#### 5. Unsupported or Outdated Windows Version

Organizations may define a minimum supported Windows version.

If the endpoint is running an outdated version, it may fail the compliance check.

Update the operating system to the version required by the organization's policy.

#### 6. Device Has Not Recently Synced

A device can sometimes continue showing an old compliance status because it has not communicated with Intune recently.

In this situation:

1. Open **Company Portal**.
2. Select the device.
3. Perform a **Sync**.
4. Open Windows Settings.
5. Navigate to **Access work or school**.
6. Select the organizational account.
7. Click **Info → Sync**.
8. Restart the device.
9. Wait for Intune to re-evaluate the device.

### Recommended Troubleshooting Workflow

A simple troubleshooting process can be followed:

```
Check Intune Compliance Status
          ↓
Open Company Portal
          ↓
Identify Failed Requirement
          ↓
Perform Required Remediation
          ↓
Sync Device
          ↓
Restart Computer
          ↓
Sync Again
          ↓
Intune Re-Evaluates Device
          ↓
Check Compliance Status
          ↓
     COMPLIANT
```

This approach helps determine whether the issue is related to the endpoint configuration or simply a synchronization/evaluation delay.

### What If the Device Is Still Non-Compliant?

If the device remains non-compliant after completing the required remediation, do not repeatedly change unrelated settings.

Instead, review the exact compliance failure.

The Intune administrator should check:

* Which compliance policy is failing
* Which individual setting failed
* Last check-in time
* Device ownership
* User assignment
* Compliance policy assignment
* Configuration policy conflicts
* Device registration/enrollment status
* Conditional Access requirements
* Any applicable device restrictions

The end user should provide the **exact compliance error or failed requirement** shown in Company Portal to the IT administrator.

This information can significantly reduce troubleshooting time.

### Best Practices for Intune Device Compliance

Organizations should consider the following best practices:

#### Regularly Monitor Non-Compliant Devices

Intune administrators should regularly review devices marked as non-compliant and prioritize remediation based on business and security requirements.

#### Keep Windows Updated

Ensure that endpoints receive security and quality updates according to the organization's patch-management policy.

#### Enforce Encryption

Use encryption policies to protect corporate information in case a device is lost or stolen.

#### Maintain Endpoint Protection

Ensure that antivirus, endpoint detection, and other security controls remain active and properly configured.

#### Educate End Users

Users should understand that compliance requirements are security controls rather than optional settings.

Providing users with clear remediation instructions can reduce the workload on the IT support team.

### Conclusion

Microsoft Intune device compliance is an important component of modern endpoint security. A device marked as **Non-Compliant** does not necessarily mean that there is a serious system failure. In many cases, the issue can be resolved by addressing the failed requirement, synchronizing the device, and allowing Intune to re-evaluate its status.

The recommended approach is:

**Identify → Remediate → Sync → Restart → Re-evaluate → Confirm Compliance**

If the device continues to show as non-compliant, the Intune administrator should review the specific compliance policy and failed requirement rather than making unnecessary changes to the endpoint.

By regularly monitoring compliance and promptly resolving failed requirements, organizations can maintain a more secure and controlled Windows endpoint environment.
