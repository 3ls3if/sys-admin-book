# Lab 10.2 - Windows Firewall

## Objective

Deploy and validate Windows Firewall profile settings using Intune.

## Prerequisites

An enrolled Windows test device, dedicated test group, documented firewall configuration, and console or out-of-band access in case remote connectivity is affected.

## Implementation

1. In Intune, open Endpoint security → Firewall → Create Policy.
2. Select Windows and the Windows Firewall profile.
3. Name the policy ES-10-WIN-Firewall-Lab.
4. Configure Domain, Private, and Public profiles according to the lab requirement. Keep the firewall enabled.
5. Review inbound defaults and logging; assign only to the test group.

## Validation

Run elevated PowerShell: Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction, LogBlocked. Also run Get-NetConnectionProfile and inspect enabled rules with Get-NetFirewallRule.

## Troubleshooting

Confirm the active network profile, assignment scope, device sync, and whether GPO, another profile, or a baseline controls the same settings. Verify required management access before remote testing.

## Security and rollback

Do not create broad inbound allow rules or disable the firewall. Keep console access available. If connectivity is lost, use the approved recovery path to restore the previous policy and validate access.

## Exercise

Apply restrictive inbound settings to a test VM and prove required management access remains available.
