---
icon: abacus
---

# Vhost for SSL Validation

```
<VirtualHost *:80>
    ServerName skmusiccollegesupaul.com
 
 
    # Serve .well-known/acme-challenge locally
    Alias /.well-known/acme-challenge/ "C:/xampp/.well-known/acme-challenge/"
<Directory "C:/xampp/.well-known/acme-challenge/">
        Options None
        AllowOverride None
        Require all granted
</Directory>
 
    # Enable mod_rewrite
    RewriteEngine On
 
 
    # Exclude .well-known from proxy
    ProxyPassMatch ^/.well-known !
 
    ProxyPreserveHost On
 
    # Proxy requests to the Laravel application
    ProxyPass        / http://127.0.0.1:9001/
    ProxyPassReverse / http://127.0.0.1:9001/
 
    ErrorLog  "logs/reverse-proxy-error.log"
    CustomLog "logs/reverse-proxy-access.log" common
</VirtualHost>
 
```

```
<VirtualHost *:443>
    ServerName skmusiccollegesupaul.com
 
    SSLEngine on
    SSLCertificateFile "C:\skmusiccollegesupaul_ssl\crt.pem"
    SSLCertificateKeyFile "C:\skmusiccollegesupaul_ssl\-key.pem"
    SSLCertificateChainFile "C:\skmusiccollegesupaul_ssl\chain.pem"
 
    # Serve .well-known/acme-challenge locally
    Alias /.well-known/acme-challenge/ "C:/xampp/.well-known/acme-challenge/"
<Directory "C:/xampp/.well-known/acme-challenge/">
        Options None
        AllowOverride None
        Require all granted
</Directory>
 
    # Enable mod_rewrite
    RewriteEngine On
 
 
    # Exclude .well-known from proxy
    ProxyPassMatch ^/.well-known !
 
    ProxyPreserveHost On
 
    # Proxy requests to the Laravel application
    ProxyPass        / http://127.0.0.1:9001/
    ProxyPassReverse / http://127.0.0.1:9001/
 
    ErrorLog  "logs/reverse-proxy-error.log"
    CustomLog "logs/reverse-proxy-access.log" common
</VirtualHost>
```
