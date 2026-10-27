---
icon: ban
---

# Disable or Modify the Spam Quarantine Policy

### Step-by-Step: Disable or Modify the Spam Quarantine Policy

#### 1. **Log in as a Microsoft 365 Administrator**

Go to:\
https://security.microsoft.com

***

#### 2. **Navigate to Anti-Spam Policies**

1. In the left menu, go to:\
   `Email & collaboration` > `Policies & rules` > `Threat policies`
2. Click on **Anti-spam policies**

***

#### 3. **Locate the Active Spam Policy**

* You will see a list of policies:
  * The **“Default” policy** is always there
  * **Custom policies** (at the top) override defaults

***

#### 4. **Edit or Disable the Policy**

**Option A: Edit the Policy to Stop Quarantine**

1. Click the policy name (custom one, not default).
2. Under **Spam and bulk email actions**, find the **“Spam”** section.
3. Change action from **“Quarantine”** to:
   * **Move to Junk Email folder** _(recommended)_
   * Or: **Deliver to Inbox** _(less secure)_
4. Save changes

**Option B: Disable the Policy Entirely**

1. Click the `...` (three dots) next to the custom policy
2. Click **Disable**

{% hint style="warning" %}
Be careful when disabling policies — this applies to **all users or scoped users** in the policy and may increase risk of spam/phishing reaching inboxes.
{% endhint %}

***

#### 5. **Optional: Add Trusted Senders to Allow List**

To allow specific senders even if spam is detected:

1. Go to:\
   `Email & collaboration` > `Policies & rules` > `Tenant allow/block lists`
2. Add the sender domain or email under **Allowed Senders**



***

## REFERENCES

* [https://learn.microsoft.com/en-us/defender-office-365/quarantine-end-user](https://learn.microsoft.com/en-us/defender-office-365/quarantine-end-user)
* [https://www.nottingham.ac.uk/dts/documents/guides/microsoft-365-quarantine-guide.pdf](https://www.nottingham.ac.uk/dts/documents/guides/microsoft-365-quarantine-guide.pdf)
* [https://learn.microsoft.com/en-us/defender-office-365/quarantine-policies](https://learn.microsoft.com/en-us/defender-office-365/quarantine-policies)
