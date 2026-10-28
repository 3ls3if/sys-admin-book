---
icon: toggle-on
---

# Enabling the System Event Audit Log

#### How to Enable Security Audit Policy <a href="#how-to-enable-security-audit-policy" id="how-to-enable-security-audit-policy"></a>

{% hint style="warning" %}
To enable security audit policy to capture load failures in the audit logs, follow these steps:
{% endhint %}

1. <mark style="color:green;">Open an elevated Command Prompt window. To open an elevated Command Prompt window, create a desktop shortcut to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Cmd.exe</mark>_<mark style="color:green;">, select and hold (or right-click) the</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Cmd.exe</mark>_ <mark style="color:green;"></mark><mark style="color:green;">shortcut, and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Run as administrator**</mark><mark style="color:green;">.</mark>
2.  <mark style="color:green;">In the elevated Command Prompt window, run the following command:</mark>



    ```cpp
    Auditpol /set /Category:System /failure:enable
    ```


3. <mark style="color:green;">Restart the computer for the changes to take effect.</mark>



<mark style="color:green;">The following screen shot shows how to use Auditpol to enable security auditing.</mark>

![screen shot of command-prompt window illustrating the use of auditpol to enable security auditing.](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/images/driver-signing-enable-auditpol.png)



#### How to Enable Verbose Logging of Code Integrity Diagnostic Events <a href="#how-to-enable-verbose-logging-of-code-integrity-diagnostic-events" id="how-to-enable-verbose-logging-of-code-integrity-diagnostic-events"></a>

To enable verbose logging, follow these steps:

1. <mark style="color:green;">Open an elevated Command Prompt window.</mark>
2. <mark style="color:green;">Run</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Eventvwr.exe</mark>_ <mark style="color:green;"></mark><mark style="color:green;">on the command line.</mark>
3. <mark style="color:green;">Under the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Event Viewer**</mark> <mark style="color:green;"></mark><mark style="color:green;">folder in the left pane of the Event Viewer, expand the following sequence of subfolders:</mark>
   1. <mark style="color:red;">**Applications and Services Logs**</mark>
   2. <mark style="color:red;">**Microsoft**</mark>
   3. <mark style="color:red;">**Windows**</mark>
4. <mark style="color:green;">Expand the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Code Integrity**</mark> <mark style="color:green;"></mark><mark style="color:green;">subfolder under the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Windows**</mark> <mark style="color:green;"></mark><mark style="color:green;">folder to display its context menu.</mark>
5. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**View**</mark><mark style="color:green;">.</mark>
6. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Show Analytic and Debug Logs**</mark><mark style="color:green;">. Event Viewer will then display a subtree that contains an</mark> <mark style="color:green;"></mark><mark style="color:green;">**Operational**</mark> <mark style="color:green;"></mark><mark style="color:green;">folder and a</mark> <mark style="color:green;"></mark><mark style="color:green;">**Verbose**</mark> <mark style="color:green;"></mark><mark style="color:green;">folder.</mark>
7. <mark style="color:green;">Select and hold (or right-click)</mark> <mark style="color:green;"></mark><mark style="color:green;">**Verbose**</mark> <mark style="color:green;"></mark><mark style="color:green;">and then select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Properties**</mark> <mark style="color:green;"></mark><mark style="color:green;">from the pop-up context menu.</mark>
8. <mark style="color:green;">Select the</mark> <mark style="color:green;"></mark><mark style="color:green;">**General**</mark> <mark style="color:green;"></mark><mark style="color:green;">tab on the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Properties**</mark> <mark style="color:green;"></mark><mark style="color:green;">dialog box, and then select the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enable Logging**</mark> <mark style="color:green;"></mark><mark style="color:green;">option near the middle of the property page. This will enable verbose logging.</mark>
9. <mark style="color:green;">Restart the computer for the changes to take effect.</mark>



***

## REFERENCES

* [https://learn.microsoft.com/en-us/windows-hardware/drivers/install/enabling-the-system-event-audit-log](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/enabling-the-system-event-audit-log)
