---
icon: user
---

# User Logoff Event

#### **Event ID for User Logoff:**

* **Event ID:** **4634**
* **Log Name:** **Security**
* **Source:** **Microsoft Windows security auditing**
* **Message:** _An account was logged off._

***

#### Additional Useful Event IDs:

| Event ID | Description                                   | Log Location |
| -------- | --------------------------------------------- | ------------ |
| **4624** | Successful logon                              | Security     |
| **4647** | User initiated logoff (explicit)              | Security     |
| **4634** | Logoff (session ended)                        | Security     |
| **4779** | Session disconnect (Remote)                   | Security     |
| **1074** | Shutdown/restart initiated by user or process | System       |

{% hint style="warning" %}
**Use 4647** if you want to track logoffs that were explicitly initiated by the user (e.g., clicking “Log Off”), and **4634** for any type of session termination (timeout, RDP close, etc.).
{% endhint %}

***

#### How to View:

1. Open **Event Viewer** (`eventvwr.msc`)
2. Go to **Windows Logs > Security**
3. Use **Filter Current Log…** on the right
4. Filter by Event IDs:\
   `4634, 4647, 4779`&#x20;



***

## REFERENCES

* [https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-4634](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-4634)
* [https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/basic-audit-logon-events](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/basic-audit-logon-events)
* [https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/basic-security-audit-policy-settings](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/basic-security-audit-policy-settings)
* [https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventid=4779](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventid=4779)
