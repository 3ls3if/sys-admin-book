---
icon: viruses
---

# Allow Multiple Remote Desktop Connections

#### Enable Multiple RDP Sessions

1. Log into the server, where the Remote Desktop Services are installed.
2. Open the start screen (press the Windows key) and type gpedit.msc and open it.
3. Go to Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Connections.
4. Set Restrict Remote Desktop Services user to a single Remote Desktop Services session to Disabled.
5. Double click Limit number of connections and set the RD Maximum Connections allowed to 999999.

![RDPSessions2012.png](https://help.matrix42.com/@api/deki/files/825/RDPSessions2012.png?revision=1)

#### Disable Multiple RDP Sessions

1. Log into the server, where the Remote Desktop Services are installed.
2. Open the start screen (press the Windows key) and type gpedit.msc and open it.
3. Go to Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Connections.
4. Set Restrict Remote Desktop Services user to a single Remote Desktop Services session to Enabled.
