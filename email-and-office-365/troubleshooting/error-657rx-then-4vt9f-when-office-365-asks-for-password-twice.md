---
icon: windows
---

# Error 657rx then 4vt9f when Office 365 asks for password twice

## Steps:

* Sign out of all Office apps.
* Open PowerShell as admin and run:

```powershell
# wipe WAM token caches
Remove-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\AC\TokenBroker\Accounts\*" -Recurse -Force
Remove-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\AC\TokenBroker\Accounts\*" -Recurse -Force
```

* Reboot, launch Word, and sign in again.

The `TokenBroker` folders rebuild clean and the `657rx` / `4vt9f` prompts disappear.



***

## REFERENCES

* [https://www.troublefixers.org/question/error-657rx-then-4vt9f-when-office-365-asks-for-password-twice](https://www.troublefixers.org/question/error-657rx-then-4vt9f-when-office-365-asks-for-password-twice)
