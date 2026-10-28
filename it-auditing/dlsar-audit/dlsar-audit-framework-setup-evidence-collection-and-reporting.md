---
description: >-
  Practical guide to the reusable DLSAR Audit Framework for infrastructure
  evidence collection, configurable control assessment, and audit report
  generation.
icon: bowling-ball-pin
---

# DLSAR Audit Framework: Setup, Evidence Collection, and Reporting

The **DLSAR Audit Framework** is a reusable infrastructure-audit toolkit built with PowerShell, Python, and Git. It automates repetitive evidence collection and report preparation so an auditor can follow a consistent, traceable workflow across different client environments.

**Source repository:** [3ls3if/DLSAR\_Audit\_Framework on GitHub](https://github.com/3ls3if/DLSAR_Audit_Framework)

## Why build an audit framework?

Infrastructure audits often require administrators to run the same commands on multiple servers, collect configuration exports and screenshots, organize evidence, assess controls, document findings, and prepare a final report. Doing these steps manually can be time-consuming and inconsistent.

The framework automates repeatable technical tasks while keeping audit conclusions reviewable and evidence-based. It supports collection and reporting; it does not replace auditor judgement, interviews, policy review, or validation of evidence with the client.

## Key capabilities

* Collect Windows Server evidence with PowerShell.
* Gather evidence for operating system configuration, networking, security, Active Directory, DNS, Hyper-V, IIS, backup, and data-location checks where the relevant technology is present.
* Support a single Domain Controller or multiple servers and sites.
* Discover evidence files recursively instead of relying on a fixed list of filenames.
* Generate SHA-256 evidence hashes to help verify file integrity.
* Evaluate collected evidence against configurable audit controls.
* Generate structured Word-based DL SAR / infrastructure audit reports, findings CSV output, an evidence manifest, and an audit summary.
* Keep reusable framework code separate from client-specific configuration and evidence.

## Architecture

The workflow is separated into collection, evidence processing, control evaluation, and reporting.

| Component             | Responsibility                                                           |
| --------------------- | ------------------------------------------------------------------------ |
| PowerShell collectors | Gather configuration and security evidence from in-scope Windows systems |
| Evidence directory    | Store collected outputs for the engagement                               |
| Evidence parser       | Discover and normalize available evidence files                          |
| Audit engine          | Evaluate evidence against configured control rules                       |
| Configuration files   | Define report metadata and configurable audit rules                      |
| Report generator      | Produce the Word report and supporting outputs                           |
| GitHub repository     | Version and maintain reusable framework code                             |

## Repository layout

The repository is organized by responsibility. Names may evolve between releases; use the current repository README as the source of truth.

* `collector/` — main collection entry point and technology-specific PowerShell modules.
* `generator/` — Python evidence parser, audit engine, report generation, and utilities.
* `config/` — reusable audit rules, report settings, and an example client configuration.
* `templates/` — report section content and structure.
* `docs/` — client runbook, evidence model, and GitHub workflow.
* `evidence/` — working location for collected evidence; engagement evidence should not be committed.
* `output/` — generated reports and supporting artifacts; generated output should not be committed.

## Prerequisites

Before running an engagement, review the current README and requirements in the repository. Typical prerequisites include:

* Windows PowerShell on the target Windows systems, with an elevated session where required by the collector.
* Appropriate administrative permissions to read the configuration being audited.
* Python 3 and the packages listed in `requirements.txt` on the report-generation workstation.
* A secure destination for evidence and generated reports.
* Client approval for the collection scope and any scripts to be executed.

Some collectors require specific Windows roles, management modules, or permissions. A collector may return partial evidence when a command is unavailable or access is denied; review collection logs and errors before interpreting the results.

## Recommended audit workflow

{% stepper %}
{% step %}
### 1. Prepare the engagement

Clone or download the framework from GitHub. Review the scripts and the client runbook before execution. Define the audit period, reference, in-scope assets, sites, exclusions, and required control set.
{% endstep %}

{% step %}
### 2. Create client-specific configuration

Use the example configuration as a template. Set the client name, audit period, reference, auditor, sites, scope notes, excluded assets, and any justified control overrides. Keep the engagement configuration outside the public reusable source or exclude it from version control.
{% endstep %}

{% step %}
### 3. Collect evidence

Run the main PowerShell collection entry point on each approved in-scope system, using a distinct scope name for each server or site. Use a separate, access-controlled evidence directory for each engagement. Review the collection log and confirm expected outputs were created.
{% endstep %}

{% step %}
### 4. Validate evidence

Check that evidence files are readable, relevant, current, and associated with the correct asset. Investigate collector errors and missing outputs. A missing file is not automatically proof that a control failed.
{% endstep %}

{% step %}
### 5. Generate the report

Run the Python report generator using the current instructions in the repository README or client runbook. Review the generated Word report, audit summary, findings CSV, and evidence manifest.
{% endstep %}

{% step %}
### 6. Review and finalize

Validate every finding against the source evidence. Confirm severity, impact, remediation, scope, exclusions, and audit status. Remove unintended sensitive data from the deliverables, obtain the required review, and deliver the approved report through the client's authorized channel.
{% endstep %}
{% endstepper %}

## Example: collect evidence from one Domain Controller

A client with one Domain Controller in Noida can be audited; a second or disaster-recovery server is not a prerequisite. From an elevated PowerShell session, run the collector using the syntax documented in the current repository. For example:

```powershell
.\collector\Collect-AllEvidence.ps1 `
    -OutputRoot "C:\DL_SAR_Evidence" `
    -ScopeName "Client-Noida-DC01"
```

Use a unique scope name for each additional server. Collectors for Hyper-V, IIS, or other technologies should only be expected to return evidence when those technologies exist and are accessible.

## Multi-server and multi-site environments

Run collection separately on each approved system and preserve the identity of each scope. Use clear, non-conflicting scope names such as `Primary-DC01`, `Primary-HV01`, or `DR-WEB01`. Keep site and role information in the client configuration rather than embedding client names or IP addresses in reusable scripts.

For remote collection, confirm that the chosen method, credentials, firewall rules, and management protocols are approved and secured. Do not assume that a collector running on one server has gathered evidence from every other server.

## Understanding audit statuses

Use the status definitions configured for the engagement and report template. The framework's intended status model includes:

| Status | Meaning                                                                  |
| ------ | ------------------------------------------------------------------------ |
| C      | Compliant — sufficient evidence supports the control being met           |
| PC     | Partially compliant — some requirements are met, but gaps remain         |
| NC     | Non-compliant — evidence demonstrates that the control is not met        |
| NE     | Not evidenced — evidence is insufficient to determine the control status |
| NA     | Not applicable — the control does not apply to the agreed scope          |

**Important:** Use **NA** only when a control is genuinely not applicable and the rationale is documented. Use **NE** when the control may apply but the necessary evidence was not collected or supplied. For example, if the client has no DR site, a DR-specific control may be NA if the audit criteria allow that treatment; do not automatically mark it failed merely because a second server does not exist. Confirm the control definition and applicable regulatory requirements before deciding.

## Evidence integrity and handling

The framework creates SHA-256 hashes for collected evidence to help detect changes after manifest creation. A hash supports integrity verification; it does not, by itself, prove that evidence is accurate, complete, authentic, or sufficient for a control.

Recommended handling practices:

* Preserve the original collected evidence and its manifest.
* Restrict access to evidence and reports using least privilege.
* Record the collection date, asset/scope, collector errors, and any manual evidence supplied.
* Transfer evidence through an approved secure channel.
* Apply the client's retention and deletion requirements.
* Avoid placing passwords, access tokens, private keys, personal data, or unnecessary production details in GitHub.

## Keep client data separate from the framework

The public GitHub repository should contain reusable code, example configuration, templates, and generic documentation only.

Do **not** commit:

* Client names, hostnames, public or private IP inventories, or tenant identifiers.
* Raw collector output, screenshots, logs, backups, or report deliverables.
* Client-specific configuration files containing sensitive details.
* Credentials, secrets, tokens, private keys, or confidential audit findings.

Review `.gitignore` and the staged changes before every commit. If sensitive data has already been pushed, removing it in a later commit is not enough; follow the repository's incident and secret-rotation process.

## Extending the framework

The design is intended to support additional collectors and control libraries over time. Potential extensions include:

* VMware infrastructure evidence collection.
* SQL Server security and configuration checks.
* Microsoft 365 and Entra ID assessments.
* Plesk and hosting-platform checks.
* Patch and vulnerability assessment.
* Additional evidence-to-control mappings.
* PDF output and an audit review dashboard.

Before adding a collector, define its scope, required permissions, output format, error handling, evidence sensitivity, and validation steps. Update the documentation and test against representative evidence before using the module for a client audit.

## Limitations and auditor responsibilities

The framework is an aid to evidence collection and report preparation, not an automatic certification or guarantee of compliance. Its output depends on the quality and coverage of the collected evidence, the accuracy of configured controls, permissions, and the audit scope.

An auditor must review exceptions, missing evidence, control mappings, regulatory applicability, and each generated finding. Confirm report content and numbering before issuing a client-ready deliverable.

## Project links

* [GitHub repository](https://github.com/3ls3if/DLSAR_Audit_Framework)
* [Usage and operating instructions](https://github.com/3ls3if/DLSAR_Audit_Framework/tree/main/docs)
* [Report generator and configuration](https://github.com/3ls3if/DLSAR_Audit_Framework/tree/main/generator)
