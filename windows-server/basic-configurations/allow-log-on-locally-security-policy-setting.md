---
icon: lock
---

# Allow log on locally - security policy setting

## Intro

To allow local user logins on a Windows Server, you need to configure the "<mark style="color:green;">**Allow log on locally**</mark>" security policy setting. This can be done through the Local Security Policy or by using Group Policy in a domain environment. By default, local users are not allowed to log on unless they are explicitly granted this right.&#x20;

## Location

<mark style="color:green;">`Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment`</mark>

## Using Local Security Policy

1. <mark style="color:green;">**Open Local Security Policy:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Press Win+R, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`secpol.msc`</mark><mark style="color:green;">, and press Enter.</mark>&#x20;
2. <mark style="color:green;">**Navigate to User Rights Assignment:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Expand "Local Policies," then "User Rights Assignment".</mark>&#x20;
3. <mark style="color:green;">**Locate and Edit "Allow log on locally":**</mark> <mark style="color:green;"></mark><mark style="color:green;">Double-click the policy setting named "Allow log on locally".</mark>&#x20;
4. <mark style="color:green;">**Add Users or Groups:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Click "Add User or Group," then "Add".</mark>&#x20;
5. <mark style="color:green;">**Specify Users/Groups:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Enter the names of the users or groups you want to allow to log on locally, and click "OK".</mark>&#x20;
6. <mark style="color:green;">**Apply Changes:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Close the Local Security Policy editor.</mark>

## Windows Server 2022

* <mark style="color:green;">Create a new user</mark>
* <mark style="color:green;">Add the user to the</mark> <mark style="color:red;">**Server Operator**</mark> <mark style="color:green;">group.</mark>
* <mark style="color:green;">That's it.</mark>

{% hint style="warning" %}
#### Possible values <a href="#possible-values" id="possible-values"></a>

* User-defined list of accounts
* Not Defined

**By default, the members of the following groups have this right on workstations and servers:**

* Administrators
* Backup Operators
* Users

**By default, the members of the following groups have this right on domain controllers:**

* Account Operators
* Administrators
* Backup Operators
* Enterprise Domain Controllers
* Print Operators
* Server Operators
{% endhint %}



***

## REFERENCES

* [https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/allow-log-on-locally](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/allow-log-on-locally)
