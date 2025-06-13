---
icon: broom-wide
---

# Clear temp file and .trc file

## Manual Method (via Remote Desktop)

**a. Delete Temp Files**

1.  Press `Win + R`, type:

    ```
    %temp%
    ```
2. Delete all files from this folder.
3.  Also clean the system temp folder:

    ```
    C:\Windows\Temp
    ```

**b. Delete `.trc` Files**

*   Use File Explorer or Command Prompt:

    ```
    del /s /q C:\*.trc
    ```

