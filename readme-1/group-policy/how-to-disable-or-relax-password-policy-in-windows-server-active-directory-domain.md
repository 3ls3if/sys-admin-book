---
icon: windows
---

# How to Disable or Relax Password Policy in Windows Server (Active Directory Domain)

{% hint style="warning" %}
#### **Important:**

You _cannot completely_ remove the password policy, but you _can_ set it to minimal values so it behaves like “disabled.”
{% endhint %}

### **Method 1 — Change Password Policy in Default Domain Policy**

#### Open Group Policy Management

On your domain controller:

* Press **Win + R**
* Type: `gpmc.msc`
* Press **Enter**

#### Edit the Default Domain Policy

Navigate to:

```
Forest  
 └── Domains  
      └── yourdomain.local  
            └── Default Domain Policy
```

Right-click **Default Domain Policy → Edit**

#### Go to Password Policy

Inside the GPO editor:

```
Computer Configuration  
 └── Policies  
      └── Windows Settings  
           └── Security Settings  
                └── Account Policies  
                     └── Password Policy
```

#### Set all password requirements to the minimum

Configure:

| Setting                                         | Set to                     |
| ----------------------------------------------- | -------------------------- |
| **Enforce password history**                    | 0                          |
| **Maximum password age**                        | 0 (password never expires) |
| **Minimum password age**                        | 0                          |
| **Minimum password length**                     | 0                          |
| **Password must meet complexity requirements**  | Disabled                   |
| **Store passwords using reversible encryption** | Disabled                   |

This effectively removes constraints so Entra ID password changes synchronize freely.

#### Update policy

Run on the domain controller or client:

```
gpupdate /force
```
