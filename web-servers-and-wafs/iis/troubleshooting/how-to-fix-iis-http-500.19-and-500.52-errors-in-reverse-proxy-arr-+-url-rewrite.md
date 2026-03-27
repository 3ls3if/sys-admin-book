---
icon: arrow-u-turn-up-left
---

# How to Fix IIS HTTP 500.19 & 500.52 Errors in Reverse Proxy (ARR + URL Rewrite)

## How to Fix IIS HTTP 500.19 & 500.52 Errors in Reverse Proxy (ARR + URL Rewrite)

If you are configuring IIS as a reverse proxy and see errors like:

* **HTTP Error 500.19 – Internal Server Error**
* **HTTP Error 500.52 – URL Rewrite Module Error**
* **Error Code 0x8007000d**
* **Error Code 0x800700b7**
* **Outbound rewrite rules cannot be applied when the content is encoded ("gzip")**
* **Handler: ApplicationRequestRoutingHandler**

This guide explains the exact cause and step-by-step solution.

***

## Understanding the Problem

When IIS is configured as a reverse proxy using:

* **IIS URL Rewrite Module**
* **Application Request Routing**

It forwards incoming traffic to a backend server (Node.js, .NET, etc.).

However, common configuration mistakes lead to two major errors:

***

## Error 1: HTTP 500.52 – Gzip + Outbound Rewrite Conflict

#### Error Message:

> Outbound rewrite rules cannot be applied when the content of the HTTP response is encoded ("gzip")

#### Why This Happens

1.  Browser sends:

    ```
    Accept-Encoding: gzip
    ```
2. IIS forwards this header to backend.
3.  Backend responds with:

    ```
    Content-Encoding: gzip
    ```
4. IIS tries to apply **outbound rewrite rules**.
5. IIS cannot modify compressed (gzip) content.
6. Result: **500.52**

***

### ✅ Solution for 500.52

You must prevent the backend from sending compressed content.

#### Step 1: Allow Server Variable

IIS Manager → Server Level → URL Rewrite → View Server Variables\
Add:

```
HTTP_ACCEPT_ENCODING
```

***

#### Step 2: Add This Rule in web.config (Inside `<rules>`)

```
<rule name="RemoveAcceptEncoding" stopProcessing="false">
    <match url=".*" />
    <serverVariables>
        <set name="HTTP_ACCEPT_ENCODING" value="" />
    </serverVariables>
    <action type="None" />
</rule>
```

This removes the gzip request header before proxying.

Restart IIS:

```
iisreset
```

✔ 500.52 resolved.

***

## Error 2: HTTP 500.19 – Invalid Configuration Data

This error usually shows:

#### Error Code: `0x8007000d`

Meaning:

> The configuration file contains invalid XML.

OR

#### Error Code: `0x800700b7`

Meaning:

> A configuration section is defined more than once.

***

### Common Causes of 500.19

#### 1️⃣ Duplicate `<rules>` Section

❌ Invalid:

```
<rewrite>
    <rules>
    </rules>

    <rules>   <!-- second one -->
    </rules>
</rewrite>
```

✔ Only ONE `<rules>` block is allowed.

***

#### 2️⃣ Rule Outside `<rules>` Block

❌ Invalid:

```
<rewrite>
    <rules>
    </rules>

    <rule> <!-- illegal placement -->
</rewrite>
```

***

#### 3️⃣ URL Rewrite Module Not Installed

If your web.config contains:

```
<rewrite>
```

But the module is not installed, IIS throws 500.19.

Install:

* **IIS URL Rewrite Module**

***

## Correct Working Reverse Proxy web.config

Below is a properly structured, production-ready configuration:

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>

    <rewrite>

      <rules>

        <!-- Remove Accept-Encoding to prevent gzip issue -->
        <rule name="RemoveAcceptEncoding" stopProcessing="false">
          <match url=".*" />
          <serverVariables>
            <set name="HTTP_ACCEPT_ENCODING" value="" />
          </serverVariables>
          <action type="None" />
        </rule>

        <!-- Reverse Proxy Inbound -->
        <rule name="ReverseProxyInboundRule1" stopProcessing="true">
          <match url="(.*)" />
          <action type="Rewrite" url="http://127.0.0.1:5000/{R:1}" />
        </rule>

      </rules>

      <outboundRules>
        <rule name="ReverseProxyOutboundRule1" preCondition="ResponseIsHtml">
          <match filterByTags="A, Form, Img"
                 pattern="^http(s)?://127.0.0.1:5000/(.*)" />
          <action type="Rewrite"
                  value="http{R:1}://api.yourdomain.com/{R:2}" />
        </rule>

        <preConditions>
          <preCondition name="ResponseIsHtml">
            <add input="{RESPONSE_CONTENT_TYPE}" pattern="^text/html" />
          </preCondition>
        </preConditions>
      </outboundRules>

    </rewrite>

  </system.webServer>
</configuration>
```

***

## Required IIS Configuration Checklist

✔ Install URL Rewrite\
✔ Install ARR\
✔ Enable Proxy in ARR\
✔ Allow HTTP\_ACCEPT\_ENCODING variable\
✔ Only one `<rules>` section\
✔ Valid XML formatting

***

## How to Verify Everything

1.  Browse directly:

    ```
    http://127.0.0.1:5000
    ```

    Must load successfully.
2.  Restart IIS:

    ```
    iisreset
    ```
3. Test public domain.

***

## Final Summary

| Error               | Cause                            | Fix                           |
| ------------------- | -------------------------------- | ----------------------------- |
| 500.52              | Gzip + outbound rewrite conflict | Remove Accept-Encoding header |
| 500.19 (0x8007000d) | Invalid XML                      | Fix web.config structure      |
| 500.19 (0x800700b7) | Duplicate section                | Keep only one `<rules>` block |

***

If configured correctly, IIS reverse proxy with ARR and URL Rewrite will:

* Forward traffic to backend
* Rewrite outbound URLs
* Avoid gzip conflicts
* Run without 500 errors
