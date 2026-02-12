---
icon: copy
---

# Vhost Files

## Vhosts File (Custom Ports)

```
<VirtualHost *:8013>
    ServerName <domain>
    DocumentRoot "C:\xampp\htdocs"
<Directory "C:\xampp\htdocs">
        Options Indexes FollowSymLinks Includes ExecCGI
        AllowOverride All
        Require all granted
</Directory>
    ErrorLog "logs/flexerp-error.log"
    CustomLog "logs/flexerp-access.log" combined
</VirtualHost>
 
<VirtualHost *:4443>
    ServerName <domain>
    DocumentRoot "C:\xampp\htdocs"
<Directory "C:\xampp\htdocs">
        Options Indexes FollowSymLinks Includes ExecCGI
        AllowOverride All
        Require all granted
</Directory>
```

```
cd C:\xampp\apache\bin httpd.exe -t -D DUMP_INCLUDES
```



***

## Vhosts File (Proxy to Tomcat)

```
<VirtualHost *:80>
    ServerName example.com
 
    # Serve .well-known/acme-challenge locally
    Alias /.well-known/acme-challenge/ "C:/xampp/.well-known/acme-challenge/"
<Directory "C:/xampp/.well-known/acme-challenge/">
        Options None
        AllowOverride None
        Require all granted
</Directory>
 
    # Enable mod_rewrite
    RewriteEngine On
 
    # Redirect root / to /Fisheries/
    RewriteCond %{REQUEST_URI} ^/$
    RewriteRule ^/$ /Fisheries/ [R=301,L]
 
    # Exclude .well-known from proxy
    ProxyPassMatch ^/.well-known !
 
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/
 
 
    ErrorLog "logs/fishexptv-error.log"
    CustomLog "logs/fishexptv-access.log" common
</VirtualHost>
 
<VirtualHost *:443>
    ServerName example.com
 
    SSLEngine on
    SSLCertificateFile "C:\free_ssl\crt.pem"
    SSLCertificateKeyFile "C:\free_ssl\key.pem"
    SSLCertificateChainFile "C:\free_ssl\chain.pem"
 
    # Serve .well-known/acme-challenge locally (optional, for renewal)
    Alias /.well-known/acme-challenge/ "C:/xampp/.well-known/acme-challenge/"
<Directory "C:/xampp/.well-known/acme-challenge/">
        Options None
        AllowOverride None
        Require all granted
</Directory>
 
    # Enable mod_rewrite
    RewriteEngine On
 
    # Redirect root / to /Fisheries/
    RewriteCond %{REQUEST_URI} ^/$
    RewriteRule ^/$ /Fisheries/ [R=301,L]
 
    ProxyPreserveHost On
    #ProxyPass / http://localhost:8080/fishexptv/
    #ProxyPassReverse / http://localhost:8080/fishexptv/
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/
 
 
    ErrorLog "logs/fishexptv-error.log"
    CustomLog "logs/fishexptv-access.log" common
</VirtualHost>
```

***

## Add Redirect Rule to Force HTTPS

```
<VirtualHost *:80>
    ServerName example.com
    DocumentRoot "C:\xampp\htdocs\example.com"

    # Redirect all HTTP traffic to HTTPS
    Redirect / https://example.com/

    <Directory "C:\xampp\htdocs\example.com">
        Options Indexes FollowSymLinks Includes ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog "logs/lexaone-error.log"
    CustomLog "logs/lexaone-access.log" combined
</VirtualHost>
```
