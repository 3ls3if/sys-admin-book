---
icon: unlock
---

# Enable Microsoft Entra Self-Service Password Reset (SSPR)

### Self-Service Password Reset (SSPR) <a href="#h-self-service-password-reset-sspr" id="h-self-service-password-reset-sspr"></a>

Before you start to implement Self-Service Password Reset (SSPR) for the users, it’s good to know where you need to enable SSPR:

* **Cloud-only tenant:** Enable SSPR in Microsoft Entra ID
* **Hybrid deployment:** Enable SSPR in Microsoft Entra ID, enable password writeback in Microsoft Entra Connect Sync, and enable password writeback in Microsoft Entra ID

### Self-Service Password Reset license requirements <a href="#h-self-service-password-reset-license-requirements" id="h-self-service-password-reset-license-requirements"></a>

Check which Self-Service Password Reset features are available for your organization license in the table below:

| **Feature**                                                                                                                                                                                                                                                                                    | **Microsoft Entra ID Free** | **Microsoft 365 Business Standard** | **Microsoft 365 Business Premium** | **Microsoft Entra ID P1 or P2** |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ----------------------------------- | ---------------------------------- | ------------------------------- |
| <p><strong>Cloud-only user password change</strong><br>When a user in Microsoft Entra ID knows their password and wants to change it to something new.</p>                                                                                                                                     | ✓                           | ✓                                   | ✓                                  | ✓                               |
| <p><strong>Cloud-only user password reset</strong><br>When a user in Microsoft Entra ID has forgotten their password and needs to reset it.</p>                                                                                                                                                | ☓                           | ✓                                   | ✓                                  | ✓                               |
| <p><strong>Hybrid user password change or reset with on-prem writeback</strong><br>When a user in Microsoft Entra that’s synchronized from an on-premises directory using Microsoft Entra Connect wants to change or reset their password and also write the new password back to on-prem.</p> | ☓                           |                                     |                                    |                                 |

### How to enable Self-Service Password Reset in cloud-only tenant <a href="#h-how-to-enable-self-service-password-reset-in-cloud-only-tenant" id="h-how-to-enable-self-service-password-reset-in-cloud-only-tenant"></a>

To enable Self-Service Password Reset in cloud only tenant, follow the steps below:

