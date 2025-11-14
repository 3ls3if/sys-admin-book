---
icon: piggy-bank
---

# How to Generate an SSL Certificate CSR as per HDFC Bank’s Updated Security Requirements

## **How to Generate an SSL Certificate CSR as per HDFC Bank’s Updated Security Requirements**

With HDFC Bank implementing enhanced security protocols in their TLS handshake process, organizations integrating with HDFC APIs or payment gateways must now generate SSL certificates that explicitly include **Client Authentication** in addition to the standard **Server Authentication** parameters.

This article provides a clear, step-by-step guide on how to generate a CSR (Certificate Signing Request) and private key that comply with HDFC Bank’s requirements.

***

### **Why Has HDFC Updated the Requirement?**

HDFC has recently introduced additional verification during mutual TLS (mTLS) handshaking.\
Earlier, most CSR files only included:

* **TLS Web Server Authentication**

However, HDFC now mandates:

* **TLS Web Client Authentication**

This is because HDFC’s new mTLS process requires both:

1. **Server validates the client**, and
2. **Client validates the server**

Your SSL certificate must therefore include `extendedKeyUsage = clientAuth`.

***

### **What Happens If You Use a Certificate Without Client Authentication?**

If the certificate _does not_ include client authentication:

* HDFC’s server will reject the handshake
* You may see errors such as:
  * _“Handshake Failure”_
  * _“Client certificate not provided”_
  * _“Unsupported certificate purpose”_
* API communication will fail

This was the root cause in many recent integration issues observed with clients.

***

### **Prerequisites Before Generating the CSR**

You must have:

1. A Linux/Windows/Mac system with **OpenSSL** installed
2. Your **domain name** (CN / FQDN)
3. The organization details required for generating the CSR
4. The correct **OpenSSL configuration file** containing extended key usage

***

## **Step-by-Step Guide to Generate a CSR with Client Authentication (HDFC Compliant)**

***

### **Step 1: Create an OpenSSL Configuration File**

Create a file named **openssl.cnf** with the following content:

```ini
[ req ]
default_bits       = 2048
prompt             = no
default_md         = sha256
req_extensions     = req_ext
distinguished_name = dn

[ dn ]
C  = IN
ST = State
L  = City
O  = Your Company Name
OU = IT
CN = yourdomain.com

[ req_ext ]
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, serverAuth
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = yourdomain.com
```

#### **Important:**

The line

```
extendedKeyUsage = clientAuth, serverAuth
```

is mandatory to meet HDFC’s new requirement.

***

### **Step 2: Generate the Private Key**

Run:

```bash
openssl genrsa -out client.key 2048
```

***

### **Step 3: Generate the CSR Using the Config File**

Run:

```bash
openssl req -new -key client.key -out client.csr -config openssl.cnf
```

This will generate:

* **client.key** → Your private key
* **client.csr** → CSR to be shared with the Certificate Authority (CA)

***

### **Step 4: Confirm the CSR Includes Client Authentication**

Verify via:

```bash
openssl req -in client.csr -text -noout | grep -A1 "Extended Key Usage"
```

You must see:

```
X509v3 Extended Key Usage:
    TLS Web Client Authentication, TLS Web Server Authentication
```

If **clientAuth** is missing, the CSR will NOT be accepted by HDFC systems.

***

### **Step 5: Submit CSR to the CA**

Provide **client.csr** to your SSL provider (e.g., Sectigo, DigiCert, GoDaddy).\
Once signed, they will provide:

* **Root certificate**
* **Intermediate certificate**
* **Leaf certificate (client certificate)**

Make sure the final certificate also contains:

✔ TLS Web Client Authentication\
✔ TLS Web Server Authentication

***

## **Frequently Asked Questions**

***

#### **1. Can I use my existing root, intermediate, or leaf certificates?**

No.\
Certificates issued earlier **without clientAuth** support will not pass HDFC validation.

***

#### **2. Do changes need to be made on the server?**

Yes.

Your server (application / payment gateway integration server) must be updated to:

* Use the new **private key**
* Install the new **certificate chain**
* Enable **mutual TLS (mTLS)**

***

#### **3. What is client.crt?**

`client.crt` is the **signed certificate** issued by the CA using the CSR you generated.\
This certificate is used by your server to authenticate itself to HDFC during mTLS.

***

## **Conclusion**

With HDFC Bank enforcing stricter mTLS-based security, it is now essential to generate CSR files that explicitly include **Client Authentication** support.\
Following the above steps ensures your CSR and final SSL certificate meet the required security standards and prevent handshake failures.

If you need assistance, feel free to contact your SSL provider or technical support team.
