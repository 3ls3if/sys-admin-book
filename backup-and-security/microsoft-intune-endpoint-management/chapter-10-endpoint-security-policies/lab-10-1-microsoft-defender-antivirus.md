# Lab 10.1 - Microsoft Defender Antivirus

## Objective

Create and validate an Intune Defender Antivirus policy for a Windows test device.

## Prerequisites

An appropriately licensed Intune tenant, enrolled Windows 10/11 test device, policy permissions, and test group SG-Intune-EndpointSecurity-Lab. Confirm Defender Antivirus is the intended primary antivirus provider.

## Implementation

1. Open the Intune admin center and navigate to Endpoint security → Antivirus → Create Policy.
2. Select the Windows platform and Microsoft Defender Antivirus profile.
3. Name the policy ES-10-WIN-Defender-Antivirus-Lab.
4. Configure real-time protection, cloud-delivered protection, and potentially unwanted application protection as appropriate for the lab.
5. Assign only to the test group, create the policy, and sync the device.

## Validation

Run elevated PowerShell: Get-MpComputerStatus | Select-Object AMServiceEnabled, AntivirusEnabled, RealTimeProtectionEnabled, AntivirusSignatureLastUpdated. Also inspect Get-MpPreference for the configured protection settings. Compare local state with Intune policy status; local output alone does not prove policy delivery.

## Troubleshooting

Check assignment scope, filters, device sync, licensing, third-party antivirus, Defender passive mode, and conflicting baselines or profiles. Review Defender operational events and Intune diagnostics.

## Security and rollback

Do not disable real-time protection for convenience. Remove the test assignment or restore prior values if needed, sync, and verify protection is active.

## Exercise

Configure real-time protection and record Intune status plus sanitized Get-MpComputerStatus output.
