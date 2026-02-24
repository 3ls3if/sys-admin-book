---
icon: globe
---

# How to Configure PostgreSQL for Remote Access Using the Superuser (Windows Server)

### Introduction

By default, **PostgreSQL** only allows local connections. Remote access is disabled for security reasons.

In PostgreSQL, there is no `root` user like MySQL. The default administrative account is the **`postgres` superuser**.

This article explains step-by-step how to allow remote access for the `postgres` user (or any superuser) on a Windows Server.

> ⚠️ Important: Allowing remote superuser access is not recommended for production servers exposed to the internet.

***

## Step 1: Locate PostgreSQL Configuration Files

On Windows, PostgreSQL configuration files are typically located in:

```
C:\Program Files\PostgreSQL\15\data\
```

(Main files used:)

* `postgresql.conf`
* `pg_hba.conf`

To confirm the exact path, open psql locally and run:

```
SHOW config_file;
```

***

## Step 2: Allow PostgreSQL to Listen on External IP

Open:

```
postgresql.conf
```

Find:

```
#listen_addresses = 'localhost'
```

Change it to:

```
listen_addresses = '*'
```

Or restrict to a specific IP:

```
listen_addresses = '203.0.113.10'
```

Save the file.

This allows PostgreSQL to accept remote connections.

***

## Step 3: Configure Client Authentication (pg\_hba.conf)

Open:

```
pg_hba.conf
```

Add the following line at the bottom to allow remote superuser access from anywhere:

```
host    all     postgres     0.0.0.0/0     scram-sha-256
```

Explanation:

* `host` → TCP/IP connection
* `all` → all databases
* `postgres` → superuser
* `0.0.0.0/0` → any IP
* `scram-sha-256` → secure password authentication

⚠️ For better security, restrict to a specific IP:

```
host    all     postgres     203.0.113.45/32     scram-sha-256
```

Save the file.

***

## Step 4: Ensure the postgres User Has a Password

Log in locally:

```
psql -U postgres
```

Set or confirm password:

```
ALTER USER postgres WITH PASSWORD 'StrongPassword!';
```

***

## Step 5: Restart PostgreSQL Service

Restart the PostgreSQL service for changes to apply.

Open Command Prompt as Administrator:

```
net stop postgresql-x64-15
net start postgresql-x64-15
```

Or:

```
services.msc
```

Restart the PostgreSQL service manually.

***

## Step 6: Open Windows Firewall Port 5432

PostgreSQL uses TCP port 5432.

1. Press `Win + R`
2. Type: `wf.msc`
3. Click **Inbound Rules**
4. Click **New Rule**
5. Select **Port**
6. Choose **TCP**
7. Enter: `5432`
8. Allow connection
9. Apply to appropriate profiles
10. Name the rule (e.g., PostgreSQL 5432)

***

## Step 7: Configure Router or Cloud Firewall

If your server is behind a router:

Forward:

```
External Port: 5432
Internal IP: YourServerPrivateIP
Internal Port: 5432
Protocol: TCP
```

If using a VPS:

Allow port 5432 in the cloud firewall/security group.

***

## Step 8: Test Remote Connection

From another machine:

```
psql -h YOUR_PUBLIC_IP -U postgres -d your_database
```

If successful, remote access is working.

***

## Troubleshooting

#### Error: no pg\_hba.conf entry

* Missing or incorrect rule in `pg_hba.conf`

#### Error: password authentication failed

* Incorrect password
* Authentication method mismatch

#### Connection timed out

* Firewall blocking port 5432
* Router not forwarding
* listen\_addresses not set correctly

#### Verify PostgreSQL is Listening

On the server:

```
netstat -ano | findstr 5432
```

You should see:

```
0.0.0.0:5432
```

***

## Security Considerations

Allowing:

```
0.0.0.0/0
```

means:

* Anyone on the internet can attempt login
* Brute-force attacks are common
* Superuser access gives full database control

***

## Recommended Safer Alternative

Instead of exposing `postgres`:

Create a separate admin user:

```
CREATE ROLE adminuser WITH LOGIN PASSWORD 'StrongPassword!' SUPERUSER;
```

Then allow only that user in `pg_hba.conf`.

Even better:

* Restrict by IP
* Use VPN
* Use SSH tunnel
* Enable SSL connections

***

## Final Checklist

✔ `listen_addresses = '*'` configured\
✔ `pg_hba.conf` updated\
✔ postgres user has password\
✔ PostgreSQL service restarted\
✔ Port 5432 open in firewall\
✔ Router/cloud firewall configured
