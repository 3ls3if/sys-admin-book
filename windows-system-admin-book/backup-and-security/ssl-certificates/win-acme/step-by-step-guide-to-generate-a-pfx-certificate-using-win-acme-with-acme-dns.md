---
icon: cloudflare
---

# Step-by-Step Guide to Generate a PFX Certificate Using win-acme with acme-dns

### Introduction

This guide explains how to generate a **PFX certificate** using **win-acme (WACS)** with **DNS validation via acme-dns**. This method uses a dedicated ACME-DNS service such as:

```
https://auth.acme-dns.io/
```

***

### Step 1: Download and Prepare win-acme

* Download the latest win-acme release
* Extract it to a folder (e.g., `C:\win-acme`)
* Run `wacs.exe` as Administrator

***

### Step 2: Start a New Certificate Request

*   Press:

    ```
    N
    ```

    (Create new certificate)
*   Then:

    ```
    M
    ```

    (Full options)

***

### Step 3: Enter Domain Name

*   Enter your domain:

    ```
    app.example.com
    ```
*   Or for wildcard:

    ```
    *.example.com
    ```

***

### Step 4: Select DNS Validation

*   Choose:

    ```
    7
    ```

    (DNS validation)

***

### Step 5: Select **acme-dns** Method

*   Choose:

    ```
    acme-dns
    ```

***

### Step 6: Enter ACME-DNS Server URL

When prompted:

```
Root URI of the acme-dns service:
```

Enter:

```
https://auth.acme-dns.io/
```

***

### Step 7: Register with acme-dns

* win-acme will register your domain with the ACME-DNS service
* It will generate a **CNAME record**

Example:

```
_acme-challenge.app.example.com → <unique>.auth.acme-dns.io
```

***

### Step 8: Create CNAME Record in DNS

Go to your DNS provider and add:

| Type  | Name             | Value                       |
| ----- | ---------------- | --------------------------- |
| CNAME | \_acme-challenge | `<unique>.auth.acme-dns.io` |

***

### Step 9: Continue Validation

* Return to win-acme
* Press Enter to continue
* Validation completes automatically

***

### Step 10: Export Certificate as PFX

*   Choose:

    ```
    3
    ```

    (PFX file)
* Provide:
  * File path (e.g., `C:\certs\certificate.pfx`)
  * Password

***

### Step 11: Finish

* win-acme completes the process
* Your PFX file is generated successfully

***

### Result

You now have a **PFX certificate generated using acme-dns**, enabling DNS-based validation with minimal manual intervention after initial setup.
