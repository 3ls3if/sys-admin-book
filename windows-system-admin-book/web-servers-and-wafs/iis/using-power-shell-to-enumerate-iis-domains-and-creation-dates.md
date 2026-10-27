---
icon: globe-pointer
---

# Using Power Shell To Enumerate Iis Domains And Creation Dates

### Introduction

Managing Internet Information Services (IIS) environments often requires visibility into hosted websites, their bindings (domains), physical paths, and metadata such as creation dates. For system administrators, security engineers, and auditors, having a centralized inventory of IIS domains is crucial for compliance checks, incident response, and routine maintenance.

PowerShell, combined with the IIS administration modules, provides a powerful and efficient way to extract this information programmatically. This article explains how a simple PowerShell script can be used to retrieve the total number of domains hosted in IIS along with their physical paths and creation dates, and export the data for further analysis.

***

### Why Enumerate IIS Domains?

Enumerating IIS websites and their associated domains is useful in many scenarios:

* **Asset inventory**: Identify all websites hosted on a server.
* **Security auditing**: Detect unauthorized or forgotten domains.
* **Incident response**: Quickly understand what sites may be affected during a breach.
* **Compliance and governance**: Maintain records of hosted domains and deployment timelines.
* **Migration and backup planning**: Know what content exists and where it is stored.

Manually checking each website through IIS Manager can be time-consuming and error-prone, especially in large environments. Automating this process with PowerShell ensures accuracy and repeatability.

***

### Prerequisites

Before running the script, ensure the following:

* IIS is installed on the system.
* The **WebAdministration** PowerShell module is available (installed by default with IIS).
* PowerShell is run with sufficient privileges to access IIS configuration and filesystem paths.

You can load the IIS module using:

```powershell
Import-Module WebAdministration
```



### Powershell Script

```ps1
# ------------------------------------------------------------
# Script Name : IIS_Domain_Enumeration.ps1
# Description : Enumerates all IIS websites, their domains,
#               physical paths, and creation dates, then
#               exports the results to a CSV file.
# ------------------------------------------------------------

# Load IIS PowerShell module
Import-Module WebAdministration

# Get all IIS websites
$sites = Get-Website

# Initialize results array
$results = @()

# Loop through each IIS site
foreach ($site in $sites) {

    # Extract hostname(s) from bindings
    $hostnames = $site.Bindings.Collection |
                 ForEach-Object { $_.HostName } |
                 Where-Object { $_ -ne "" }

    # If no hostname is defined, mark it as N/A
    if (-not $hostnames) {
        $hostnames = "N/A"
    }

    # Get physical path
    $path = $site.PhysicalPath

    # Check if physical path exists and get creation date
    if (Test-Path $path) {
        $creationDate = (Get-Item $path).CreationTime
    } else {
        $creationDate = "Path Not Found"
    }

    # Create result object
    $results += [PSCustomObject]@{
        SiteName     = $site.Name
        Domain       = ($hostnames -join ", ")
        PhysicalPath = $path
        CreatedOn    = $creationDate
    }
}

# Export results to CSV
$csvPath = "C:\IIS_Domains.csv"
$results | Export-Csv $csvPath -NoTypeInformation -Encoding UTF8

# Display completion message
Write-Host "IIS domain enumeration completed successfully." -ForegroundColor Green
Write-Host "Output saved to: $csvPath" -ForegroundColor Cyan

```

***

### Understanding the PowerShell Script

The script performs the following high-level steps:

1. Retrieves all IIS websites.
2. Iterates through each website.
3. Extracts the domain name (hostname) from site bindings.
4. Identifies the physical path of the website.
5. Determines the creation date of the physical directory.
6. Stores the collected data in a structured object.
7. Exports the results to a CSV file.

#### Script Breakdown

```powershell
$sites = Get-Website
```

This command fetches all configured IIS websites.

```powershell
$results = @()
```

An empty array is initialized to store the results.

```powershell
foreach ($site in $sites) {
```

The loop processes each IIS site individually.

```powershell
$hostname = $site.Bindings.Collection.Hostname
$path = $site.PhysicalPath
```

These lines extract the domain name (from bindings) and the website’s physical directory path.

```powershell
if (Test-Path $path) {
    $creation = (Get-Item $path).CreationTime
} else {
    $creation = "Path Not Found"
}
```

The script checks whether the physical path exists. If it does, it retrieves the directory creation time; otherwise, it marks the path as missing.

```powershell
$results += [PSCustomObject]@{
    SiteName     = $site.Name
    Domain       = $hostname
    PhysicalPath = $path
    CreatedOn    = $creation
}
```

A custom PowerShell object is created for each site, ensuring clean and structured output.

```powershell
$results | Export-Csv "C:\IIS_Domains.csv" -NoTypeInformation
```

Finally, all collected data is exported to a CSV file, which can be opened in Excel or used for reporting and audits.

***

### Output and Interpretation

The generated CSV file contains the following columns:

* **SiteName** – The name of the IIS website.
* **Domain** – The hostname/domain bound to the site.
* **PhysicalPath** – The directory where the website files are stored.
* **CreatedOn** – The creation date of the website directory.

By counting the rows in the CSV file, administrators can easily determine the **total number of domains** hosted on the IIS server.

***

### Security and Operational Use Cases

This approach is especially valuable for:

* **Blue teams** performing routine infrastructure audits.
* **SOC and IR teams** validating exposed web assets.
* **System administrators** cleaning up unused or legacy websites.
* **Compliance teams** maintaining hosting timelines for regulatory purposes.

The script can also be extended to include additional details such as:

* IP addresses and ports from bindings
* SSL certificate details
* Last modified timestamps
* Application pool information

***

### Conclusion

PowerShell provides a simple yet powerful way to enumerate IIS websites and extract meaningful metadata such as domain names and creation dates. By automating this task, administrators gain better visibility into their IIS environment, reduce manual effort, and improve security and compliance posture.

Exporting the results to CSV further enables easy reporting, sharing, and long-term record keeping. This method is an excellent example of how scripting can streamline everyday administrative and security tasks in Windows-based web infrastructures.

***

_Author: Rohan_
