---
icon: credit-card
---

# How to Redirect One Domain to Another in IIS Using URL Rewrite

## **How to Redirect One Domain to Another in IIS Using URL Rewrite**

When managing multiple domains in Internet Information Services (IIS), you may come across situations where one domain should automatically redirect to another. This is commonly required during domain changes, branding updates, or consolidation of multiple domain names into a primary address.

In this article, we will explain how to configure a **301 Permanent Redirect** from one domain—**example.org.in**—to another domain—**example.org**—using the **URL Rewrite** module in IIS.

***

### **Prerequisites**

Before you begin, ensure that:

* IIS is installed on your Windows server.
* The **URL Rewrite** module is installed.\
  (If not, download it from the official Microsoft website.)
* The domain **example.org.in** is already added as a site or binding in IIS.

***

### **Step-by-Step Guide to Set Up the Redirect**

#### **Step 1: Open IIS Manager**

1. Press **Windows + R**, type **inetmgr**, and click **OK**.
2. In the left-hand Connections pane, locate and select the **example.org.in** website.

***

#### **Step 2: Open URL Rewrite**

1. Inside the site’s feature view, double-click **URL Rewrite**.
2. Click **“Add Rule(s)…”** on the right-hand Actions panel.

***

#### **Step 3: Create a Blank Rule**

1. Select **Blank Rule** and click **OK**.
2. Name the rule something meaningful, such as:\
   **Redirect to example.org**

***

### **Step 4: Configure the Match URL Section**

* **Requested URL:** Matches the Pattern
* **Using:** Regular Expressions
*   **Pattern:**

    ```
    .*
    ```

This ensures the rule matches all incoming requests.

***

### **Step 5: Configure the Condition**

We want the redirect to occur only when visitors access the **example.org.in** domain.

1. Under **Conditions**, click **Add**.
2. Enter the following:

*   **Condition Input:**

    ```
    {HTTP_HOST}
    ```
* **Check if input string:** Matches the Pattern
*   **Pattern:**

    ```
    ^example\.org\.in$
    ```

The domain name is escaped with backslashes because dots have special meaning in regex.

***

### **Step 6: Configure the Action**

In the **Action** section, enter the following:

* **Action type:** Redirect
*   **Redirect URL:**

    ```
    https://example.org/{R:0}
    ```
* **Redirect type:** Permanent (301)

This ensures all traffic from the old domain moves to the new one and preserves the URL path.

***

### **Step 7: Apply the Rule**

1. Click **Apply** on the right-hand panel.
2. Restart IIS or recycle the application pool if necessary.

Your redirect rule is now active.

***

## **Alternative: Using web.config**

If you prefer to configure the redirect directly in the web.config file, use the following snippet:

```xml
<rewrite>
  <rules>
    <rule name="Redirect to kbsk.org" stopProcessing="true">
      <match url=".*" />
      <conditions>
        <add input="{HTTP_HOST}" pattern="^example\.org\.in$" />
      </conditions>
      <action type="Redirect" url="https://example.org/{R:0}" redirectType="Permanent" />
    </rule>
  </rules>
</rewrite>
```

Place this inside the `<system.webServer>` section of the web.config file.

***

## **Conclusion**

Setting up a domain redirect in IIS using the URL Rewrite module is a reliable way to ensure users are seamlessly redirected to the correct domain. Whether you are migrating to a new domain or consolidating multiple domains, this approach maintains SEO value and prevents broken links.
