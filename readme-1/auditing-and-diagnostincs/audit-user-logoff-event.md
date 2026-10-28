---
icon: user
---

# Audit User LogOff Event

{% hint style="warning" %}
To **turn on auditing** so that Windows logs **user logoff events** (like Event ID 4634 and 4647), you need to **enable audit policies** in the **Local Security Policy** or through **Group Policy**.
{% endhint %}

## Method 1: Enable Auditing via Local Security Policy

### Steps:

1. **Open Local Security Policy**
   * Press `Win + R`, type `secpol.msc`, and hit **Enter**
2.  Navigate to:

    ```
    Security Settings > Local Policies > Audit Policy
    ```
3. On the right side, **double-click** the following policy:
   * **Audit logon events**
4. In the dialog box:
   * **Check** both **Success** and **Failure**
   * Click **OK**

{% hint style="success" %}
This enables logging of both **logon (4624)** and **logoff (4634)** events.
{% endhint %}



***

## Method 2: Enable via Group Policy (Domain Environment)

If you're in a domain or managing multiple servers:

1. Open **Group Policy Management Editor** (`gpmc.msc`)
2.  Navigate to:

    ```
    Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Audit Policy
    ```
3. Set **"Audit logon events"** to **Success and Failure**
4. Optionally, enable **"Audit account logon events"** as well
5. Run `gpupdate /force` on the target VM to apply the policy immediately.



***

## To Confirm It's Working:

1. After a user logs off, go to **Event Viewer**:
   * `Windows Logs > Security`
2. Look for:
   * **Event ID 4634** – Account logoff
   * **Event ID 4647** – User-initiated logoff



***

## REFERENCES

* [https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventid=4779](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventid=4779)
* [https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-4634](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-4634)
