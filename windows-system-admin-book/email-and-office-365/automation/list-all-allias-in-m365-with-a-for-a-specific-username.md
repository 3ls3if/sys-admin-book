---
icon: user-magnifying-glass
---

# List all allias in m365 with a for a specific username

To list **all aliases (email addresses)** associated with the mailbox **test@example.com** in Microsoft 365, here are the **most common and reliable methods**.



### ✅ Method 1: Microsoft 365 Admin Center (GUI)

1. Go to [**https://admin.microsoft.com**](https://admin.microsoft.com)
2. Navigate to **Users → Active users**
3. Click on **test@example.com**
4. Select **Mail** tab
5. Click **Manage email aliases**

👉 You’ll see:

* Primary SMTP address
* All secondary aliases (smtp:)

***

### ✅ Method 2: Exchange Admin Center (GUI)

1. Go to [**https://admin.exchange.microsoft.com**](https://admin.exchange.microsoft.com)
2. Navigate to **Recipients → Mailboxes**
3. Click **test@example.com**
4. Open **Email addresses**

This shows:

* Primary email
* All aliases
* Proxy addresses (SMTP, SIP, etc.)

***

### ✅ Method 3: PowerShell (Recommended for Accuracy)

#### Step 1: Connect to Exchange Online

```powershell
Connect-ExchangeOnline
```

#### Step 2: Get all aliases for the user

```powershell
Get-Mailbox test@example | Select -ExpandProperty EmailAddresses
```

#### Optional: Show in a cleaner format

```powershell
Get-Mailbox test@example.com |
Select DisplayName, PrimarySmtpAddress, EmailAddresses
```

#### SMTP-only aliases

```powershell
Get-Mailbox test@example.com |
Select -Expand EmailAddresses |
Where-Object { $_ -like "smtp:*" }
```

> 🔹 `SMTP:` (uppercase) = Primary\
> 🔹 `smtp:` (lowercase) = Aliases

***

### ✅ Method 4: Azure AD (Less Complete – Not Recommended)

Azure AD does **not always show all mail aliases**, so use Exchange methods instead.

***

### 🔐 Required Permissions

You need one of these roles:

* **Global Admin**
* **Exchange Admin**
* **User Administrator**
