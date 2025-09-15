---
icon: wifi-slash
---

# Connection Failed: Error

{% hint style="warning" %}
Connection failed: connection to server at "192.168.\*.\*", port 5432 failed: FATAL: no pg\_hba.conf entry for host "10.0.4.1", user "Help-Desk", database "Help-Desk-Stg", no encryption
{% endhint %}

#### Step 1: Edit `pg_hba.conf`

1.  Go to the PostgreSQL data directory.\
    By default, it’s usually here:

    ```
    C:\Program Files\PostgreSQL\<version>\data\
    ```

    (replace `<version>` with your installed version, e.g. `15`).
2. Open `pg_hba.conf` in **Notepad** (Run as Administrator).
3.  Add a new line at the bottom to allow your client `10.0.4.1`:

    ```
    host    Help-Desk-Stg    Help-Desk    10.0.4.1/32    scram-sha-256
    ```


4.  &#x20;If you want to allow all `10.0.4.x` clients:

    ```
    host    Help-Desk-Stg    Help-Desk    10.0.4.0/24    scram-sha-256
    ```



    Or allow all IPs (not secure, only for testing):

    ```
    host    Help-Desk-Stg    Help-Desk    0.0.0.0/0    scram-sha-256
    ```

***

#### Step 2: Edit `postgresql.conf`

1. In the same folder, open `postgresql.conf`.
2.  Look for this line:

    ```
    #listen_addresses = 'localhost'
    ```
3.  Change it to:

    ```
    listen_addresses = '*'
    ```

    (removes the `#` and sets it to allow all IPs).

***

#### Step 3: Restart PostgreSQL Service

1. Press **Win + R**, type `services.msc`, and press Enter.
2. Find **PostgreSQL \<version>** in the list.
3. Right-click → **Restart**.

***

#### Step 4: Test Connection

From your client machine, run:

```bash
psql -h 192.168.*.* -U Help-Desk -d Help-Desk-Stg
```

Enter the password for `Help-Desk`.



{% hint style="info" %}
**Best Practice:**

* Keep `listen_addresses = '*'` but restrict in `pg_hba.conf` by IP or subnet.
* Don’t use `0.0.0.0/0` in production unless protected by firewall rules.
{% endhint %}



***

## REFERENCES

* [https://dba.stackexchange.com/questions/83984/connect-to-postgresql-server-fatal-no-pg-hba-conf-entry-for-host](https://dba.stackexchange.com/questions/83984/connect-to-postgresql-server-fatal-no-pg-hba-conf-entry-for-host)
