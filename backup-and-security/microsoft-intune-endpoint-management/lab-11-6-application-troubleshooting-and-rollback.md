# Lab 11.6 - Application Troubleshooting and Rollback

## Common symptoms

* Pending: check device check-in, assignment, IME, and network.
* Install failed: check installer command, exit code, context, and logs.
* Not detected: check detection rule, file path, and MSI product code.
* Available app missing: check Company Portal sign-in, user assignment, and sync.
* Dependency failure: check dependency detection and assignment.
* Upgrade failure: check supersedence and vendor upgrade support.
* Microsoft 365 Apps failure: check license, existing Office, architecture, and CDN access.

## Troubleshooting workflow

1. Confirm user/device group membership and assignment filters.
2. Trigger device sync.
3. Review Intune app device status and error details.
4. For Win32 apps, inspect C:\ProgramData\Microsoft\IntuneManagementExtension\Logs.
5. Validate the install command manually on a test machine using the intended context.
6. Verify detection logic independently.
7. Change one setting at a time and retest.

## Rollback

Stop rollout by removing the pilot assignment. If installed, use a tested Uninstall assignment or vendor command. To revert an upgrade, deploy the previous validated package and verify data compatibility. Sync, inspect status, confirm removal or prior version, and record the result. Removing a Required assignment does not automatically uninstall an app.

## Evidence and security

Capture sanitized configuration, assignment, status, logs, and rollback verification. Never commit credentials, license keys, tokens, proprietary installers, or sensitive device inventory.

## Exercises

Diagnose a deliberately incorrect detection rule, investigate a failed silent install, uninstall a test app, and restore a previous version.
