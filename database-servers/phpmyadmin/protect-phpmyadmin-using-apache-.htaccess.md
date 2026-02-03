---
icon: unlock
---

# Protect phpMyAdmin using Apache (.htaccess)

### ✅ Protect phpMyAdmin using Apache (.htaccess)

#### Step 1: Enable Apache auth modules (usually already enabled)

In XAMPP, this is normally ON by default. If phpMyAdmin loads at all, you’re fine.

***

### Step 2: Create a password file

#### Open Command Prompt as Administrator

Go to Apache bin directory:

```
cd C:\xampp\apache\bin
```

#### Create password file

```bash
htpasswd -c C:\xampp\phpMyAdmin\.htpasswd admin
```

* Enter a password when asked
* `admin` = Apache login username (you can change it)

⚠️ **Important:**\
Use `-c` **only the first time**.\
For adding more users later:

```bash
htpasswd C:\xampp\phpMyAdmin\.htpasswd user2
```

***

### Step 3: Create `.htaccess` in phpMyAdmin folder

Go to:

```
C:\xampp\phpMyAdmin\
```

Create a file named:

```
.htaccess
```

Put this inside it:

```apache
AuthType Basic
AuthName "Restricted Access"
AuthUserFile "C:/xampp/phpMyAdmin/.htpasswd"
Require valid-user
```

⚠️ Use **forward slashes** and full path.

***

### Step 4: Allow `.htaccess` overrides

Open:

```
C:\xampp\apache\conf\extra\httpd-xampp.conf
```

Find:

```apache
<Directory "C:/xampp/phpMyAdmin">
```

Make sure it contains:

```apache
AllowOverride All
```

Full example:

```apache
<Directory "C:/xampp/phpMyAdmin">
    AllowOverride All
    Require all granted
</Directory>
```

Save file.

***

### Step 5: Restart Apache

* Stop Apache
* Start Apache again

***

### 🎉 Result

Now when you visit:

```
http://localhost/phpmyadmin
```

You will see **Apache login popup** first 🔐\
Only after that will phpMyAdmin load (and then MySQL login if enabled).