1. Sign in to [Microsoft Entra admin center](https://entra.microsoft.com/)
2. Expand **Identity > Protection > Password reset**
3. Click on **Properties**
4. Select **All**
5. Click **Save**

**Note:** We recommend you enable Self-Service Password Reset for **All users**. It’s one of the recommendations from the [Microsoft Secure Score](https://learn.microsoft.com/en-us/defender-xdr/microsoft-secure-score).

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-01.png" alt="Enable Microsoft Entra Self-Service Password Reset for all users" height="706" width="1120"><figcaption></figcaption></figure>

6. Click on **Authentication methods**
7. Select **2**
8. Click **Save**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2021/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-01a.png" alt="Enable Microsoft Entra Self-Service Password Reset authentication methods" height="707" width="1123"><figcaption></figcaption></figure>

\
You did successfully configure Self-Service Password Reset for the cloud-only tenant. Remember to test the self-service password reset in the last part in the article.

Do you have a hybrid deployment (on-premises and cloud)? Follow the next step.

<br>

### How to enable Self-Service Password Reset in Hybrid deployment <a href="#h-how-to-enable-self-service-password-reset-in-hybrid-deployment" id="h-how-to-enable-self-service-password-reset-in-hybrid-deployment"></a>

To enable Self-Service Password Reset in Hybrid deployment, follow these steps:

#### 1. Enable Self-Service Password Reset in Microsoft Entra ID <a href="#h-1-enable-self-service-password-reset-in-microsoft-entra-id" id="h-1-enable-self-service-password-reset-in-microsoft-entra-id"></a>

Make sure you enable Self-Service Password Reset in Microsoft Entra ID, as shown in the previous step before you proceed further.

#### 2. Enable password writeback in Microsoft Entra Connect Sync <a href="#h-2-enable-password-writeback-in-microsoft-entra-connect-sync" id="h-2-enable-password-writeback-in-microsoft-entra-connect-sync"></a>

1. Sign in to [Microsoft Entra Connect server](https://www.alitajran.com/find-microsoft-entra-connect-server/)
2. Start the application **Azure AD Connect**
3. On the setup wizard welcome screen, click on **Configure**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-02.png" alt="Microsoft Entra Connect Sync welcome screen" height="620" width="880"><figcaption></figcaption></figure>

4. Click **Customize synchronization options**
5. Click **Next**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-03.png" alt="Microsoft Entra Connect Sync customize synchronization options" height="620" width="880"><figcaption></figcaption></figure>

<br>

6. Enter your **Microsoft Entra ID global administrator credentials**
7. Click **Next**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-04.png" alt="Connect to Microsoft Entra ID" height="620" width="880"><figcaption></figcaption></figure>

8. Click a couple of times on **Next** to go through the wizard till you reach the **Optional Features** screen
9. Check the checkbox **Password writeback**
10. Click **Next**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-05.png" alt="Enable Password writeback in Microsoft Enra Connect Sync" height="620" width="880"><figcaption></figcaption></figure>

<br>

11. Click **Configure**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-06.png" alt="Microsoft Entra Connect Sync ready to configure" height="620" width="880"><figcaption></figcaption></figure>

<br>

12. The configuration did **complete successfully**
13. Click **Exit**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-07.png" alt="Microsoft Entra Connect Sync configuration complete" height="620" width="880"><figcaption></figcaption></figure>



### 3. Enable password writeback in Microsoft Entra ID

To enable password writeback in Microsoft Entra ID, follow the steps below:

1. Sign in to [Microsoft Entra admin center](https://entra.microsoft.com/)
2. Expand **Identity > Protection > Password reset**
3. Click on **On-premises integration**
4. Select **all checkboxes**
5. Click **Save**

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-08.png" alt="Enable Microsoft Entra password reset for on-premises integration" height="706" width="1120"><figcaption></figcaption></figure>



### 4. Set minimum password age policy

Password policies in the on-premises AD DS environment may prevent password resets from being correctly processed.

The group policy for **Minimum password age** must be set to **0** for password writeback to work most efficiently.

1. Start **Group Policy Management Console (gpmc.msc)** on the Domain Controller.
2. Browse to **Computer Configuration > Policies > Windows Settings > Security Settings > Account Policies > Password Policy**.
3. Double-click on the policy **Minimum password age** and set it it **0 days**.

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-09.png" alt="Enable Microsoft Entra password reset for on-premises minumum password age" height="598" width="787"><figcaption></figcaption></figure>

<br>

4. Run **Command Prompt** as administrator and use the **gpupdate /force** command.

```
gpupdate /force
```

You did successfully configure Self-Service Password Reset for the Hybrid environment.



### Test Self-Service Password Reset <a href="#h-test-self-service-password-reset" id="h-test-self-service-password-reset"></a>

After it’s set up, the users can use the link [https://aka.ms/ssprsetup](https://aka.ms/ssprsetup) to reset their password.

The users can register their authentication methods from the link [https://aka.ms/ssprsetup](https://aka.ms/ssprsetup). After it’s set up, they can use the link [https://aka.ms/sspr](https://aka.ms/sspr) to reset their password.

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-test.png" alt="Enable Microsoft Entra Self-Service Password Reset test" height="774" width="1102"><figcaption></figcaption></figure>

\
They can also change their password from [https://aka.ms/mysecurity](https://aka.ms/mysecurity), and it will write back to on-premises.

<figure><img src="https://www.alitajran.com/wp-content/uploads/2024/05/Enable-Microsoft-Entra-Self-Service-Password-Reset-user.png" alt="Enable Microsoft Entra Self-Service Password Reset password changed" height="614" width="1127"><figcaption></figcaption></figure>

Read more: [Secure MFA and SSPR registration with Conditional Access »](https://www.alitajran.com/secure-mfa-and-sspr-registration/)



***

## REFERENCES

* [https://www.alitajran.com/self-service-password-reset/](https://www.alitajran.com/self-service-password-reset/)
