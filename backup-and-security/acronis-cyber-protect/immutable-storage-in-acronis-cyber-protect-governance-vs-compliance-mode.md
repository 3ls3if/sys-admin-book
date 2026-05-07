---
icon: swap
---

# Immutable Storage in Acronis Cyber Protect: Governance vs Compliance Mode

## Immutable Storage in Acronis Cyber Protect: Governance vs Compliance Mode

Immutable storage in [Acronis Cyber Protect](https://www.acronis.com/en-us/products/cyber-protect/?utm_source=chatgpt.com) protects backup data from ransomware, accidental deletion, and malicious tampering. Once enabled, backups stored in immutable storage cannot be altered or permanently deleted until the configured retention period expires.

This feature is available for environments using [Acronis Cyber Infrastructure](https://www.acronis.com/en-us/products/cyber-infrastructure/?utm_source=chatgpt.com) as the storage backend.

***

### Why Immutable Storage Matters

Cyberattacks increasingly target backup repositories to prevent organizations from recovering their data. Immutable storage adds an additional security layer by ensuring that backup copies remain protected even if administrative credentials are compromised.

Immutable storage helps organizations:

* Protect backups from ransomware attacks
* Prevent accidental or unauthorized deletion
* Preserve backup integrity for disaster recovery
* Meet compliance and regulatory retention requirements
* Improve cyber resilience and business continuity

***

### Prerequisites

Before enabling immutable storage, ensure the following requirements are met:

* You have administrator privileges in the Cyber Protect console.
* An Acronis Cyber Infrastructure storage node is configured.
* For cloud deployments, two-factor authentication (2FA) is required.
* If upgrading to Acronis Cyber Protect 16 from an earlier version on Windows, update the Account Server certificate before enabling immutable storage.

***

## Enabling Immutable Storage

### On-Premises Deployment

To enable immutable storage in an on-premises environment:

1. Log in to the Cyber Protect console as an administrator.
2. Navigate to **Settings > Storage node**.
3. Select the required Acronis Cyber Infrastructure storage node.
4. Click **Immutable storage settings**.
5. Enable the **Immutable storage** switch.
6. Click **Enable**.
7. Specify a retention period between **14 and 3650 days**.
8. Select the immutable storage mode:
   * Governance mode
   * Compliance mode
9. Confirm your selection.
10. Click **Close**.

> The default retention period is 14 days. Longer retention periods increase storage consumption.

***

### Cloud Deployment

In cloud deployments, enabling immutable storage follows the same process, with an additional security requirement:

* Two-factor authentication (2FA) must be enabled and verified before changing immutable storage settings.

***

## Immutable Storage Modes

Acronis Cyber Protect provides two immutable storage modes designed for different operational and regulatory needs.

***

### Governance Mode

Governance mode protects backups from ransomware and unauthorized deletion while still allowing administrative flexibility.

#### Key Features

* Deleted backups remain protected during the retention period
* Backup integrity is preserved
* Suitable for operational security and disaster recovery
* Administrators can:
  * Disable and re-enable immutable storage
  * Modify retention periods
  * Switch to Compliance mode later

#### Best Use Cases

Governance mode is recommended for organizations that need strong backup protection while maintaining administrative control and flexibility.

***

### Compliance Mode

Compliance mode provides the highest level of backup immutability and is designed for organizations with strict regulatory or legal data retention requirements.

#### Key Features

* Prevents backup tampering or deletion
* Ensures retention policies cannot be bypassed
* Supports regulatory compliance and audit requirements
* Protects against malicious or accidental administrative actions

#### Important Limitation

> Enabling Compliance mode is irreversible.

After Compliance mode is enabled:

* Immutable storage cannot be disabled
* Retention periods cannot be modified
* Switching back to Governance mode is not possible

#### Best Use Cases

Compliance mode is ideal for industries with strict retention regulations, such as:

* Healthcare
* Financial services
* Government
* Legal services

***

## Adding Existing Archives to Immutable Storage

To protect an existing archive with immutable storage:

1. Enable immutable storage on the storage node.
2. Run a new backup manually or wait for the scheduled protection plan to execute.

The new backup operation adds the archive to immutable storage protection.

> If backups were deleted before the archive was added to immutable storage, those backups are permanently removed and cannot be recovered.

***

## Best Practices

To maximize protection and storage efficiency:

* Use Governance mode for general ransomware protection
* Use Compliance mode only when strict regulatory controls are required
* Carefully plan retention periods to balance compliance and storage usage
* Enable multi-factor authentication for all administrators
* Regularly test backup recovery procedures

***

## Conclusion

Immutable storage in Acronis Cyber Protect strengthens backup security by preventing backup deletion and tampering. Organizations can choose between the flexible Governance mode or the irreversible Compliance mode depending on operational and compliance requirements.

By combining immutable storage with strong authentication and regular recovery testing, organizations can significantly improve resilience against ransomware and data loss incidents.



***

## REFERENCES

* [https://www.acronis.com/en/support/documentation/AcronisCyberProtect\_16/index.html#enabling-immutable-storage.html?TocPath=Advanced%20storage%20options%7CImmutable%20storage%7C\_\_\_\_\_3](https://www.acronis.com/en/support/documentation/AcronisCyberProtect_16/index.html#enabling-immutable-storage.html?TocPath=Advanced%20storage%20options%7CImmutable%20storage%7C_____3)
* [https://care.acronis.com/s/article/71557-Acronis-Cyber-Protect-Cloud-Compliance-mode-for-immutable-storage?language=en\_US](https://care.acronis.com/s/article/71557-Acronis-Cyber-Protect-Cloud-Compliance-mode-for-immutable-storage?language=en_US)
