# Lab 11.3 - Microsoft 365 Apps Deployment

## Objective and prerequisites

Deploy Microsoft 365 Apps for Windows. Requires an enrolled Windows test device, Intune app deployment permissions, eligible Microsoft 365 Apps license for activation, network access to required content delivery endpoints, and an inventory of existing Office installations and architecture.

## Implementation

1. In Intune, go to Apps → All apps → Create.
2. Select Microsoft 365 Apps for Windows 10 and later (label may vary).
3. Configure suite name, description, architecture, applications, language, and update channel.
4. Review existing Office compatibility and installation options.
5. Assign to the test group and create.

## Validation

Check deployment status in Intune. Launch an Office application and confirm activation with a licensed user. Verify architecture, version, update channel, and access to existing documents.

## Troubleshooting

Check licensing, existing MSI-based Office installations, architecture mismatch, running Office processes, network/CDN access, and conflicting Office deployments.

## Security and rollback

Use licensed users and trusted update channels. Schedule deployment to avoid interrupting active work. Follow a validated Office removal/redeployment plan; do not remove Office blindly from production endpoints.

## Exercise

Deploy the selected suite to one test device and record activation and version details.
