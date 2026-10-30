# Lab 10.3 - BitLocker Disk Encryption

## Objective

Configure BitLocker through Intune and verify encryption and recovery-key escrow.

## Prerequisites

Supported Windows edition, TPM-capable enrolled test device, Intune licensing and policy permissions, and an approved way to retrieve the recovery key. Use a test VM/device without critical data.

## Implementation

1. Open Endpoint security → Disk encryption → Create Policy.
2. Select Windows and the BitLocker profile.
3. Name the policy ES-10-WIN-BitLocker-Lab.
4. Configure encryption method and OS, fixed, and removable drive settings for the test.
5. Configure recovery information backup to the approved Entra ID/Intune location.
6. Verify the escrow process before enforcing encryption; assign to the test group.

## Validation

Run Get-Tpm and Get-BitLockerVolume. Review MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage, and EncryptionMethod. Verify the recovery-key record in the authorized management portal. Never place recovery keys in reports or GitHub.

## Troubleshooting

Check TPM readiness, Windows edition, join/enrollment state, assignment, conflicts, and BitLocker event logs.

## Security and rollback

Do not enable encryption until escrow is confirmed. Follow an approved suspend/decrypt procedure for rollback; do not delete protectors without an alternative recovery method.

## Exercise

Record TPM readiness, encryption percentage, protection status, and evidence of escrow without recording the key.
