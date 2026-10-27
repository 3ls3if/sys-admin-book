---
icon: circle-arrow-up-left
---

# Change Default RDP Port

## Steps to Change RDP Port from Registry (regedit) <a href="#dbd0" id="dbd0"></a>

1. Type _**regedit**_ in the Search box
2. From the left navigation bar follow this path: _**`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`**_
3. Find _**PortNumber**_
4. Right-click Edit, then click _**Modify**_, and then click _**Decimal**_
5. Type your new desired port number, and then click _**OK**_.
6. Close the registry editor and restart your serve&#x72;_\*_

_\* Proceed with server restart only if you are sure there is no Firewall on your server. In any other case, read further below how to whitelist the new RDP port on Windows Firewall._



***

## Allow Custom RDP Port on Windows Firewall <a href="#f5b2" id="f5b2"></a>

Depending on your Windows Firewall state, you may need to add the new RDP port in the Inbound rules to ensure new connections will be allowed.

1. Open Windows Firewall on your Server (type _**firewall**_ in the Search box)
2. From the left-hand navigation, click _**Inbound Rules**_
3. Click _**New Rule**_ in the right-hand pane to open the New Inbound Rule Wizard.
4. In the New Inbound Rule Wizard, under the Rule Type section, select _**Port**_ and click _**Next**_
5. In the Protocol and Ports section, select _**TCP**_. Next, select _**Specific local ports**_, enter the custom RDP port as you have set it in Registry and then click _**Next**_
6. In the Action section, select _**Allow the connection**_ and click _**Next**_
7. In the Profile section, select all appropriate profiles for when this rule applies and click _**Next**_
8. Finally, give your new rule a descriptive name so that it is easy to find later, and click **Finish**.
9. Reboot your server _if you haven’t done so after the registry changes_

***

## Verify New RDP Port with PowerShell <a href="#id-369e" id="id-369e"></a>

Once your server has been rebooted you should be able to access it with the newly added RDP Port. To verify the newly set RDP port number, open PowerShell and run the following command:

```powershell
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber"
```

***

**Sample Output:**

```powershell
PortNumber : 61489
PSPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations
PSChildName : RDP-Tcp
PSDrive : HKLM
PSProvider : Microsoft.PowerShell.Core\Registry
```



***

## REFERENCES

* [https://netshopisp.medium.com/how-to-change-rdp-port-on-windows-server-2016-2019-2022-6021172bd748](https://netshopisp.medium.com/how-to-change-rdp-port-on-windows-server-2016-2019-2022-6021172bd748)

