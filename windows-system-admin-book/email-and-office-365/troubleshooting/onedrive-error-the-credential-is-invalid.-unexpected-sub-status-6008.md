---
icon: google-drive
---

# OneDrive Error: The credential is invalid. Unexpected sub status (6008)

## Error message "The credential is invalid. Unexpected sub status (6008)

{% hint style="warning" %}
Receiving error when logging on to onedrive application:

Error: Something went wrong. \[657rx]

Message "The credential is invalid. Unexpected sub status (6008)

Tag: 657rx

Code: 2148073494
{% endhint %}

## Option 1: Remove Microsoft Account

1. &#x20;**Sign Out from All Microsoft Apps** &#x20;
   * <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Microsoft Edge**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**Office apps**</mark> &#x20;
   * <mark style="color:green;">Sign out from your old work account and ensure your personal account is set as the default</mark>&#x20;
2. **Disconnect Work or School account**&#x20;

* <mark style="color:green;">**Open Settings**</mark> <mark style="color:green;"></mark><mark style="color:green;">->Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Accounts**</mark> <mark style="color:green;"></mark><mark style="color:green;">– Click on</mark> <mark style="color:green;"></mark><mark style="color:green;">**Accounts**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Access work or school**</mark><mark style="color:green;">.</mark> &#x20;
* <mark style="color:green;">**Find the Account**</mark> <mark style="color:green;"></mark><mark style="color:green;">– Locate the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Work or School account**</mark> <mark style="color:green;"></mark><mark style="color:green;">you want to remove.</mark> &#x20;



***

## Option 2: **Remove the Account from Windows Credentials**

Sometimes, Windows stores old login details in the **Credential Manager**, which can cause repeated sign-in attempts. &#x20;

* <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Windows + S**</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">**Credential Manager**</mark><mark style="color:green;">, and open it.</mark> &#x20;
* <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Windows Credentials**</mark> &#x20;
* <mark style="color:green;">Look for any entries related to your old work or Microsoft 365 account (e.g., MicrosoftOffice16\_Data:</mark>
* <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Remove**</mark> <mark style="color:green;"></mark><mark style="color:green;">on those entries</mark>&#x20;

{% hint style="warning" %}
**Reset OneDrive Credentials**

1.  Press `Win + R`, type:

    ```
    control /name Microsoft.CredentialManager
    ```
2. In Credential Manager, go to **Windows Credentials**.
3. Find anything related to **OneDrive**, **MicrosoftAccount**, or **Office**, and **remove them**.
4. Restart your computer.
5. Try logging into OneDrive again.
{% endhint %}



***

## **Option 3: Clear Cached Credentials in the Registry** &#x20;

If the issue persists, there may be cached data in the registry. &#x20;

* <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Windows + R**</mark><mark style="color:green;">, type regedit, and press Enter</mark> &#x20;
* <mark style="color:green;">Navigate to:</mark>  \ <mark style="color:green;">HKEY\_CURRENT\_USER\Software\Microsoft\Office\\</mark>
* <mark style="color:green;">Look for folders/names matching your old work account and delete them</mark>&#x20;



***

## REFERENCES

* [https://answers.microsoft.com/en-us/msteams/forum/all/error-message-the-credential-is-invalid-unexpected/467421ed-829e-4e3e-a2ad-9d7fc69f8666](https://answers.microsoft.com/en-us/msteams/forum/all/error-message-the-credential-is-invalid-unexpected/467421ed-829e-4e3e-a2ad-9d7fc69f8666)

