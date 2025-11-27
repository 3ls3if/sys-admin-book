---
icon: java
---

# JBoss: Install SSL Certificate

## How to Install SSL Certificate to JBoss

The steps outlined below will assist you in installing an SSL certificate on a JBoss Server. If you have not yet generated your certificate and finished the validation process, refer to our [CSR Generation Instructions ](https://www.https.in/support/kb/article/524759000000697263)before proceeding with the instructions below.

### Step 1: Install an SSL Certificate on JBoss Server

1. Obtain an SSL certificate from a trusted certificate authority.
2. Copy the SSL certificate and the private key file to the JBoss server.
3. Open the JBoss configuration file, standalone.xml or domain.xml, depending on the JBoss version and mode of operation.
4. Navigate to the section for the HTTPS connector and add the following attributes:

{% hint style="warning" %}
* ssl-enabled="true"
* scheme="https"
* secure="true"
* SSLEnabled="true"
* keystore-file="path/to/keystore"
* keystore-password="password"
* key-alias="alias"
{% endhint %}

5. Save the configuration file and restart the JBoss server.



### Step 2: Import the SSL Certificate on JBoss

1. If you are using JBoss EAP 7 or later, you will need to import the SSL certificate and private key into a Java keystore.
2. Use the `keytool` command to import the certificate into the keystore:

```
keytool -importcert -alias "alias name" -file cert.crt -keystore keystore.jks -storepass "store password"
```

3. Update the JBoss configuration file, standalone.xml or domain.xml, to use the Keystore that you just created.<br>
4. Restart the JBoss server for the changes to take effect.



### Step 3: Test your SSL Installation

1. Open a web browser and navigate to the JBoss server's URL using the https protocol ([https://yourdomain.com).](https://yourdomain.com\)/)
2. Check the SSL certificate is installed correctly by checking that the padlock icon is displayed, and that the certificate is issued by a trusted CA.
3. Verify that the certificate is valid and not expired by checking the expiration date of the certificate.
4. Check the SSL certificate is correctly configured by running the SSL Server Test by Qualys SSL Labs.
5. Check that your application is correctly redirecting HTTP requests to HTTPS requests.



***

## REFERENCES

* [https://www.https.in/support/kb/article/524759000000702231](https://www.https.in/support/kb/article/524759000000702231)
* [https://docs.jboss.org/jbossweb/3.0.x/ssl-howto.html](https://docs.jboss.org/jbossweb/3.0.x/ssl-howto.html)
* [https://docs.redhat.com/en/documentation/red\_hat\_jboss\_web\_server/3/html/installation\_guide/configuring\_the\_environment2](https://docs.redhat.com/en/documentation/red_hat_jboss_web_server/3/html/installation_guide/configuring_the_environment2)
