---
icon: id-badge
---

# Understanding Exchange Online Plan 2 Licensing and Its Impact on Microsoft 365 Mailbox Features

Microsoft 365 (M365) offers a wide range of licensing options, and many users are unsure how individual service plans—such as **Exchange Online Plan 2**—interact with existing Microsoft 365 subscriptions like **Business Basic**. This article explains how Exchange Online Plan 2 works, whether Microsoft Teams is included, and what happens to mailbox storage when combining licenses.

***

### **Can You Assign Exchange Online Plan 2 Directly to a Microsoft 365 Mail Account?**

**Yes.**\
Exchange Online Plan 2 can be assigned directly to any user in the Microsoft 365 Admin Center. This plan enhances that user’s mailbox capabilities by providing advanced email features, including:

* **100 GB primary mailbox**
* **Archive mailbox**
* **Auto-expanding archive (up to \~1.5 TB)**
* **Advanced compliance features** such as retention policies and DLP

#### **Important Licensing Notes**

* If the user already has a license that includes Exchange Online (for example, Business Basic or Office 365 E1), then **you must ensure there are no conflicting Exchange plans**.\
  Often this means disabling the Exchange Online component of the previous license.
* You do **not** need a full Microsoft 365 suite license to assign Exchange Online Plan 2—this can be purchased independently.

***

### **Does Exchange Online Plan 2 Include Microsoft Teams?**

**No — Microsoft Teams is&#x20;**_**not**_**&#x20;included with Exchange Online Plan 2.**

Exchange Online Plan 2 only provides email-related features.\
To access Teams, a user must have one of the following licenses:

* **Microsoft 365 Business Basic**
* **Microsoft 365 Business Standard**
* **Microsoft 365 Business Premium**
* **Office 365 E1 / E3 / E5**
* **Microsoft 365 E3 / E5**

If a user only has Exchange Online Plan 2, they will **not** be able to sign into Teams.

***

### **Mailbox Storage: Business Basic + Exchange Online Plan 2**

Many users wonder whether combining Business Basic (which includes a 50 GB mailbox) with Exchange Online Plan 2 (which includes a 100 GB mailbox) results in:

✔️ 150 GB mailbox\
or\
✔️ 100 GB mailbox\
or\
✔️ something else entirely?

#### **Correct Answer: The mailbox becomes 100 GB, not 150 GB.**

Here’s why:

| License Component        | Mailbox Size                            |
| ------------------------ | --------------------------------------- |
| Business Basic (default) | 50 GB                                   |
| Exchange Online Plan 2   | 100 GB                                  |
| Archive Mailbox          | Enabled (Auto-expanding up to \~1.5 TB) |

When Exchange Online Plan 2 is assigned, **its mailbox limits override the smaller mailbox included in Business Basic**. You do not “stack” sizes—Microsoft uses the highest available mailbox capacity from any assigned license.

#### **What About 150 GB?**

150 GB active mailbox is only possible in certain Enterprise plans (E3/E5) with the appropriate archive configuration. It does _not_ apply to Business Basic + EOP2.

***

### **Summary**

| Feature                 | Exchange Online Plan 2 | M365 Business Basic | Combined                           |
| ----------------------- | ---------------------- | ------------------- | ---------------------------------- |
| Primary Mailbox Size    | **100 GB**             | 50 GB               | **100 GB**                         |
| Archive Mailbox         | Yes                    | Yes                 | **Yes (up to \~1.5 TB)**           |
| Microsoft Teams         | ❌ No                   | ✔️ Yes              | ✔️ Yes (Business Basic adds Teams) |
| Email Advanced Features | ✔️ Advanced            | Basic               | ✔️ Advanced                        |

***

### **Final Recommendation**

If you want a user to:

* Have a **100 GB mailbox**
* Use **Teams**
* Get archive mailbox features
* Use Microsoft 365 cloud services

Then assign:

#### **✔️ Microsoft 365 Business Basic**

**+**

#### **✔️ Exchange Online Plan 2**

This combination gives the user both **Teams access** and **enhanced mailbox capabilities**.
