---
icon: ban
---

# Complete Guide: Fixing IIS 404 Errors and Database Connection Issues for ASP.NET Websites

## Complete Guide: Fixing IIS 404 Errors and Database Connection Issues for [ASP.NET](https://asp.net/) Websites

### Introduction

When migrating an [ASP.NET](https://asp.net/) website from a live server to a local development environment, you may encounter various issues including **404 errors on internal pages**, **database connection failures**, and **stored procedure execution errors**. This comprehensive guide walks through the step-by-step troubleshooting process to resolve these common issues.

***

### Table of Contents

1. Understanding the Problem
2. Fix 1: URL Rewriting for Friendly URLs
3. Fix 2: Database Connection Issues
4. Fix 3: Stored Procedure Schema Issues
5. Fix 4: Character Encoding Problems
6. Prevention and Best Practices

***

### Understanding the Problem

When testing a site locally with a custom domain binding (e.g., `http://yourdomain.com`), you might encounter:

* **404 errors** when accessing friendly URLs like `/about-us`
* **Database connection failures**
* **"Could not find stored procedure" errors** even though the procedure exists
* **Garbled text** with characters like `â€oe` appearing

These issues typically stem from four main areas:

1. Missing URL rewrite rules in IIS
2. Incorrect database connection strings
3. SQL Server schema qualification problems
4. File encoding issues

***

### Fix 1: URL Rewriting for Friendly URLs

#### The Problem

When accessing `http://yourdomain.com/about-us`, IIS returns a 404 error with:

* **Handler**: `StaticFile`
* **Physical Path**: `C:\inetpub\wwwroot\httpdocs\about-us`

This indicates IIS is treating the request as a physical folder/file rather than passing it to [ASP.NET](https://asp.net/) for processing.

#### The Solution

**Step 1: Install URL Rewrite Module for IIS**

Download and install the **URL Rewrite Module** from Microsoft:

* Download: [URL Rewrite Module for IIS](https://www.iis.net/downloads/microsoft/url-rewrite)
* After installation, restart IIS: `iisreset`

**Step 2: Verify Installation**

Open IIS Manager → Select your site → Look for **URL Rewrite** icon in the features view.

**Step 3: Configure Rewrite Rules in web.config**

Add the following rewrite rules to your `web.config`:

xml

```
<system.webServer>
    <modules runAllManagedModulesForAllRequests="true" />
    
    <rewrite>
        <rules>
            <!-- Specific page rewrites -->
            <rule name="About Us Rewrite" stopProcessing="true">
                <match url="^about-us$" />
                <action type="Rewrite" url="/about-us.aspx" />
            </rule>
            
            <rule name="Contact Us Rewrite" stopProcessing="true">
                <match url="^contact-us$" />
                <action type="Rewrite" url="/ContactUs.aspx" />
            </rule>
            
            <!-- Generic rewrite for any friendly URL -->
            <rule name="Friendly URLs to ASPX" stopProcessing="true">
                <match url="^([a-zA-Z0-9\-_]+)$" />
                <conditions logicalGrouping="MatchAll">
                    <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
                    <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
                </conditions>
                <action type="Rewrite" url="{R:1}.aspx" />
            </rule>
            
            <!-- Homepage redirect -->
            <rule name="Home Redirect" stopProcessing="true">
                <match url="^$" />
                <action type="Redirect" url="/Home.aspx" redirectType="Permanent" />
            </rule>
        </rules>
    </rewrite>
    
    <defaultDocument>
        <files>
            <clear />
            <add value="Index.aspx" />
        </files>
    </defaultDocument>
</system.webServer>
```

**Key Configuration Points:**

| Setting                                     | Purpose                                                          |
| ------------------------------------------- | ---------------------------------------------------------------- |
| `runAllManagedModulesForAllRequests="true"` | Routes all requests through [ASP.NET](https://asp.net/) pipeline |
| `stopProcessing="true"`                     | Prevents further rule processing after a match                   |
| `negate="true"`                             | Skips rewrite if physical file/directory exists                  |

***

### Fix 2: Database Connection Issues

#### The Problem

Your application fails to connect to the database with errors like:

* `Could not find stored procedure`
* Login failed for user
* Network-related errors

#### The Solution

**Step 1: Verify Database Connectivity**

Test the connection using SQLCMD:

cmd

```
sqlcmd -S [server_ip],[port] -U [username] -P [password] -d [database] -Q "SELECT @@VERSION"
```

**Step 2: Update Connection Strings**

Ensure your `web.config` has the correct database connection details:

xml

```
<connectionStrings>
    <add name="DbConnection" 
         connectionString="Server=192.168.1.100,1433;
                           Database=YourDatabaseName;
                           uid=YourUsername;
                           pwd=YourSecurePassword;
                           Trusted_Connection=False;
                           Connection Timeout=6000;
                           Min Pool Size=100;
                           Max Pool Size=200" 
         providerName="System.Data.SqlClient" />
</connectionStrings>

<appSettings>
    <add key="con" value="Server=192.168.1.100,1433;
                           uid=YourUsername;
                           pwd=YourSecurePassword;
                           database=YourDatabaseName;
                           Trusted_Connection=False;
                           Connection Timeout=6000;
                           Min Pool Size=100;
                           Max Pool Size=200" />
</appSettings>
```

**Step 3: Test the Database Connection**

Create a diagnostic ASPX page:

aspx

```
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Test</title>
</head>
<body>
    <h1>Database Connection Test</h1>
    <%
        try
        {
            string connString = ConfigurationManager
                .ConnectionStrings["DbConnection"].ConnectionString;
            
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                Response.Write("<p style='color:green'>✓ Connection successful!</p>");
                
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM sys.objects", conn);
                int count = (int)cmd.ExecuteScalar();
                Response.Write($"<p>Total objects: {count}</p>");
                
                conn.Close();
            }
        }
        catch (Exception ex)
        {
            Response.Write($"<p style='color:red'>Error: {ex.Message}</p>");
        }
    %>
</body>
</html>
```

***

### Fix 3: Stored Procedure Schema Issues

#### The Problem

Your stored procedure exists but cannot be found:

text

```
Msg 2812, Level 16, State 62
Could not find stored procedure 'YourStoredProcedure'
```

Yet the procedure appears in `sys.objects`:

sql

```
SELECT name FROM sys.objects WHERE name = 'YourStoredProcedure'
-- Returns: YourStoredProcedure
```

#### Root Cause

The stored procedure exists in a **non-default schema**. When a stored procedure is called without a schema prefix, SQL Server looks in the **default schema** (typically `dbo`). If the procedure was created in a custom schema, it won't be found.

#### The Solution

**Step 1: Find the Actual Schema**

cmd

```
sqlcmd -S [server] -U [user] -P [password] -d [database] -Q "
    SELECT SCHEMA_NAME(schema_id) AS SchemaName, name 
    FROM sys.objects 
    WHERE name = 'YourStoredProcedure'"
```

Example output:

text

```
SchemaName                        name
---------------------------------- ----------
yourcustomschema                  YourStoredProcedure
```

**Step 2: Apply One of These Fixes**

**Option A: Set Default Schema for User (Recommended)**

cmd

```
sqlcmd -S [server] -U [user] -P [password] -d [database] -Q "
    ALTER USER [username] WITH DEFAULT_SCHEMA = [schema_name]"
```

Example:

cmd

```
sqlcmd -S 192.168.1.100,1433 -U YourUsername -P "YourPassword" -d YourDatabase -Q "ALTER USER YourUsername WITH DEFAULT_SCHEMA = yourcustomschema"
```

**Option B: Update Application Code**

Change stored procedure calls to include the schema prefix:

csharp

```
// Before (doesn't work)
SqlCommand cmd = new SqlCommand("YourStoredProcedure", conn);

// After (works)
SqlCommand cmd = new SqlCommand("yourcustomschema.YourStoredProcedure", conn);
```

**Option C: Create a Wrapper Procedure**

cmd

```
sqlcmd -S [server] -U [user] -P [password] -d [database] -Q "
    CREATE PROCEDURE dbo.YourStoredProcedure 
    AS 
    EXEC [schema_name].YourStoredProcedure"
```

**Step 3: Verify the Fix**

cmd

```
sqlcmd -S [server] -U [user] -P [password] -d [database] -Q "
    EXEC [schema_name].YourStoredProcedure"
```

***

### Fix 4: Character Encoding Problems

#### The Problem

Text appears garbled with characters like `â€oe`, `â€`, or `â€˜` instead of proper quotes.

#### Root Cause

* Content was copied from Microsoft Word which uses "smart quotes" (`“ ”` and `‘ ’`)
* The file encoding is UTF-8 but the browser interprets it as ANSI/ISO-8859-1

#### The Solution

**Option A: Set Correct Encoding in web.config**

xml

```
<system.web>
    <globalization 
        requestEncoding="utf-8" 
        responseEncoding="utf-8" 
        fileEncoding="utf-8" 
        culture="en-US" 
        uiCulture="en-US" />
</system.web>
```

**Option B: Add Meta Charset to ASPX Pages**

html

```
<head>
    <meta charset="utf-8" />
    <!-- or -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
```

**Option C: Fix the Text Content**

Replace smart quotes with straight quotes:

| Wrong Character | Correct Replacement |
| --------------- | ------------------- |
| `â€oe` or `“`   | `"`                 |
| `â€` or `”`    | `"`                 |
| `â€˜` or `‘`    | `'`                 |
| `â€™` or `’`    | `'`                 |

**Example:**

html

```
<!-- Wrong -->
<p>â€oeQuality is our way of workingâ€</p>

<!-- Correct -->
<p>"Quality is our way of working"</p>
```

**Option D: Save Files with UTF-8 Encoding**

Using **Notepad++**:

1. Open the file
2. Click **Encoding** → **Encode in UTF-8 without BOM**
3. Save the file

Using **VS Code**:

1. Open the file
2. Click on the encoding indicator in the bottom bar
3. Select **Save with Encoding** → **UTF-8**

***

### Prevention and Best Practices

#### 1. URL Rewriting

* Always use **rewrite** (not redirect) for friendly URLs to keep the URL clean
* Test rewrite rules with `stopProcessing="true"` to avoid conflicts
* Keep generic rules at the bottom of your rules list

#### 2. Database Connections

* Use **Windows Authentication** when possible for local development
* Store connection strings securely; never commit production credentials to version control
* Use separate connection strings for development and production:

xml

```
<!-- Development -->
<connectionStrings>
    <add name="DbConnection_Dev" 
         connectionString="Data Source=localhost;Initial Catalog=DevDB;Integrated Security=True" />
</connectionStrings>

<!-- Production (use config transformation) -->
<connectionStrings>
    <add name="DbConnection_Prod" 
         connectionString="Server=prod-server;Database=ProdDB;uid=prod_user;pwd=secure_password" />
</connectionStrings>
```

#### 3. Database Schemas

* Always use **schema prefixes** in stored procedure calls: `schema.procedure_name`
* Set appropriate **default schemas** for database users
* Document custom schemas in your application documentation

#### 4. Character Encoding

* Always use **UTF-8 without BOM** for web files
* Avoid copying directly from Microsoft Word; use **Notepad** as an intermediary
* Set consistent encoding in your development environment

#### 5. Diagnostic Tools

Create a diagnostic page to test your configuration:

aspx

```
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<!DOCTYPE html>
<html>
<head>
    <title>System Diagnostics</title>
    <style>body { font-family: Arial; margin: 20px; } .pass { color: green; } .fail { color: red; }</style>
</head>
<body>
    <h1>System Diagnostics</h1>
    
    <h2>1. Application Configuration</h2>
    <ul>
        <li>Framework Version: <%= System.Environment.Version %></li>
        <li>Application Path: <%= Server.MapPath("~") %></li>
    </ul>
    
    <h2>2. Database Connection</h2>
    <%
        try
        {
            var connString = ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;
            using (var conn = new SqlConnection(connString))
            {
                conn.Open();
                Response.Write("<p class='pass'>✓ Database connection successful</p>");
                conn.Close();
            }
        }
        catch (Exception ex)
        {
            Response.Write($"<p class='fail'>✗ Database connection failed: {ex.Message}</p>");
        }
    %>
    
    <h2>3. URL Rewrite Test</h2>
    <p>Current URL: <%= Request.Url %></p>
    <p>Raw URL: <%= Request.RawUrl %></p>
</body>
</html>
```

***

### Summary

| Issue                          | Symptom                            | Solution                                      |
| ------------------------------ | ---------------------------------- | --------------------------------------------- |
| **404 on friendly URLs**       | Handler: StaticFile                | Install URL Rewrite module; add rewrite rules |
| **Database connection**        | Login failed / timeout             | Verify connection string; test with SQLCMD    |
| **Stored procedure not found** | Procedure exists but can't execute | Set default schema or use schema prefix       |
| **Garbled text**               | `â€oe` characters appear           | Set UTF-8 encoding; replace smart quotes      |

***

### Quick Reference Commands

cmd

```
# Test database connection
sqlcmd -S server_ip,port -U username -P password -d database -Q "SELECT 1"

# Find stored procedure schema
sqlcmd -S server -U user -P pass -d db -Q "SELECT SCHEMA_NAME(schema_id), name FROM sys.objects WHERE name = 'proc_name'"

# Set default schema for user
sqlcmd -S server -U user -P pass -d db -Q "ALTER USER username WITH DEFAULT_SCHEMA = schema_name"

# Test stored procedure execution
sqlcmd -S server -U user -P pass -d db -Q "EXEC schema.procedure_name"

# Restart IIS
iisreset

# List ASPX files
dir C:\inetpub\wwwroot\httpdocs\*.aspx /b
```

***

### Conclusion

Migrating an [ASP.NET](https://asp.net/) application to a local development environment requires careful attention to URL rewriting, database connectivity, schema handling, and file encoding. By systematically addressing each of these areas, you can successfully set up a functional local testing environment that mirrors your production configuration.

Remember to:

1. **Install required IIS modules** (URL Rewrite)
2. **Verify database connectivity** before assuming schema issues
3. **Check schema qualification** when stored procedures can't be found
4. **Maintain consistent file encoding** across your project
5. **Create diagnostic tools** to quickly identify issues

With these fixes applied, your local site should function identically to the production environment, allowing for safe development and testing.
