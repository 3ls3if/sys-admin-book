# Lab 11.2 - Microsoft Store App Deployment

## Objective

Deploy a Microsoft Store app using the new Store integration.

## Prerequisites

Enrolled supported Windows test device, Intune app management permissions, test assignment group, and Store/network access permitted by organizational policy.

## Implementation

1. In Intune, open Apps → All apps → Create.
2. Select Microsoft Store app (new).
3. Search for and select a suitable test application.
4. Review publisher and app metadata.
5. Choose Required for automatic installation or Available for Company Portal.
6. Assign only to the test group and create.

## Validation

Sync the test device. For Available apps, open Company Portal and install. For Required apps, inspect Intune device install status after policy processing. Confirm the app launches and publisher/version are expected.

## Troubleshooting

Check assignment scope, device sync, Store availability, proxy/firewall access, app eligibility, Company Portal sign-in, and status details in Intune.

## Security and rollback

Select trusted publishers and review app permissions/data handling. Remove the pilot assignment to stop further deployment. If removal is required, use the supported uninstall behavior and validate on the test device.

## Exercise

Deploy a trusted Store app as Available and document the Company Portal installation flow.
