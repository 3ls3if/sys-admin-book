---
icon: windows
---

# SmarterMail Server Setup

#### **Step 1: System Requirements**

Before proceeding, ensure your server meets the minimum requirements:

* **OS:** Windows Server 2016/2019/2022
* **CPU:** At least a quad-core processor
* **RAM:** 8GB or more recommended
* **Storage:** SSD preferred (disk space depends on email usage)
* **.NET Framework:** Latest version (4.8 recommended)

**Networking Requirements:**

* **Public IP Address** (or Dynamic DNS if using a home server)
* **Open Ports:**
  * SMTP (25)
  * IMAP (143) & IMAPS (993)
  * POP3 (110) & POP3S (995)
  * Webmail (default: 9998)
  * WebAdmin (default: 9999)

***

#### **Step 2: Download & Install SmarterMail**

1. **Download SmarterMail** from the official website:\
   &#x20;https://www.smartertools.com/smartermail/downloads
2. Run the installer (`SmarterMail_Setup.exe`) and follow the installation wizard.
3. Choose the installation path (default is `C:\SmarterMail`).
4. Complete the installation and launch SmarterMail.

***

#### **Step 3: Initial Configuration**

1.  Open a web browser and go to:

    ```
    http://localhost:9998/admin
    ```
2. Log in using the default **admin** account (`admin` / `admin`).
3. Set up:
   * **Primary Domain Name:** (e.g., `yourdomain.com`)
   * **Mail Server Hostname:** (e.g., `mail.yourdomain.com`)
   * **Admin Email & Password**
4. Click **Save** and restart the SmarterMail service.

***

#### **Step 4: Configure Mail Services**

1. Open **SmarterMail Web Interface** (`http://localhost:9998`).
2. Navigate to **Settings > Protocols**:
   * Enable **SMTP, IMAP, and POP3** if needed.
   * Enable **SSL/TLS** (recommended for security).
   * Configure **SMTP Authentication** to prevent unauthorized relay.

***

#### **Step 5: Configure DNS Records**

To send and receive emails, configure your **DNS settings** in your domain registrar:

| Record    | Type | Host             | Value                              |
| --------- | ---- | ---------------- | ---------------------------------- |
| **MX**    | MX   | @                | mail.yourdomain.com (Priority: 10) |
| **A**     | A    | mail             | Your Server’s Public IP            |
| **SPF**   | TXT  | @                | `v=spf1 mx ~all`                   |
| **DKIM**  | TXT  | mail.\_domainkey | (Generate in SmarterMail)          |
| **DMARC** | TXT  | \_dmarc          | `v=DMARC1; p=none;`                |

✅ **Check your DNS using:**

* `nslookup -type=mx yourdomain.com`
* `dig mx yourdomain.com`

***

#### **Step 6: Enable SSL (Optional but Recommended)**

1. Install an **SSL certificate** for **mail.yourdomain.com** (Let's Encrypt or paid SSL).
2. In **SmarterMail Settings > Bindings**, select the SSL certificate.
3. Ensure users connect via **IMAPS (993), SMTPS (465), POP3S (995).**

***

#### **Step 7: Test Email Functionality**

* Send an email using **Webmail** (`http://localhost:9998`).
*   Test SMTP using **Telnet**:

    ```
    telnet mail.yourdomain.com 25
    ```
* Use an external mail client (Outlook, Thunderbird) to check **SMTP/IMAP**.

***

#### **Step 8: Secure & Monitor the Server**

* Set up **firewall rules** (allow only necessary ports).
* Enable **antivirus and spam protection**.
* Monitor logs under **SmarterMail > Reports**.
* Use **Fail2Ban (Windows equivalent: RdpGuard)** to block brute-force attempts.

***

#### **Final Checks**

✔ **Email sending/receiving works**\
✔ **DNS records are correctly configured**\
✔ **SSL is enabled (optional but secure)**\
✔ **Firewall and security settings are active**
