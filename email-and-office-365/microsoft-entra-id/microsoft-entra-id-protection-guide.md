---
icon: shield-check
---

# Microsoft Entra ID Protection Guide

Microsoft Entra ID Protection, formerly known as Azure Active Directory Identity Protection, assists organizations in detecting and responding to identity-based risks. It uses data from Microsoft’s vast threat intelligence network to identify suspicious user activities and sign-in patterns. For technical teams, properly configuring and using Identity Protection is key to preventing compromised identities and enforcing automated response actions.

‍

This guide explains how to implement, monitor, and fine-tune Microsoft Entra ID Protection. It focuses on practical configurations, policy design, risk-based access controls, and advanced response techniques.

‍

### Understand Identity Risks in Microsoft Entra ID Protection

‍

Before configuring any policies, it's important to understand the two main types of risks in Microsoft Entra ID Protection:

1. **User Risk** – Indicates a user account is likely compromised (e.g., leaked credentials, unusual activity).\
   <br>
2. **Sign-in Risk** – Flags suspicious login attempts (e.g., login from unfamiliar locations, atypical devices).

These risks are calculated using Microsoft’s machine learning models and updated continuously based on global telemetry. You can view detected risks from the [Identity Protection](https://learn.microsoft.com/en-us/entra/id-protection/overview-identity-protection) pane in the portal or by querying Microsoft Graph APIs for automation.

<figure><img src="https://cdn.prod.website-files.com/644fc991ce69ff211edbeb95/6848d1cd3c4724b7eaa83ddb_image2.png" alt="Microsoft Entra ID Protection dashboard showing user risks, sign-in alerts, and security policy settings."><figcaption></figcaption></figure>

Microsoft Entra ID Protection dashboard displaying detected user and sign-in risks using machine learning to help secure identities and manage access policies.

‍

### Configure Risk Policies for Access Control

‍

Once risks are detected, you can block or restrict access using **Risk-Based Conditional Access policies**. These policies can be configured to block access or [enforce multi-factor authentication (MFA)](https://www.reco.ai/hub/setting-up-multi-factor-authentication-entra-id) if risk is detected.

‍

#### Real-life Example: Block Access for High User Risk

‍

```javascript
{
  "conditions": {
    "userRiskLevels": [ "high" ]
  },
  "grantControls": {
    "operator": "OR",
    "builtInControls": [ "block" ]
  }
}
```

‍

This JSON configuration (via Microsoft Graph API) sets a Conditional Access policy that blocks sign-ins if user risk is high. In the portal, you can configure this visually under

‍**Conditional Access > New Policy > User Risk**.

‍

#### **Best Practices**

* Set high user risk = block access
* Set medium sign-in risk = require MFA
* Set low user risk = allow but monitor

Always test your policies with a small group before full deployment.

<figure><img src="https://cdn.prod.website-files.com/644fc991ce69ff211edbeb95/6848d21e597de959b73cef9e_image1.png" alt="Dashboard view of risk-based access policy settings in Microsoft Entra ID Protection."><figcaption></figcaption></figure>

The Visual interface of Microsoft Entra ID Protection with risk-based access policies configured to block or restrict access based on user and sign-in risk levels.

‍

### Automate User Risk Remediation

‍

[Microsoft Entra ID Protection](https://www.microsoft.com/en-in/security/business/identity-access/microsoft-entra-id) lets you automate responses for detected risks. If a user’s risk level reaches a certain threshold, you can trigger:

* Password reset
* MFA challenge
* Account lockout
* Access block

These responses are automatic when policies are enabled. You can also use **custom workflows with Microsoft Graph Security API** to trigger external tools or SIEM workflows.

‍

#### Example: Reset Password on Risk Detection (Graph API)

‍

```javascript
POST https://graph.microsoft.com/beta/identityProtection/riskyUsers/{user-id}/confirmCompromised
Authorization: Bearer <token>
```

‍

This API call marks the user as compromised, which enforces a password reset and blocks access until resolved. Use this in logic apps, runbooks, or SIEM workflows to automatically respond to high-risk users.

‍

### **Monitor Identity Protection Logs**

‍

Logs are crucial for visibility and response. Microsoft Entra ID Protection writes logs to:

* Sign-in logs
* Risky users
* Risk detections

You can integrate logs into **Log Analytics**, [**Microsoft Sentinel**](https://learn.microsoft.com/en-us/azure/sentinel/overview?tabs=defender-portal) or export to a SIEM.

‍

#### Example KQL Query for Sentinel

‍

```javascript
SigninLogs
| where RiskLevelDuringSignIn == "high"
| summarize count() by UserPrincipalName
```

‍

This query identifies users with frequent high-risk sign-ins. Use this to prioritize investigation or refine risk policies.

‍

Make sure diagnostic settings for Microsoft Entra ID are enabled and routed to your log destination.

‍

### **Respond to False Positives**

‍

Machine learning models may produce false positives. Technical teams should:

* Use **Risk Dismiss** to manually override risk if you confirm it's safe.
* Investigate using correlated sign-in data, IP reputation, device compliance, and recent user activity.
* Refine policies to reduce unnecessary user friction.

Risk dismissals can be done in the portal or with the [Graph API](https://learn.microsoft.com/en-us/graph/use-the-api):

‍

```javascript
POST https://graph.microsoft.com/beta/identityProtection/riskyUsers/{user-id}/dismiss
Authorization: Bearer <token>
```

‍

Add audit logging to track overrides for security and compliance reasons.

‍

### **Simulate and Test Identity Protection Policies**

‍

After setting up Identity Protection policies, it's critical to test their behavior before applying them organization-wide. This avoids accidental lockouts or unexpected access denials. Microsoft Entra ID provides multiple testing and simulation options that technical teams should use regularly to validate risk policies and access controls.

‍

Testing helps ensure that policies:

* Enforce the correct actions for specific risk levels
* Do not block legitimate users
* Work with existing MFA or hybrid identity configurations

#### **Use the “What If” Tool for Conditional Access**

‍

Microsoft Entra ID’s built-in What If tool simulates how Conditional Access policies apply to a given user, location, device, or risk level.

‍

Steps:

1. Go to Microsoft Entra ID > Security > Conditional Access > What If
2. Select a test user, location, platform, sign-in risk level, and app
3. Run the simulation to see which policies apply and what the result would be

This helps you validate your Identity Protection risk policies in the context of Conditional Access logic.

‍

#### Test Risk Detection with Test Accounts

‍

For real-world testing:

* Use non-production test accounts.
* Simulate high-risk sign-ins by logging in from unusual locations or using TOR/VPN (in a controlled environment).
* Monitor the Risky sign-ins and Risky users’ reports to see how the risks are detected.<br>

You can also use Microsoft’s Risky Sign-in Simulator to generate test signals.

‍

#### Monitor Impact in Real-Time

‍

After applying policies to a pilot group:

* Use **Sign-in logs** to monitor access behavior
* Check **Risk detections** to validate that policy thresholds are working as expected
* Watch for increased MFA prompts or access blocks

Update your policy scope gradually—start with a few users or groups, validate logs, and expand in phases.



‍

### **Conclusion**

‍

Microsoft Entra ID Protection is a great tool to minimize attacks based on identities. For the technical teams, merging automated policies, monitoring, and integrations can translate into proactive control of risky sign-ins and compromised users. Review your policies often; integrate them into your wider security operations; iterate your policies with relevant telemetry.

‍

Think of this as never being set in stone. The procedure will always require evaluation, tuning, and validation. Every time it is set up properly, it establishes the foundation of your identity security posture.



***

## REFERENCES

* [https://www.reco.ai/hub/microsoft-entra-id-protection](https://www.reco.ai/hub/microsoft-entra-id-protection)
* [https://learn.microsoft.com/en-us/training/modules/manage-azure-active-directory-identity-protection/](https://learn.microsoft.com/en-us/training/modules/manage-azure-active-directory-identity-protection/)
