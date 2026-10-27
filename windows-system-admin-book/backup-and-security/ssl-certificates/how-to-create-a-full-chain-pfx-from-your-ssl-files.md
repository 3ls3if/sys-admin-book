---
icon: link-slash
---

# HOW TO CREATE A FULL-CHAIN PFX FROM YOUR SSL FILES

<figure><img src="../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
You have the **.crt**, **.p7b**, and **ca-bundle** files — good.

\
Since your API is failing with **“certificate signed by unknown authority”**, it means your server is **not presenting the full chain** (Root + Intermediate + Server cert).



To fix this, you must re-create a **proper PFX** that contains the _entire chain_ and then re-import it into IIS.

Below are the exact steps.
{% endhint %}



## **HOW TO CREATE A FULL-CHAIN PFX FROM YOUR FILES**

You have:

* **backoffice\_sbmcp1\_co\_in.crt** → Server certificate
* **backoffice\_sbmcp1\_co\_in.ca-bundle** → Intermediate + Root certificates
* **backoffice\_sbmcp1\_co\_in.p7b** → Certificate chain (can also be used to import intermediates)

The easiest correct method is:

***

## **METHOD 1: Use MMC to import chain + export correct PFX**

#### **STEP 1 — Open MMC**

1. Press **Win + R** → type `mmc` → Enter
2. Go to **File → Add/Remove Snap-in**
3. Add **Certificates (Computer account)**
4. Expand:

```
Certificates (Local Computer)
 └─ Personal
     └─ Certificates
```

***

#### **STEP 2 — Import certificates properly**

**2A — Import the server certificate (.crt)**

Right-click **Personal → Certificates → All Tasks → Import** → select:

* **backoffice\_sbmcp1\_co\_in.crt**

Finish the wizard.

***

**2B — Import the CA bundle (Root + Intermediate)**

You must import the CA bundle into two locations:

#### **→ Import into "Intermediate Certification Authorities"**

Right-click:

```
Certificates (Local Computer)
 └─ Intermediate Certification Authorities
     └─ Certificates
```

Import:

* **backoffice\_sbmcp1\_co\_in.ca-bundle**

#### **→ Import into "Trusted Root Certification Authorities"**

Right-click:

```
Certificates (Local Computer)
 └─ Trusted Root Certification Authorities
     └─ Certificates
```

Import the same **ca-bundle**.

***

#### **STEP 3 — Export a NEW PFX containing the full chain**

Go back to:

```
Certificates (Local Computer)
 └─ Personal
     └─ Certificates
```

Find your certificate → right-click → **All tasks → Export**\
Choose:

* **Yes, export the private key**
* **Include all certificates in the certification path (IMPORTANT)**
* Set password
* Save as **new\_fullchain.pfx**

***

## **METHOD 2: Use OpenSSL (if needed)**

If you want to build the full chain manually:

```
cat backoffice_sbmcp1_co_in.crt backoffice_sbmcp1_co_in.ca-bundle > fullchain.crt
```

Then convert to PFX:

```
openssl pkcs12 -export -out new_fullchain.pfx -inkey your_private_key.key -in fullchain.crt
```

(_Only works if you still have the private key!_)

***

## **FINAL STEP — Import full chain PFX into IIS**

1. Open **IIS Manager**
2. Go to **Server Certificates**
3. Click **Import**
4. Choose **new\_fullchain.pfx**
5. Go to **Bindings** for your site
6. Select HTTPS → Edit → Choose the newly imported certificate
7.  Restart site / IIS:

    ```
    iisreset
    ```

***

## Why your API was failing

Your first PFX was created **from IIS**, which only exported:\
✔ server certificate\
✘ NOT intermediates\
✘ NOT root

So the API client saw an incomplete chain → **“unknown authority”**.
