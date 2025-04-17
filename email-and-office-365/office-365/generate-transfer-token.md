---
icon: hexagon-vertical-nft
---

# Generate Transfer Token

{% hint style="warning" %}
To generate a **transfer token** for a **Microsoft 365 (M365)** domain (often used when transferring a domain between Microsoft tenants), you’ll typically follow this process from the **source tenant** using PowerShell or the Microsoft admin center.
{% endhint %}

## Generate a Transfer Token in Microsoft 365

{% hint style="success" %}
**Pre-requisites:**

* You must be a **Global Administrator** in the **source tenant** (where the domain currently resides).
* You need to install and use the **Microsoft Graph PowerShell SDK** (or the legacy **MSOnline module** for older environments).
{% endhint %}

### Using Microsoft Graph PowerShell (Recommended)



1. **Install Microsoft Graph PowerShell SDK (if not installed):**

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

2. **Connect to Graph:**

```powershell
Connect-MgGraph -Scopes "Domain.ReadWrite.All", "Directory.AccessAsUser.All"
```

{% hint style="warning" %}
You will be prompted to log in as a **Global Admin**.
{% endhint %}

3. **Generate the transfer token:**

```powershell
$domainName = "yourdomain.com"
$token = New-MgDomainTransferToken -DomainId $domainName
$token.Value
```

{% hint style="warning" %}
This will generate a token string that you can copy and paste into the target tenant to initiate domain takeover.
{% endhint %}

{% hint style="success" %}
#### **Where to Use the Token**

In the **target tenant**, when you attempt to add the domain via the **Microsoft 365 Admin Center**, you'll be prompted to enter this **transfer token** to verify domain ownership.
{% endhint %}

{% hint style="danger" %}
#### **Important Notes:**

* The token is valid for **only 7 days**.
* Do **not remove** the domain from the source tenant until the transfer is completed.
* The domain must not have any associated services (like email, Teams, etc.) actively using it when transferring.
{% endhint %}



***

## Use the Transfer Token in the Target Tenant

**Step 1: Sign into the Microsoft 365 Admin Center of the target tenant**

* <mark style="color:green;">Go to</mark> [<mark style="color:green;">https://admin.microsoft.com</mark>](https://admin.microsoft.com)
* <mark style="color:green;">Use</mark> <mark style="color:green;"></mark><mark style="color:green;">**Global Admin**</mark> <mark style="color:green;"></mark><mark style="color:green;">credentials for the</mark> <mark style="color:green;"></mark><mark style="color:green;">**target**</mark> <mark style="color:green;"></mark><mark style="color:green;">Microsoft 365 tenant</mark>



**Step 2: Add the domain using the token**

1. <mark style="color:green;">In the left sidebar, go to:</mark> <mark style="color:green;"></mark><mark style="color:green;">**Settings**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Domains**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Add domain”**</mark>
2. <mark style="color:green;">Enter the</mark> <mark style="color:green;"></mark><mark style="color:green;">**domain name**</mark> <mark style="color:green;"></mark><mark style="color:green;">you want to transfer (e.g.,</mark> <mark style="color:green;"></mark><mark style="color:green;">`yourdomain.com`</mark><mark style="color:green;">)</mark>
3.  <mark style="color:green;">The system will detect that the domain is in use elsewhere and prompt:</mark>

    > _<mark style="color:red;">"This domain is already being used in another tenant. You can request a transfer using a transfer token."</mark>_
4. <mark style="color:green;">You'll be asked:</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Do you have a transfer token?"**</mark>
   * <mark style="color:orange;">Click</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**“Yes”**</mark>
   * <mark style="color:orange;">Paste the</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**transfer token**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">you got from the source tenant PowerShell</mark>
5. <mark style="color:green;">Microsoft will now validate the token.</mark>
   * <mark style="color:orange;">If valid, the domain will be</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**queued for transfer**</mark><mark style="color:orange;">.</mark>
   * <mark style="color:orange;">Microsoft will release the domain from the old tenant and bind it to the new one.</mark>



**Step 3: Wait for the transfer to complete**

* <mark style="color:green;">This can take anywhere from</mark> <mark style="color:green;"></mark><mark style="color:green;">**a few minutes to several hours**</mark> <mark style="color:green;"></mark><mark style="color:green;">depending on DNS propagation and Microsoft’s backend checks.</mark>
* <mark style="color:green;">You'll receive confirmation once the domain has been successfully added to the new tenant.</mark>



{% hint style="danger" %}
#### Important Final Checks

* **Do NOT remove the domain from the source tenant manually.** Microsoft will handle this during the transfer.
* Ensure **no active users, groups, or services** (Exchange, Teams, etc.) are bound to that domain in the source tenant, or the transfer will fail.
* Once transferred, you may need to re-verify **DNS records** on your registrar for the target tenant.
{% endhint %}





***

## REFERENCES

* [https://learn.microsoft.com/en-us/microsoft-365/admin/get-help-with-domains/transfer-a-domain-from-microsoft-to-another-host?view=o365-worldwide](https://learn.microsoft.com/en-us/microsoft-365/admin/get-help-with-domains/transfer-a-domain-from-microsoft-to-another-host?view=o365-worldwide)
