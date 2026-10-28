---
icon: windows
---

# Windows DNS Zone Migration with PowerShell

This guide explains how to use the [Windows DNS Migration Toolkit on GitHub](https://github.com/3ls3if/Windows-DNS-Migration-Toolkit) to prepare a DNS migration from a source Windows DNS server to a destination server.

## Overview

The toolkit provides PowerShell scripts to export DNS zone information, copy the migration package, import supported zones and records, and generate validation reports.

Repository: https://github.com/3ls3if/Windows-DNS-Migration-Toolkit

## Scope and important limitations

* The workflow is intended primarily for **standard primary DNS zones**.
* **Active Directory-integrated zones need a separate approach.** Their zone data is stored in Active Directory and should normally be made available through AD replication and the DNS role on the destination domain controller.
* The toolkit does not migrate every DNS Server setting. Review interfaces, root hints, logging, security settings, recursion, scavenging, DNS policies, and other server-specific configuration separately.
* Review the scripts and test them in a lab before production use. Do not assume a successful script run proves that every record and setting migrated correctly.
* Do not commit customer zone files, record exports, registry exports, or reports to a public GitHub repository.

## Prerequisites

1. Administrator access to both DNS servers.
2. The DNS Server role and/or DNS management tools installed as appropriate.
3. The PowerShell `DnsServer` module available on the servers.
4. A full backup and an approved migration window for production changes.
5. A secure method to transfer the export package from source to destination.

Check the module:

```powershell
Get-Module -ListAvailable -Name DnsServer
```

If needed, install the DNS management tools on Windows Server:

```powershell
Install-WindowsFeature -Name RSAT-DNS-Server
```

## Step 1: Export from the source DNS server

Download or copy `Scripts/Export-DNSMigration.ps1` from the repository to the source server. Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Export-DNSMigration.ps1
```

To select a different output folder:

```powershell
.\Export-DNSMigration.ps1 -OutputPath "D:\DNS-Migration"
```

The default export location is `C:\DNS-Migration`.

Review `ExportResults.csv` and `ZoneInventory.csv`. Investigate failed exports before proceeding.

## Step 2: Transfer the package

Copy the **entire** migration folder to the destination DNS server using a secure transfer method. The package can include zone files, XML record exports, forwarder information, metadata, and a registry export for reference.

Treat the package as sensitive infrastructure data. Keep it out of source control.

## Step 3: Prepare and dry-run on the destination

Install the DNS Server role if it is not already installed. Copy `Scripts/Import-DNSMigration.ps1` to the destination server and run a dry run first:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Import-DNSMigration.ps1 -MigrationPath "C:\DNS-Migration" -WhatIfMode
```

Review the output and confirm that the package paths and zone inventory are correct before making changes.

## Step 4: Import

After reviewing the dry-run output and confirming you have a rollback plan, run:

```powershell
.\Import-DNSMigration.ps1 -MigrationPath "C:\DNS-Migration"
```

The script attempts to create supported zones, import records, configure exported forwarders and conditional forwarders, and produce reports. Review all warnings and errors. Existing zones are not automatically overwritten.

## Step 5: Validate the migrated DNS service

Run these checks on the destination server. Replace `example.com` and `<DESTINATION-DNS-IP>` with your actual zone and server IP.

List zones:

```powershell
Get-DnsServerZone
```

Inspect records:

```powershell
Get-DnsServerResourceRecord -ZoneName "example.com"
```

Inspect the SOA record:

```powershell
Get-DnsServerResourceRecord -ZoneName "example.com" -RRType SOA
```

Inspect forwarders:

```powershell
Get-DnsServerForwarder
```

Test general resolution:

```powershell
Resolve-DnsName example.com -Server <DESTINATION-DNS-IP>
```

Test MX and TXT records where applicable:

```powershell
Resolve-DnsName example.com -Type MX -Server <DESTINATION-DNS-IP>
Resolve-DnsName example.com -Type TXT -Server <DESTINATION-DNS-IP>
```

Also validate A, AAAA, CNAME, SRV and PTR records as applicable to your environment. Check that SOA primary-server names and NS records are appropriate for the target design.

## Step 6: Review reports

The import process writes reports under:

```
C:\DNS-Migration\ImportReport\
├── ZoneImportResults.csv
├── RecordImportResults.csv
└── ValidationResults.csv
```

Review the results rather than relying only on the final console summary. Confirm that expected records are present and that important application, authentication, and mail lookups work.

## Step 7: Cut over and keep a rollback path

Only after validation:

1. Update DNS client settings, delegation, or the DNS server IP as required by the migration plan.
2. Test from representative clients and application servers.
3. Monitor DNS queries and dependent services.
4. Keep the source server and backups available until the migration is confirmed.
5. Document the final SOA/NS configuration and any server settings that were configured separately.

## DNS settings that may need separate migration

The export/import scripts are not a complete clone of the DNS server configuration. Review these independently:

* DNS listening interfaces and IP bindings
* Root hints and recursion settings
* Logging and diagnostics
* Zone transfer permissions and notify configuration
* Dynamic update and secure update behavior
* Scavenging and aging
* DNS policies, if used
* DNS server security and firewall rules
* DNS client settings and upstream resolver configuration

## Troubleshooting checklist

* **Zone file not found:** Confirm the zone is a standard file-backed primary zone and check its configured file name.
* **Zone already exists:** Review the existing destination zone before deciding how to proceed; the import script does not automatically replace it.
* **Records fail to import:** Review the record import report and error messages, then compare the source and destination records. Some record types or metadata may require manual handling.
* **Name resolution fails:** Check the zone, SOA/NS records, forwarders, firewall rules, DNS client settings, and test with `Resolve-DnsName -Server`.
* **AD-integrated zone:** Use an Active Directory replication-based migration plan rather than treating the zone as a standard zone-file migration.

## Related resource

* [Windows DNS Migration Toolkit on GitHub](https://github.com/3ls3if/Windows-DNS-Migration-Toolkit)
* [Microsoft: How to move Windows DNS zones to another Windows server](https://learn.microsoft.com/windows/release-health/windows-server-release-info)
