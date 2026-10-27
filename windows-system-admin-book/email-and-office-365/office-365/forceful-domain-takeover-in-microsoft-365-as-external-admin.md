---
icon: stack-overflow
---

# Forceful Domain Takeover in Microsoft 365 as External Admin

You have purchased newly Microsoft 365 subscription and wants to add custom domain in your Microsoft 365 i.e. your business domain and you end up getting the error “_Other people in your organization have already signed up with domain.com email addresses. You need to sign up too and then verify that you’re the admin for the domain. We’ll send you an invitation and walk you through the process of becoming the admin._” This happens when someone signed up for other services provided by Microsoft such as Power Bi. You can either choose for internal admin takeover process as explained by Microsoft [here](https://docs.microsoft.com/en-us/microsoft-365/admin/misc/become-the-admin?view=o365-worldwide) or you can perform forceful domain takeover in Microsoft 365 as External Admin. It is quick process and also not typical.

## **Prerequisite for the Domain Takeover**

Below are some requirements that you should have:

* Access to the Domain Hosting to add records.
* Windows PowerShell and MSOnline module installed in it.
* Admin access of the tenant in which you want to add domain.

MSOnline module can be easily installed in PowerShell by running a single command.

### **Process to Forceful Domain Takeover in Microsoft 365**

Please follow the steps mentioned below to takeover domain forcefully in Microsoft 365.

* Run Windows PowerShell as administrator.
* Install Module MSOnline if not installed by running the below command.

| `Install-Module MSOnline` |
| ------------------------- |

* Run the below command to connect to Azure Ad and enter your Admin credentials.

| <p><code>$Msolcred = Get-credential</code> </p><p><code>Connect-MsolService -Credential $MsolCred</code></p> |
| ------------------------------------------------------------------------------------------------------------ |

* Once connected, enter the below command to add domain.

| `New-MsolDomain –name domain.com` |
| --------------------------------- |

* After addition of the domain, acquire the DnsTxt records.

| `Get-MsolDomainVerificationDns –DomainName domain.com –Mode DnsTxtRecord` |
| ------------------------------------------------------------------------- |

* Add these txt records to your domain hosting.
* Once done, run the below command to forcefully takeover domain in Microsoft 365 Tenant.

| `Confirm-MsolDomain –DomainName domain.com –ForceTakeover Force` |
| ---------------------------------------------------------------- |

* Now check the domain by running the below script.

| `Get-MsolDomain` |
| ---------------- |

This will work. It is so much easy with the PowerShell to takeover domain forcefully. By performing this step you can add domain in Office 365 if it was added to another Office 365 tenant.



## **Conclusion:**

In conclusion, performing a Forceful Domain Takeover in Microsoft 365 as an External Admin can be a powerful technique for gaining access and control over a domain. This article describes steps for domain addition forcefully and the prerequisites required to perform the process. I hope this article has provided with valuable insight. Feel free to reach out in case of any query.



***

## REFERRENCES

* [https://www.cloudbik.com/resources/blog/forceful-domain-takeover-in-microsoft-365/](https://www.cloudbik.com/resources/blog/forceful-domain-takeover-in-microsoft-365/)
