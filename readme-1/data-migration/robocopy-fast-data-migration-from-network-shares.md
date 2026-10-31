---
description: >-
  Practical guide to copying local and network-share data with Robocopy,
  including multithreading, exclusions, logging, troubleshooting, and folder
  attributes.
---

# Robocopy: Fast Data Migration from Network Shares

Robocopy (Robust File Copy) is included with Windows and is useful for bulk file transfers, server migrations, and repeatable network-share copies.

## 1. Scenario

| Item               | Value                  |
| ------------------ | ---------------------- |
| Source             | `\\10.10.31.175\e`     |
| Destination        | `E:\182`               |
| Excluded directory | `\\10.10.31.175\e\RAM` |
| Log                | `C:\robocopy-copy.log` |

The goal is to copy the contents of the network share into `E:\182`, including subdirectories and empty directories, while excluding `RAM` and everything below it.

{% hint style="warning" %}
Verify source and destination before running. This procedure uses copy mode, not mirror mode. Do not add `/MIR` or `/PURGE` unless deleting destination-only data is explicitly intended.
{% endhint %}

## 2. Recommended command

Run Command Prompt or PowerShell using an account with read access to the share and write access to the destination:

```cmd
robocopy "\\10.10.31.175\e" "E:\182" /E /XD "\\10.10.31.175\e\RAM" /MT:32 /R:1 /W:1 /Z /COPY:DAT /DCOPY:DAT /NP /TEE /LOG:C:\robocopy-copy.log
```

This copies the share contents, excludes the `RAM` directory tree, uses 32 threads, enables restartable mode, and writes a log.

| Switch       | Purpose                                                            |
| ------------ | ------------------------------------------------------------------ |
| `/E`         | Copies all subdirectories, including empty ones.                   |
| `/XD`        | Excludes the named directory tree.                                 |
| `/MT:32`     | Uses 32 parallel copy threads.                                     |
| `/R:1`       | Retries a failed copy once.                                        |
| `/W:1`       | Waits one second between retries.                                  |
| `/Z`         | Uses restartable mode, useful over a network.                      |
| `/COPY:DAT`  | Copies file Data, Attributes, and Timestamps.                      |
| `/DCOPY:DAT` | Copies directory Data, Attributes, and Timestamps where supported. |
| `/NP`        | Suppresses per-file percentage progress.                           |
| `/TEE`       | Displays output and writes it to the log.                          |
| `/LOG:path`  | Writes output to the specified log file.                           |

### Thread count

Start with `/MT:32`. If storage and network capacity allow, test `/MT:64`:

```cmd
robocopy "\\10.10.31.175\e" "E:\182" /E /XD "\\10.10.31.175\e\RAM" /MT:64 /R:1 /W:1 /Z /COPY:DAT /DCOPY:DAT /NP /TEE /LOG:C:\robocopy-copy.log
```

More threads do not always mean higher throughput. Small files, network limits, and disk contention can make a lower thread count faster. Test with the real workload.

## 3. Verify access to the network share

Check that the share is reachable:

```cmd
dir "\\10.10.31.175\e"
```

List mapped drives and network connections:

```cmd
net use
```

If authentication is required, connect using an authorized account:

```cmd
net use \\10.10.31.175\e /user:DOMAIN\username *
```

Enter the password at the prompt. Replace the example account with the correct domain or local account. Avoid putting plaintext passwords in scripts or command history.

## 4. Troubleshoot mapped-drive errors

