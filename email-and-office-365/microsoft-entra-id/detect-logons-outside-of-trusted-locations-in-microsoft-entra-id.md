---
icon: location-dot
---

# Detect Logons Outside of Trusted Locations in Microsoft Entra ID

## How to Detect Logons Outside of Trusted Locations in Microsoft Entra ID

1. Open [portal.azure.com](https://portal.azure.com/) -> Click “Azure Active Directory”.
2. In the Monitoring section, click “Sign-ins”.
3. Click Download -> CSV.
4. Import the resulting file into Microsoft Excel:
   * <mark style="color:purple;">In Excel, click File -> Open –> Choose the file you just downloaded.</mark>
   * <mark style="color:purple;">In the Text Import Wizard, choose Data Type = “Delimited” and tick the “My data has headers” box -> Click Next.</mark>
   * <mark style="color:purple;">In the Delimiters section, tick “Comma” -> Click Next.</mark>
   * <mark style="color:purple;">Scroll through the fields preview and choose “Do not import column (skip)”, leaving only following columns: Date (UTC), User, Username, IP address, Location, Status. (For more logon details, you can also leave the “Application”, “Resource”, “Authentication requirement”, “Browser”, “Operating System” fields checked.) -> Click “Finish”.</mark>
5. Filter by trusted locations (or IP addresses) using the “Location” (or “IP address”) column.
6. Review the results:

<figure><img src="https://img.netwrix.com/howtos/1199536788837104.4i0o0cGE66L2JZvqilGx_height640.png" alt="How to Detect Sign-ins from Outside Trusted Locations in Azure AD - Native Auditing"><figcaption></figcaption></figure>





***

## REFERENCES

* [https://www.netwrix.com/detect-logons-outside-trusted-locations-azure.html](https://www.netwrix.com/detect-logons-outside-trusted-locations-azure.html)
* [https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins)
