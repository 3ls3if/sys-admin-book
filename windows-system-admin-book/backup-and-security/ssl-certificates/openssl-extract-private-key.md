---
icon: lock-open
---

# OpenSSL: Extract Private Key

#### **1. Extract the Private Key**

```bash
openssl pkcs12 -in yourfile.pfx -nocerts -out private.key
```

* You’ll be prompted for the PFX password.
* This exports the private key in encrypted format.

**If you want an unencrypted private key** (optional):

```bash
openssl rsa -in private.key -out private_unencrypted.key
```

***

#### **2. Extract the Certificate**

```bash
openssl pkcs12 -in yourfile.pfx -clcerts -nokeys -out certificate.crt
```

* This will extract the client certificate and exclude the private key.

***

#### **3. (Optional) Extract the CA Chain**

```bash
openssl pkcs12 -in yourfile.pfx -cacerts -nokeys -chain -out ca_bundle.crt
```

***

**4. Verify the Certificate**

```bash
bashCopyEditopenssl x509 -in certificate.crt -text -noout
```

To verify if the certificate and private key match:

```bash
bashCopyEditopenssl x509 -noout -modulus -in certificate.crt | openssl md5
openssl rsa -noout -modulus -in private.key | openssl md5
```

* If the MD5 hashes match, your certificate and key match.



***

## REFERENCES

* [https://betterstack.com/community/questions/how-to-convert-pem-to-crt-and-key/](https://betterstack.com/community/questions/how-to-convert-pem-to-crt-and-key/)
