---
icon: chart-simple
---

# MS-Graph Commands

## Connecting to MS-Graph

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass
EXPLANATION: Temporarily sets the script execution policy to Bypass, allowing all scripts to run without prompts or warnings.

Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force
EXPLANATION: Installs the base Microsoft Graph PowerShell module for the current user from the PowerShell Gallery, forcing installation even if already present.

Install-Module Microsoft.Graph.Users -Scope CurrentUser -Force
EXPLANATION: Installs the Microsoft.Graph.Users module, which includes cmdlets for managing user accounts, scoped to the current user.

Connect-MgGraph -Scopes "Group.ReadWrite.All", "User.ReadWrite.All"
EXPLANATION: Connects to Microsoft Graph with delegated permissions to read/write both users and groups.
```



## REFERENCES

* [https://learn.microsoft.com/en-us/powershell/microsoftgraph/?view=graph-powershell-1.0](https://learn.microsoft.com/en-us/powershell/microsoftgraph/?view=graph-powershell-1.0)
* [https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/?view=graph-powershell-1.0](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/?view=graph-powershell-1.0)
