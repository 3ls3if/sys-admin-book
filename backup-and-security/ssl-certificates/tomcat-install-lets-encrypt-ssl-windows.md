---
icon: cat
---

# Tomcat: Install Let's Encrypt SSL-Windows

{% hint style="warning" %}
**Note:** Be Sure that you Internal port is map with external port are same like 80:80 & 443:443
{% endhint %}

## Step 1: Install CertBot Latest Version from

[https://dl.eff.org/certbot-beta-installer-win32.exe](https://dl.eff.org/certbot-beta-installer-win32.exe)

## Step 2: Install OpenSSL From

[https://slproweb.com/products/Win32OpenSSL.html](https://slproweb.com/products/Win32OpenSSL.html)

## Step 3: Step Add Enviroment variable of openssl

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*YxbT4FYUZWtW1FExo4vKSA.png" alt="" height="394" width="700"><figcaption></figcaption></figure>

## Step4: Stop Tomcat

## Step5: Run Command

```
certbot certonly — standalone -d your.domain.com
```

## Step6:

Create Folder and copy all certificat from `C:\Certbot\live\your.domain.com` to `C:\Lets`

## Step7: Now Copy _cert.pem chain.pem fullchain.pem in all.pem like this_

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*3M-1rh0G2dp_PNEtLMddYQ.png" alt="" height="443" width="700"><figcaption></figcaption></figure>

## Step8: Run Command for pem to p12 file

{% columns %}
{% column width="0%" %}
```
openssl pkcs12 -export -name hops -in all.pem -inkey privkey.pem -out p12keystore.p12
```
{% endcolumn %}

{% column %}
```
openssl pkcs12 -export -name hops -in all.pem -inkey privkey.pem -out p12keystore.p12
```
{% endcolumn %}
{% endcolumns %}

**Give Password : — password**

## Step8:- Run Command p12 To JDK

```
keytool -importkeystore -srckeystore p12keystore.p12 -srcstoretype pkcs12 -deststoretype pkcs12 -alias hops -destkeystore hops.jks
```

**Give Password : — password**

## Step9:- Apply JKS and SSL connector Setting in Tomcat server.xml File

Open File of server.xml

```
C:\Program Files\Apache Software Foundation\Tomcat 9.0\conf\server.xml
```

Update below details

<pre><code>&#x3C;Connector port=”443" protocol=”HTTP/1.1" maxThreads=”150" SSLEnabled=”true” connectionTimeout=”20000" >
<strong>    &#x3C;SSLHostConfig>
</strong>        &#x3C;Certificate certificateKeystoreFile=”C:\Lets\hops.jks”
        certificateKeystorePassword=”password”
        type=”RSA” />
    &#x3C;/SSLHostConfig>
&#x3C;/Connector>
</code></pre>

Save & Exit

{% hint style="warning" %}
\[Note — certificateKeystorePassword=”password” (This password is same as When run Openssl or Keytool Command)]
{% endhint %}

## Step 10: Start Tomcat Service for Effect of SSL Renew



***

## REFERENCES

* [https://neerajpaliwal13021996.medium.com/lets-encrypt-in-windows-for-tomcat-9-0-x-5548405d91d0](https://neerajpaliwal13021996.medium.com/lets-encrypt-in-windows-for-tomcat-9-0-x-5548405d91d0)
