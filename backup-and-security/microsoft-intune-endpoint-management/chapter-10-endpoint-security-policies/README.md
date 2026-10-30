---
icon: building-shield
---

# Endpoint Security Policies

This chapter covers Windows endpoint security controls managed through Microsoft Intune.

## Objectives

* Understand endpoint security policy architecture.
* Configure Defender Antivirus, Windows Firewall, BitLocker, and Attack Surface Reduction (ASR).
* Validate policy delivery and local device state.
* Troubleshoot conflicts and safely roll back changes.

## Prerequisites and licensing

Use an appropriately licensed Intune tenant, supported enrolled Windows 10/11 test device, policy-authoring permissions, and a dedicated Entra ID group such as SG-Intune-EndpointSecurity-Lab. Confirm the exact Windows and Defender licensing required for the features being tested. Advanced EDR capabilities may require Defender for Endpoint licensing.

## Architecture

Intune stores policies and assignments. Windows MDM delivers supported settings; Defender components and Windows security subsystems enforce them. Defender for Endpoint integration can provide additional telemetry and response capabilities when licensed and onboarded.

## Lab policies

* ES-10-WIN-Defender-Antivirus-Lab
* ES-10-WIN-Firewall-Lab
* ES-10-WIN-BitLocker-Lab
* ES-10-WIN-ASR-Audit-Lab

## Safety and rollback

Use a disposable test VM and pilot group. Avoid overlapping settings from endpoint security policies, configuration profiles, GPO, and security baselines. Verify remote access before firewall changes. Confirm BitLocker recovery-key escrow before encryption. Start ASR rules in Audit mode. Remove the test assignment and restore known-good settings if a policy causes an issue.

## Lab pages

Continue with the separate Defender Antivirus, Firewall, BitLocker, ASR, and validation pages below.

## References

[Endpoint security policies](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-policy) · [Defender Antivirus](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-antivirus-policy) · [Disk encryption](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-disk-encryption-policy) · [ASR](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-policy)
