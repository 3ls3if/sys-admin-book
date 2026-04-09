---
icon: key
---

# Enable BitLocker in Windows Server 2019

To enable BitLocker in Windows Server 2019, you must first install the BitLocker feature, as it is not enabled by default. You can do this through the **Server Manager GUI** or **PowerShell**.



**Step 1: Install the BitLocker Feature**

You must have administrator privileges and expect a server restart to complete this step.

**Option A: Using Server Manager (GUI)**

1. Open **Server Manager** and select **Add Roles and Features**.
2. Click **Next** until you reach the **Features** pane.
3. Check **BitLocker Drive Encryption**. A pop-up will appear; select **Add Features** to include required management tools.
4. Proceed to **Confirmation**, check **Restart the destination server automatically if required**, and click **Install**.



**Option B: Using PowerShell**

1. Open PowerShell as an Administrator.
2.  Run the following command:powershell<br>

    ```
    Install-WindowsFeature BitLocker -IncludeManagementTools -Restart
    ```



_**Note:** The server will reboot automatically if you include the `-Restart` flag_.



**Step 2: Enable Encryption on a Drive**

After the server restarts, you can activate encryption on your volumes.

**For the Operating System (C:) Drive:**

1. Open **Control Panel** > **System and Security** > **BitLocker Drive Encryption**.
2. Select **Turn on BitLocker** next to the C: drive.
3. **Back up your recovery key**: Choose to save it to a file, a USB drive, or print it. **Crucial**: Store this in a safe, off-server location.
4. **Choose encryption type**:
   * **Used Disk Space Only**: Faster, best for new servers.
   * **Entire Drive**: Slower, but safer for servers that previously held sensitive data.
5. Run the **BitLocker system check** and click **Continue** to restart and begin encryption.&#x20;



**For Data Drives (Fixed Drives):**

1. In the same BitLocker Control Panel, find your data drive and click **Turn on BitLocker**.
2. Select **Automatically unlock this drive on this computer** so the drive is available immediately after a server reboot.
