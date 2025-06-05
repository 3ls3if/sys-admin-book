---
icon: java
---

# JBoss Web Server: CSR Generation

## CSR Generation Steps JBOSS

In order to generate a keystore for your JBoss system perform the following instructions listed below.\


### **Step 1: Create a Keystore:**



1. Create a certificate keystore and private key by executing the following command:

{% hint style="warning" %}
Note: You will specify a Privatkey Alias. This Alias will be used for CSR creation and eventually installation of the SSL Certificate.
{% endhint %}

```
keytool -genkey -alias create_Privatkey_Alias -keyalg RSA -keystorepath_and_create_KeystoreFilename.jks –keysize 2048
```

\
**Example:**

<figure><img src="https://desk.zoho.com/galleryDocuments/edbsn073cfea2e1510dbc4f1b6cb4f1740a749a8328e0ade257e548fca869bce31bc91dc51cb8767ac6b14493a93cce5c17ca?inline=true" alt=""><figcaption></figcaption></figure>

2. **Enter and re-enter a keystore password**

{% hint style="warning" %}
Note: You will need to use this custom password later for installation and to configure the Tomcat server.xml configuration file. In addition, remember your Alias Name for your private key. you will require it for installation.
{% endhint %}



3. **Fill out the applicable information:**
   1. First and Last Name? or Common Name (CN):   The Common Name is the Host + Domain Name. It looks like “ www.mydomain.com” or “company.com”.
   2. Organizational Unit (OU): This field is optional; but can be used to help identify certificates registered to an organization. The Organizational Unit (OU) field is the name of the department or organization unit making the request.
   3. Organization (O): If your company or department has an &, @, or any other symbol using the shift key in its name, you must spell out the symbol or omit it to enroll.  Example: XY & Z Corporation would be XYZ Corporation
   4. Locality or City (L): The Locality field is the city or town name, for example: Boston
   5. State or Province (S): Spell out the state completely; do not abbreviate the state or province name, for example: New York
   6.  Country Name (C): Use the two-letter code without punctuation for country, for example: US or CA.\
       \


       <figure><img src="https://desk.zoho.com/galleryDocuments/edbsn079146678ef13d5d3fc556ac9a54183417fa34bdd9f3654ba7638f6ed5e0ecd5b523ccfdbad26706a39af67b6ca394d6?inline=true" alt=""><figcaption></figcaption></figure>
4. **Confirm or reject the details by typing “Yes” or “No” and press Enter.**\


### Step 2: Creating your CSR from your keystore:

1. The CSR is then created using the following command:
2. `keytool -certreq -keyalg RSA -alias your_privatekey_alias -file your_csr_file.csr -keystore your_keystore_filename.jks`
3. Create a copy of the keystore file. Having a back-up file of the keystore at this point can help resolve installation issues that can occur when importing the certificate into the original keystore file.
4. To copy and paste the file `certreq.csr` into the enrollment form, open the file in a text editor that does not add extra characters (Notepad or Vi are recommended).

{% hint style="warning" %}
Your CSR request has been created&#x20;
{% endhint %}



***

## REFERENCES

* [https://www.https.in/support/kb/article/524759000000697263](https://www.https.in/support/kb/article/524759000000697263)
* [https://docs.jboss.org/jbossweb/3.0.x/ssl-howto.html](https://docs.jboss.org/jbossweb/3.0.x/ssl-howto.html)
* [https://docs.redhat.com/en/documentation/red\_hat\_jboss\_web\_server/3/html/installation\_guide/configuring\_the\_environment2](https://docs.redhat.com/en/documentation/red_hat_jboss_web_server/3/html/installation_guide/configuring_the_environment2)
