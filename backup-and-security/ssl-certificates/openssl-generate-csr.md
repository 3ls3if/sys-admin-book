---
icon: osi
---

# OpenSSL: Generate CSR

## Introduction

A **Certificate Signing Request (CSR)** is a crucial step in obtaining an SSL/TLS certificate for securing websites, servers, or other network services. The CSR contains encoded information about the organization, domain, and public key, which is used by a Certificate Authority (CA) to issue a digital certificate.

**OpenSSL** is a widely used open-source tool for cryptographic operations, including generating CSRs. On a **Windows Server**, OpenSSL can be installed and used to create a **4096-bit CSR**, ensuring strong encryption and security.

## Prerequisites

* <mark style="color:green;">OpenSSL installed on the Windows Server. If not installed, it can be downloaded from</mark> [<mark style="color:green;">OpenSSL for Windows</mark>](https://openssl-library.org/source/)<mark style="color:green;">.</mark>
* <mark style="color:green;">Administrative access to the server.</mark>
* <mark style="color:green;">A valid domain name for the SSL certificate.</mark>

## CSR Generation Process

The process involves two key steps:

1. <mark style="color:green;">Generating a</mark> <mark style="color:green;"></mark><mark style="color:green;">**private key**</mark> <mark style="color:green;"></mark><mark style="color:green;">(4096-bit or Other).</mark>
2. <mark style="color:green;">Creating a</mark> <mark style="color:green;"></mark><mark style="color:green;">**CSR**</mark> <mark style="color:green;"></mark><mark style="color:green;">using the private key.</mark>

{% hint style="warning" %}
After generating the CSR, it must be submitted to a **Certificate Authority (CA)** like DigiCert, Let's Encrypt, or GoDaddy for SSL certificate issuance.
{% endhint %}



***

## Practical

### <mark style="color:orange;">Step 1: Generate a Private Key (4096-bit)</mark>

Open Command Prompt (`cmd`) as Administrator and run:

```
openssl genrsa -out domain_private.key 4096
```

### <mark style="color:orange;">Step 2: Generate the CSR (Certificate Signing Request)</mark>

Run the following command:

```
openssl req -new -key domain_private.key -out domain.csr
```

{% hint style="success" %}
I**t will prompt you to enter details such as:**

* **Country Name** (e.g., `IN`)
* **State or Province Name** (e.g., `ASSAM`)
* **Locality Name** (e.g., `Guwahati`)
* **Organization Name** (e.g., `My Company Ltd`)
* **Organizational Unit Name** (e.g., `IT Department`)
* **Common Name** (e.g., `www.example.com`)
* **Email Address** (optional)
* **A Challenge Password** (leave empty by pressing Enter)
* **An Optional Company Name** (leave empty by pressing Enter)
{% endhint %}

### <mark style="color:orange;">Step 3: Verify the CSR</mark>

After generating the CSR, verify it using:

```
openssl req -text -noout -verify -in domain.csr
```

This displays the CSR details and ensures everything is correct.



{% hint style="warning" %}
## Export Public Key from CRT file

openssl x509 -in certificate.crt -pubkey -noout
{% endhint %}

***

## REFERENCES

* [https://openssl-library.org/source/](https://openssl-library.org/source/)
* [https://phoenixnap.com/kb/generate-openssl-certificate-signing-request](https://phoenixnap.com/kb/generate-openssl-certificate-signing-request)