A mapped drive such as `Z:\` can be available in a normal Command Prompt but unavailable in an elevated Command Prompt. Windows may maintain separate mapped-drive contexts for elevated and non-elevated sessions.

Example command that may fail if the mapping is not visible:

```cmd
robocopy Z:\ E:\182 /E /MT:32 /R:1 /W:1 /XJ /COPY:DAT /DCOPY:DAT /NP /TEE /LOG:C:\robocopy-copy.log
```

Typical error:

```
ERROR 3 (0x00000003) Accessing Source Directory Z:\
The system cannot find the path specified.
```

Recommended fix: use the UNC path directly, for example `\\10.10.31.175\e`. If you must use the drive letter, run Robocopy in the same user session where it is mapped, or map it in the elevated session:

```cmd
net use Z: "\\10.10.31.175\e" /persistent:no
dir Z:\
```

Use the actual SMB share name; a remote drive letter is not automatically the share name.

## 5. Exclude directories

The `/XD` switch excludes a directory and its descendants:

```cmd
/XD "\\10.10.31.175\e\RAM"
```

In the full command, this prevents the `RAM` folder and its contents from being copied. Multiple excluded directories can be specified after `/XD`.

## 6. Monitor and validate the copy

View the log after the operation:

```cmd
type C:\robocopy-copy.log
```

Follow the log as it grows using PowerShell:

```powershell
Get-Content C:\robocopy-copy.log -Wait
```

Robocopy can generally be rerun after an interruption; it compares source and destination and skips files it considers already up to date. Review the final summary and investigate failed, skipped, or mismatched files.

### Exit codes

Robocopy uses bit-coded exit statuses:

|        Code | General interpretation                              |
| ----------: | --------------------------------------------------- |
|           0 | Nothing copied; no mismatch or failure reported.    |
|           1 | Files copied successfully.                          |
|           2 | Extra destination files or directories detected.    |
|           3 | Files copied and extra destination items detected.  |
|         4–7 | Mismatches and/or extra items; inspect the summary. |
| 8 or higher | At least one copy failure occurred.                 |

Codes below 8 generally do not indicate a fatal copy failure, but they do not replace reviewing the log and summary.

## 7. If the destination folder appears hidden

Inspect the destination attributes:

```cmd
attrib "E:\182"
dir /a "E:\"
```

Remove Hidden and System attributes from the destination folder itself:

```cmd
attrib -H -S "E:\182"
```

If you intentionally want to remove those attributes from all files and subfolders too:

```cmd
attrib -H -S "E:\182\*" /S /D
```

* `-H` removes the Hidden attribute.
* `-S` removes the System attribute.
* `/S` processes matching files in subdirectories.
* `/D` also processes directories.

{% hint style="warning" %}
The recursive command changes attributes throughout the copied tree. Do this only if you intend to unhide all copied files and folders; some system or application data may intentionally be hidden.
{% endhint %}

## 8. RMDIR syntax and deletion warning

The attempted command `rmdir -S 182` uses an invalid switch format. Windows uses slash-prefixed switches.

Remove an empty directory:

```cmd
rmdir "E:\182"
```

Delete a directory and all its contents:

```cmd
rmdir /S /Q "E:\182"
```

{% hint style="danger" %}
`rmdir /S /Q` permanently deletes the specified folder tree without confirmation. It is not needed to unhide a folder and is not part of the copy procedure. Verify the path and confirm the data is no longer needed before using it.
{% endhint %}

## 9. Permissions and copy behavior

The example uses `/COPY:DAT`, so it does not preserve NTFS permissions or ownership. If security metadata must be migrated, evaluate:

* `/COPY:DATS` — includes NTFS permissions (ACLs).
* `/COPY:DATSO` — also includes owner information.
* `/COPY:DATSOU` — also includes auditing information.

The account must have the privileges required to read and apply this metadata, and the destination must support it. Test with a small sample first.

Use the correct source/destination order:

```
robocopy <source> <destination> [options]
```

For this migration, the UNC share is the source and `E:\182` is the destination.

* `/E` copies subdirectories without deleting destination-only items.
* `/MIR` mirrors the directory tree and can delete destination files that are absent from the source.
* `/PURGE` deletes destination entries that do not exist in the source.

Avoid `/MIR` and `/PURGE` for a non-destructive copy.

## 10. Migration checklist

* [ ] Verify the UNC source and share permissions.
* [ ] Verify destination drive, free space, and write access.
* [ ] Confirm excluded directories such as `RAM`.
* [ ] Select an appropriate thread count.
* [ ] Save the log outside the destination tree.
* [ ] Review the final Robocopy summary and exit code.
* [ ] Investigate failed, skipped, or mismatched files.
* [ ] Validate important files at the destination.
* [ ] Confirm whether NTFS permissions, ownership, and auditing data are required.
* [ ] Keep the source unchanged until migration validation is complete.

## Quick command reference

```cmd
:: List mapped drives and network connections
net use

:: Test mapped drive access
dir Z:\

:: Test UNC share access
dir "\\10.10.31.175\e"

:: Authenticate to the share (replace the example account)
net use \\10.10.31.175\e /user:DOMAIN\username *

:: Map the share in this session if required
net use Z: "\\10.10.31.175\e" /persistent:no

:: Copy while excluding RAM
robocopy "\\10.10.31.175\e" "E:\182" /E /XD "\\10.10.31.175\e\RAM" /MT:32 /R:1 /W:1 /Z /COPY:DAT /DCOPY:DAT /NP /TEE /LOG:C:\robocopy-copy.log

:: View or follow the log
type C:\robocopy-copy.log
powershell -NoProfile -Command "Get-Content C:\robocopy-copy.log -Wait"

:: Inspect destination attributes
attrib "E:\182"
dir /a "E:\"

:: Unhide destination folder
attrib -H -S "E:\182"

:: Recursively unhide copied contents only if intended
attrib -H -S "E:\182\*" /S /D

:: DESTRUCTIVE: permanently delete destination tree
rmdir /S /Q "E:\182"
```

## Summary

For network migrations, prefer a UNC path to avoid mapped-drive visibility problems. Use `/MT` for parallel copying, `/XD` to exclude directory trees, `/Z` for restartable network transfers, and `/LOG` to retain evidence. Verify the final summary and validate the destination before considering the migration complete. Attribute changes and deletion are separate administrative tasks: use `attrib` to unhide data and use `rmdir /S /Q` only when deletion is explicitly intended.
