# Lab 10.5 - Endpoint Security Validation and Rollback

## Validation checklist

* Confirm the device is enrolled, checking in, and in the intended Entra ID group.
* Confirm policy assignment, filters, and Intune device status.
* Compare policy settings with local Defender, Firewall, TPM, and BitLocker state.
* Check conflicts with configuration profiles, GPO, and security baselines.
* Record timestamps, policy names, OS build, and sanitized output.

## Useful checks

Run Get-MpComputerStatus, Get-NetFirewallProfile, Get-Tpm, Get-BitLockerVolume, and Get-MpPreference in elevated PowerShell.

## Troubleshooting workflow

1. Confirm group membership and assignment filters.
2. Trigger a device sync.
3. Check Intune policy status and last check-in.
4. Review relevant Windows event logs and diagnostics.
5. Check duplicate/conflicting settings.
6. Change one variable at a time and retest.

## Rollback

Stop rollout by removing the lab assignment. Restore known-good settings. For BitLocker, preserve recovery access and use an approved suspend/decrypt procedure if required. For firewall changes, use console/out-of-band access if remote access is affected. Sync, validate, and document the outcome.

## Evidence and exercise

Store sanitized evidence only. Never commit recovery keys, credentials, tenant secrets, or unredacted production data. Simulate a policy failure and document symptom, scope, evidence, root cause, correction, rollback, and validation.
