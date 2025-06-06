---
icon: plug
---

# Set Up Connectors Between Microsoft 365 and SmarterMail

> _Note: This setup is functional but skipping TLS can be risky and should only be used in trusted and controlled environments. Proceed with caution._

## 💡 Objective <a href="#id-5a2f" id="id-5a2f"></a>

To establish a working email flow between Microsoft 365 (M365) and SmarterMail without enforcing TLS, and ensure email delivery works both ways: from SmarterMail to M365 and vice versa.

## 🧰 Prerequisites <a href="#f7ff" id="f7ff"></a>

* Access to Microsoft 365 Admin Center (Exchange Admin Console)
* Access to SmarterMail Admin interface
* Admin credentials for both platforms
* MX Record should point to Microsoft 365

## 🔧 Step-by-Step Setup <a href="#id-2728" id="id-2728"></a>

## 1. Configure Connectors in Microsoft 365 <a href="#fede" id="fede"></a>

Navigate to:\
**Microsoft 365 Admin Center → Exchange Admin Center → Mail Flow → Connectors**

### Create Connector #1: From SmarterMail to Microsoft 365 <a href="#bd53" id="bd53"></a>

* **From**: Partner organization
* **To**: Microsoft 365
* **Name**: `SmarterMail to M365`
* **Connection security**: Ignore TLS (for this case)
* **IP authentication**: Add the public IP of your SmarterMail server (e.g., `xxx.xxx.xxx.xxx`)
* **Validation**: Add test sender domain/email for verification

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*JHkD_R0R3GUGImTglBPMWA.png" alt="" height="421" width="700"><figcaption></figcaption></figure>

### Create Connector #2: From Microsoft 365 to SmarterMail <a href="#b35b" id="b35b"></a>

* **From**: Microsoft 365
* **To**: Partner organization
* **Name**: `M365 to SmarterMail`
* **Connection security**: Ignore TLS
* **Route email using**: Fully qualified domain name (FQDN) or IP address of SmarterMail (e.g., `mail.customdomain.com` or `xxx.xxx.xxx.xxx`)

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*exT-Z5AocMjtDk4ITCDoZg.png" alt="" height="420" width="700"><figcaption></figcaption></figure>

> _🔐 **Tip**: Disabling TLS may cause Microsoft to throw warnings. You can still save the connector by confirming it’s a trusted route._

## 2. Configure SmarterMail Domain Settings <a href="#eb28" id="eb28"></a>

Login to your SmarterMail admin panel and go to:\
**Manage → Domains → \[YourDomain] → Email Settings**

### Key Settings: <a href="#ca0a" id="ca0a"></a>

* **Inbound Message Delivery**: Set to `External (use MX record)`
* **Deliver locally if user exists**: ✅ Enabled
* **Enable Greylisting**: Optional but good for spam filtering
* **Sender Verification Shield**: Optional for spoof protection

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*KVqWzoQy1wzq_jk39c5sUw.png" alt="" height="420" width="700"><figcaption></figcaption></figure>

This ensures SmarterMail only delivers emails for local users and all other mail routes based on the domain’s MX record (which points to M365).

## 📡 MX Record Setup <a href="#id-5fa3" id="id-5fa3"></a>

* **MX Record** of your domain should already point to Microsoft 365. That means all incoming email will hit Microsoft first.
* SmarterMail acts as a relay or internal sender in this scenario.

## 🔄 How It Works: <a href="#d020" id="d020"></a>

Direction Flow Path Connector Used Outbound (SmarterMail → M365) SmarterMail → M365 → External SmarterMail to M365 Inbound (External → M365 → SmarterMail) External → M365 → SmarterMail (local users) M365 to SmarterMail

## ⚠️ Things to Watch Out For <a href="#id-4064" id="id-4064"></a>

* **Skipping TLS**: This is okay for internal/testing environments, but _not_ recommended for production unless behind VPN or trusted firewall.
* **IP Addressing**: Ensure the IP you whitelist is static and properly configured.
* **Smart Host Trust**: Without TLS, spoofing risk increases. Trust only static, known IPs.
* **Looping Risk**: Avoid loop configs by using “Deliver locally if user exists” toggle correctly.

## ✅ Final Checks <a href="#id-9210" id="id-9210"></a>

* Test sending from SmarterMail to a Microsoft 365-hosted user
* Test replies from M365 to SmarterMail
* Monitor headers to ensure correct flow and no TLS errors

## 🧠 Bonus Tip <a href="#b050" id="b050"></a>

If Microsoft 365 blocks or flags your connector, try the following:

* Set the connector to accept mail only from specific IPs
* Re-validate the connector using the verification option
* Temporarily enable TLS for validation, then disable again



***

## REFERENCES

* [https://medium.com/@kumarnirbhay041/how-to-set-up-connectors-between-microsoft-365-and-smartermail-1cc9df6a0403](https://medium.com/@kumarnirbhay041/how-to-set-up-connectors-between-microsoft-365-and-smartermail-1cc9df6a0403)
* [https://support.duocircle.com/support/solutions/articles/5000875472-outbound-routing-from-office-365-to-smarthost](https://support.duocircle.com/support/solutions/articles/5000875472-outbound-routing-from-office-365-to-smarthost)
* [https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail](https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail)
