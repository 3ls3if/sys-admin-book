---
icon: copy
---

# Vhost Files

## Vhosts File

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
