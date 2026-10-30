# Lab 10.4 - Attack Surface Reduction in Audit Mode

## Objective

Deploy selected ASR rules in Audit mode and assess business impact before enforcement.

## Prerequisites

Enrolled Windows test device, test group, Defender Antivirus active, and applicable Windows/Defender licensing. Prepare approved test scenarios and an application compatibility plan.

## Implementation

1. Open Endpoint security → Attack surface reduction → Create Policy.
2. Select Windows and the ASR rules profile.
3. Name the policy ES-10-WIN-ASR-Audit-Lab.
4. Select a small set of relevant rules and set each to Audit initially.
5. Assign to the test group, sync, and reproduce safe approved scenarios.

## Validation

Run Get-MpPreference and inspect AttackSurfaceReductionRules\_Ids and AttackSurfaceReductionRules\_Actions. Review Defender operational events for ASR audit events and correlate timestamps with test activity. Use Defender portal reporting where available.

## Troubleshooting

Verify Defender is active, the device is eligible, rule IDs/actions are correct, assignments apply, and no conflicting policy overrides the settings.

## Security and rollback

Audit mode observes rather than blocks. Review events with application owners before switching a rule to Block. Return a disruptive rule to Audit or Not configured and validate.

## Exercise

Capture a controlled audit event and recommend whether the rule should remain in Audit or move to Block.
