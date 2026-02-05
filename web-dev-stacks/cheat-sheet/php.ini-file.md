# PHP.INI File

```
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BASIC PATHS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
extension_dir = "C:\php-8.2.28\ext\"
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CORE SETTINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
engine = On
short_open_tag = Off
output_buffering = 4096
max_execution_time = 300
max_input_time = 500
memory_limit = 1024M
post_max_size = 512M
upload_max_filesize = 300M
max_input_vars = 10000
file_uploads = On
allow_url_fopen = On
default_charset = "UTF-8"
 
 
upload_tmp_dir = "C:\Windows\temp"
sys_temp_dir = "C:\Windows\temp"
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ERROR HANDLING (DEV)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
display_errors = Off
display_startup_errors = On
log_errors = On
error_reporting = E_ALL
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; REQUIRED EXTENSIONS (WORDPRESS + PHPMYADMIN)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
extension=curl
extension=mbstring
extension=mysqli
extension=openssl
extension=zip
extension=fileinfo
 
; SQL SERVER EXTENSIONS
;extension=php_sqlsrv_82_ts_x64.dll
;extension=php_pdo_sqlsrv_82_ts_x64.dll
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SESSION (VERY IMPORTANT)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
session.save_handler = files
session.save_path = "C:\Windows\Temp\"
session.use_cookies = 1
session.use_only_cookies =
 
[PHP]
error_log = "C:\Windows\Temp\PHP_via_FastCGI_errors.log"
upload_tmp_dir = "C:\Windows\Temp\"
cgi.force_redirect = 0
cgi.fix_pathinfo = 1
fastcgi.impersonate = 1
max_file_uploads = 20
fastcgi.logging = 0
 
[Date]
date.timezone = "Asia/Kolkata"
[PHP_CURL]
extension=php_curl.dll
[PHP_GETTEXT]
extension=php_gettext.dll
[PHP_MYSQLI]
extension=php_mysqli.dll
[PHP_MBSTRING]
extension=php_mbstring.dll
[PHP_OPENSSL]
extension=php_openssl.dll
[PHP_SOAP]
extension=php_soap.dll
[PHP_GD]
extension=php_gd.dll
```
