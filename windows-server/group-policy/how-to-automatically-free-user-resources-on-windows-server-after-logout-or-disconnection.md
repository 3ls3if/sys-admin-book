---
icon: arrow-right-to-bracket
---

# How to Automatically Free User Resources on Windows Server After Logout or Disconnection

When managing a Windows Server, particularly in environments with multiple users accessing the system via Remote Desktop Protocol (RDP), it's essential to ensure that **user sessions do not persist** after logout or disconnection. Orphaned or disconnected sessions not only **consume system resources** but can also pose a **security risk** if not properly handled.

This article walks you through **configuring your Windows Server** to automatically **terminate user sessions** and **free system resources** once a user logs out or disconnects.



### Why It's Important

When users disconnect without logging off:

* Their sessions continue running in the background.
* Processes might stay active, consuming CPU and RAM.
* The session remains visible in Task Manager and `query user`.
* Over time, this degrades server performance and stability.

To prevent this, Windows Server provides built-in policies to control session behavior.

***

### Configuring the Server to Automatically End Disconnected Sessions

#### 1. **Using Group Policy**

The best way to ensure user sessions terminate properly is through Group Policy.

**➤ Steps:**

1. Press `Win + R`, type `gpedit.msc`, and hit Enter.
2.  Navigate to:

    <pre><code>Computer Configuration >
    <strong>    Administrative Templates >
    </strong>        Windows Components >
                Remote Desktop Services >
                    Remote Desktop Session Host >
                        Session Time Limits
    </code></pre>
3. Double-click **“Set time limit for disconnected sessions”**.
4. Choose **Enabled**.
5. Set the time limit to something appropriate (e.g., **1 minute** or **Immediately**, if available).
6. Click **OK**.

{% hint style="warning" %}
This ensures the server ends any disconnected session after the specified time.
{% endhint %}

***

#### 2. **Force Session to End When Limit is Reached**

To guarantee that the session ends rather than being idle:

1. In the same Group Policy path, double-click:
   * **“End session when time limits are reached”**
2. Set it to **Enabled**.

{% hint style="warning" %}
This enforces the session to log off rather than just staying idle in the background.
{% endhint %}

***

### Per-User Settings (Optional)

If you want this policy applied to specific users only:

1. Open **Server Manager** → Tools → **Computer Management**.
2.  Navigate to:

    ```
    System Tools > Local Users and Groups > Users
    ```
3. Right-click a user → Properties → Go to **Sessions** tab.
4. Configure:
   * **End a disconnected session** → Set to 1 minute (or desired value).
   * **Idle session limit** → As needed.
   * **When session limit is reached** → **End session**.

{% hint style="warning" %}
This provides granular control on a per-user basis.
{% endhint %}

