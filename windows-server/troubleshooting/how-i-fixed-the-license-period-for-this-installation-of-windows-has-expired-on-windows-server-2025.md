---
icon: id-card-clip
---

# How I Fixed “The License Period for This Installation of Windows Has Expired” on Windows Server 2025

Many Windows Server administrators eventually encounter a sudden and frustrating issue:

* The server starts shutting down automatically
* Event Viewer shows Event ID `1074`
* `wlms.exe` initiates shutdowns
* PowerShell reports licensing problems

The exact error message usually looks like this:

> “The license period for this installation of Windows has expired. The operating system is shutting down.”

In this article, I’ll explain:

* why this happens,
* how to diagnose it,
* and how to fix it safely on Windows Server 2025 Standard.

***

## Symptoms

The server may:

* restart or shut down every hour,
* show activation warnings,
* fail activation checks,
* or display licensing notifications.

In Event Viewer (`Windows Logs > System`) you may see:

```
Event ID: 1074Source: User32The process C:\Windows\system32\wlms\wlms.exe has initiated the shutdown.Comment: The license period for this installation of Windows has expired.
```

***

## Root Cause

This usually happens when the server is running:

* an Evaluation edition (`ServerStandardEval`)
* or an expired/unactivated license state.

The Windows Licensing Monitoring Service (`wlms.exe`) forces shutdowns when the licensing grace period expires.

***

## Step 1 — Check Current Windows Edition

Open PowerShell as Administrator and run:

```
DISM /online /Get-CurrentEdition
```

Example output:

```
Current Edition : ServerStandardEval
```

If you see `Eval`, the server is using a trial/evaluation installation.

***

## Step 2 — Check Activation Status

Run:

```
slmgr /dlv
```

and:

```
slmgr /xpr
```

Common signs of expiration:

* `License Status: Notification`
* `TIMEBASED_EVAL channel`
* expired grace period

***

## Step 3 — Temporarily Stop Forced Shutdowns

Abort any active shutdown timer:

```
shutdown /a
```

This only stops the current shutdown event temporarily.

***

## Step 4 — Rearm the Licensing Grace Period

If rearm count is available, run:

```
slmgr /rearm
```

Then reboot the server:

```
Restart-Computer
```

This often restores temporary licensing grace time and stops automatic shutdowns.

***

## Step 5 — Verify the Edition Again

After reboot:

```
DISM /online /Get-CurrentEdition
```

In my case, it showed:

```
Current Edition : ServerStandard
```

That confirmed the evaluation state was cleared successfully.

***

## Step 6 — Permanently Activate Windows

Temporary fixes are not enough for production systems.

Install a valid Windows Server 2016 Standard key:

```
slmgr /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
```

Activate Windows:

```
slmgr /ato
```

Verify activation:

```
slmgr /xpr
```

Expected result:

```
The machine is permanently activated.
```

***

## Common Error: 0xC004D302

After using `slmgr /rearm`, you may see:

```
0xC004D302
```

This usually means:

* a reboot is pending,
* or licensing services are temporarily locked.

Solution:

* reboot the server,
* then retry activation commands.

***

## Important Notes

### Do Not Disable WLMS

Avoid:

* disabling `wlms.exe`,
* registry hacks,
* unofficial activators,
* modifying licensing files.

These can:

* corrupt Windows licensing,
* break updates,
* or destabilize the server.

***

## Best Practice

For production servers:

* use properly licensed media,
* activate with valid MAK/KMS/Retail licensing,
* monitor activation status regularly.

Useful command:

```
slmgr /xpr
```

***

## Final Thoughts

This issue can look alarming because Windows begins forcing shutdowns automatically. Fortunately, in many cases the server can be stabilized quickly using:

1. `shutdown /a`
2. `slmgr /rearm`
3. reboot
4. proper activation

Once permanently activated, the shutdowns stop completely and the server returns to normal operation.
