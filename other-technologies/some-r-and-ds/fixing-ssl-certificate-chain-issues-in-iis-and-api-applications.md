---
icon: link-slash
---

# Fixing SSL Certificate Chain Issues in IIS and API Applications

## **Fixing SSL Certificate Chain Issues in IIS and API Applications**

When working with HTTPS on Windows IIS, it’s common to install an SSL certificate and see that websites load correctly in a browser—but external applications such as APIs, mobile apps, or backend services still fail with errors like:

```
SSL error : {error:0A000086:SSL routines::certificate verify failed}
tls: failed to verify certificate: x509: certificate signed by unknown authority
```

This type of error indicates that the SSL **certificate chain is incomplete** or **incorrectly installed**, even if your IIS website appears to work fine.

***

### **Why Does This Happen?**

Browsers like Chrome and Edge are very forgiving. They automatically download missing intermediate certificates from the issuing Certificate Authority (CA). However:

* **APIs**
* **Backend systems**
* **Mobile apps**
* **Linux servers**
* **Custom TLS clients**

…do _not_ automatically fetch missing intermediates.\
They require the **FULL certificate chain**—Root, Intermediate, and Server Certificate—properly installed on the server.

If the chain is missing, clients report:

* _certificate signed by unknown authority_
* _x509: certificate verify failed_
* _chain incomplete_

This is exactly your case.

***

### **Understanding Your Certificate Files**

You mentioned you have the following files:

* **.crt** → Server certificate
* **.ca-bundle** → Intermediate + Root certificates
* **.p7b (PKCS#7)** → Certificate chain (server + intermediate)

You previously installed only the `.crt` file in IIS, then exported a `.pfx` from it.\
But exporting from an incomplete installation **does not create a full PFX**—it produces a PFX missing the intermediate certificates.

This leads to API failures.

***

### **How to Fix the Issue Properly**

#### **Step 1: Install the P7B Certificate (Chain) Correctly**

1. Double-click the `.p7b` file
2. Click **Install Certificate**
3. Choose:
   * **Local Machine**
4. Select:
   * **Place all certificates in the following store**
5. Choose:
   * **Intermediate Certification Authorities**
6. Finish installation

This installs the intermediate certificates correctly.

***

#### **Step 2: Import the SSL Certificate as a Full Chain PFX**

If you already have a PFX created from the incomplete installation, **do NOT use it**.

Instead:

1. Open **IIS Manager**
2. Go to **Server Certificates**
3. Click **Import**
4. Select your **updated PFX** (or create a new PFX using the P7B + private key)
5. Import it

If you need to create a proper full-chain PFX, you can:

#### **Option A: Use OpenSSL to build a full chain PFX**

```
openssl pkcs12 -export \
  -out fullchain.pfx \
  -inkey yourdomain.key \
  -in yourdomain.crt \
  -certfile ca-bundle.crt
```

This generates a **complete** PFX file.

***

#### **Step 3: Rebind the Certificate in IIS**

1. Open **IIS Manager**
2. Choose your website / API application
3. Click **Bindings**
4. Select **https**
5. Choose **Edit**
6. Select the newly imported full-chain certificate

Save and restart IIS:

```
iisreset
```

***

### **Step 4: Test From an External Client**

Test using:

```
curl -Iv https://yourdomain.com
```

or from a backend application.

If the certificate chain is correct, you will no longer see:

```
x509: certificate signed by unknown authority
```

***

### **Why API Might Fail While Browser Works**

| Component                 | Behavior                                                       |
| ------------------------- | -------------------------------------------------------------- |
| **Browser (Chrome/Edge)** | Automatically downloads missing intermediates → appears fine   |
| **API backend / program** | Requires full chain from server → fails if incomplete          |
| **IIS**                   | Can show “valid” even if intermediate certificates are missing |

This is why your **IIS website worked**, but **API failed**.

***

### **Conclusion**

Your SSL issue occurs because IIS was installed with only the `.crt` server certificate, without the required intermediate certificates. The exported PFX was incomplete, causing the API to fail.

By reinstalling the certificate using the full chain (CRT + CA bundle / P7B), and reimporting it into IIS, your API will trust the certificate and work correctly.
