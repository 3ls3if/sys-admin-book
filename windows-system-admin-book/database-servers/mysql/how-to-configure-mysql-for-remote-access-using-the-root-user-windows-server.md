---
icon: globe
---

# How to Configure MySQL for Remote Access Using the Root User (Windows Server)

### Introduction

By default, **MySQL** only allows the `root` user to connect from `localhost`. This is a security measure to prevent unauthorized remote access.

However, in some cases (development, internal servers, controlled environments), you may need to allow the `root` user to connect remotely.

This article provides a complete step-by-step guide to safely configure MySQL on Windows Server to allow remote access for the `root` user.

> ⚠️ Important: Allowing remote root access is not recommended for production environments exposed to the internet.

***

## Step 1: Log in to MySQL Locally

First, log in to MySQL directly from the server:

```
mysql -u root -p
```

Enter the root password when prompted.

***

## Step 2: Check Existing Root Accounts

Run the following query:

```
SELECT user, host FROM mysql.user WHERE user = 'root';
```

Typical output:

```
root | localhost
```

This means root can only connect from the local machine.

***

## Step 3: Create Remote Root Access

In MySQL, users are defined as:

```
'user'@'host'
```

So `root@localhost` and `root@'%'` are two different accounts.

To allow remote access from anywhere, create a new root entry:

```
CREATE USER 'root'@'%' IDENTIFIED BY 'YourCurrentRootPassword';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

Important:

* Use the **same existing root password**
* This does NOT modify `root@localhost`
* It simply adds a remote access version of root

Verify:

```
SELECT user, host FROM mysql.user WHERE user='root';
```

You should now see:

```
root | localhost
root | %
```

***

## Step 4: Configure MySQL to Listen on All Network Interfaces

Open the MySQL configuration file:

```
C:\ProgramData\MySQL\MySQL Server 8.0\my.ini
```

Find this line:

```
bind-address=127.0.0.1
```

Change it to:

```
bind-address=0.0.0.0
```

Save the file.

This allows MySQL to accept connections from external IP addresses.

***

## Step 5: Restart MySQL Service

Restart the MySQL service for changes to take effect.

Open Command Prompt as Administrator and run:

```
net stop MySQL80
net start MySQL80
```

Or use:

```
services.msc
```

Then restart the MySQL service manually.

***

## Step 6: Open Windows Firewall Port 3306

MySQL uses TCP port 3306.

1. Press `Win + R`
2. Type `wf.msc`
3. Click **Inbound Rules**
4. Click **New Rule**
5. Select **Port**
6. Choose **TCP**
7. Enter: `3306`
8. Allow the connection
9. Apply to appropriate profiles
10. Name the rule (e.g., MySQL 3306)

***

## Step 7: Configure Router or Cloud Firewall

If your server is behind a router:

* Forward port 3306 to the server’s internal IP address.

If using a VPS or cloud provider:

* Allow TCP port 3306 in the cloud security group or firewall.

***

## Step 8: Test Remote Connection

From another machine, test:

```
mysql -h YOUR_PUBLIC_IP -u root -p
```

If everything is configured correctly, the connection should succeed.

***

## Troubleshooting

#### Access denied for user 'root'@'IP'

* `root@'%'` was not created correctly
* Password mismatch

#### Connection timed out

* Firewall blocking port 3306
* Router not forwarding port
* `bind-address` still set to 127.0.0.1

#### Verify MySQL is Listening

On the server:

```
netstat -ano | findstr 3306
```

You should see:

```
0.0.0.0:3306
```

***

## Security Considerations

Allowing `root@'%'` means:

* Anyone on the internet can attempt login
* Automated bots scan port 3306 continuously
* Brute-force attacks are common

### Recommended Safer Alternative

Instead of exposing root:

```
CREATE USER 'adminuser'@'203.0.113.45' IDENTIFIED BY 'StrongPassword!';
GRANT ALL PRIVILEGES ON *.* TO 'adminuser'@'203.0.113.45' WITH GRANT OPTION;
```

Even better:

* Restrict by IP instead of `%`
* Use a VPN
* Use an SSH tunnel
* Disable remote root access after setup

***

## Final Checklist

✔ `root@'%'` created\
✔ `bind-address=0.0.0.0` configured\
✔ MySQL service restarted\
✔ Port 3306 open in firewall\
✔ Router or cloud firewall configured
