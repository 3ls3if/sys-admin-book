---
icon: cart-shopping-fast
---

# How to Remove the Remote Desktop Services (RDS) Grace Period in Windows Server

When Remote Desktop Services (RDS) are installed on a Windows Server, Microsoft provides a **120-day grace period** during which users can connect without requiring an activated RDS license server. Once the grace period expires, new connections are denied until valid RDS Client Access Licenses (CALs) are installed and activated.

However, there are scenarios — such as testing, troubleshooting, or reconfiguring RDS licensing — where you may need to **remove or reset the RDS grace period** to restore temporary access. This guide explains how to safely do so.

***

### Important Warning

Editing the Windows Registry can cause serious system issues if done incorrectly.\
Before proceeding, **create a full backup of your registry** and **ensure you have administrative privileges** on the server.

***

### When to Use This Method

* The RDS grace period has expired and you need temporary access.
* The licensing configuration is being reset or reconfigured.
* You are troubleshooting RDS licensing issues.

**Applicable Windows Server versions:**\
Windows Server 2012, 2016, 2019, and 2022.

***

### Step-by-Step: Remove or Reset the RDS Grace Period

#### 1. Open the Registry Editor

Press **`Win + R`**, type **`regedit`**, and press **Enter**.

***

#### 2. Navigate to the RDS Grace Period Key

Go to the following registry path:

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\GracePeriod
```

This key contains information about the grace period for RDS.

***

#### 3. Take Ownership of the GracePeriod Key

By default, even administrators may not have permission to modify this key.\
Follow these steps:

1. Right-click on **`GracePeriod`** and select **Permissions**.
2. Click **Advanced**.
3. In the **Owner** field, click **Change**.
4. Type **Administrators**, click **Check Names**, and then click **OK**.
5. Check the box **“Replace owner on subcontainers and objects.”**
6. Click **Apply**, then **OK**.

***

#### 4. Grant Full Control Permissions

1. Back in the **Permissions** window, select **Administrators**.
2. Check **Full Control** under the permissions list.
3. Click **Apply** → **OK**.

***

#### 5. Delete the Grace Period Value

In the right pane, you will see a **binary value** named:

```
L$RTMTIMEBOMB
```

Right-click on it and select **Delete**.\
This value enforces the RDS grace period timer. Deleting it effectively resets the grace period.

***

#### 6. Restart the Server

Finally, restart your Windows Server for the changes to take effect.

After the reboot, the grace period is reset, and you can reconnect to Remote Desktop Services.

***

### Additional Tips

* This method **does not provide a permanent license** — it simply resets the temporary grace period.
* To stay compliant with Microsoft licensing terms, **activate an RDS License Server** and install valid **Client Access Licenses (CALs)** as soon as possible.
*   You can check RDS license status using:

    ```
    RD Licensing Diagnoser (lsdiag.msc)
    ```
* For automation or scripting, PowerShell can be used to handle permissions and registry edits, but manual verification is recommended.

### Summary

| Step | Action                                                                                            |
| ---- | ------------------------------------------------------------------------------------------------- |
| 1    | Open `regedit`                                                                                    |
| 2    | Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\GracePeriod` |
| 3    | Take ownership of the key                                                                         |
| 4    | Grant Administrators full control                                                                 |
| 5    | Delete `L$RTMTIMEBOMB`                                                                            |
| 6    | Restart the server                                                                                |

***

### Final Note

While this technique is useful for system administrators dealing with licensing issues or testing environments, it should **not be used as a permanent workaround** to avoid licensing compliance. Always ensure your organization’s RDS deployment is properly licensed.
