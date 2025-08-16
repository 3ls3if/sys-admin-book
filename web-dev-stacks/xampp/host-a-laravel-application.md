---
icon: laravel
---

# Host a Laravel Application

## How to Host a Laravel Application on Windows Server

Laravel is one of the most popular PHP frameworks for building modern web applications. While Linux servers are commonly used for deployment, many developers and organizations run Laravel applications on **Windows Server** as well. In this guide, we’ll walk through the process of hosting a Laravel application on Windows using **XAMPP** and **PHP**.

***

### Prerequisites

Before starting, make sure you have the following installed:

* **Windows Server** (or Windows 10/11 for local setup)
* **XAMPP** with Apache and MySQL
* **PHP 8.2** (or the version required by your Laravel app)
* **Composer** (PHP dependency manager)
* A **Laravel project** ready to be deployed

***

### Step 1: Place Your Laravel Project in XAMPP’s `htdocs`

1.  Copy your Laravel project folder to:

    ```
    C:\xampp\htdocs\
    ```

    For example:

    ```
    C:\xampp\htdocs\admission_crm
    ```
2. Verify that the `public` directory of your Laravel project contains `index.php`, which will act as the entry point.

***

### Step 2: Configure Laravel Environment

1.  Navigate to your project directory:

    ```
    cd C:\xampp\htdocs\admission_crm
    ```
2.  Copy the `.env.example` file and rename it to `.env`:

    ```
    copy .env.example .env
    ```
3.  Update your `.env` file with database credentials, app URL, and other configurations. Example:

    ```env
    APP_NAME=AdmissionCRM
    APP_ENV=local
    APP_KEY=
    APP_DEBUG=true
    APP_URL=http://localhost:9000

    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=admission_crm
    DB_USERNAME=root
    DB_PASSWORD=
    ```

***

### Step 3: Clear and Rebuild Laravel Cache

Run the following commands to clear cached configurations, routes, and application cache:

```bash
C:\xampp\php8.2\php.exe artisan config:clear
C:\xampp\php8.2\php.exe artisan route:clear
C:\xampp\php8.2\php.exe artisan cache:clear
```

Then, generate a new application key:

```bash
C:\xampp\php8.2\php.exe artisan key:generate
```

***

### Step 4: Run Database Migrations

To create database tables, run:

```bash
C:\xampp\php8.2\php.exe artisan migrate
```

If Laravel reports _"Nothing to migrate"_, it means your migrations are already applied.

***

### Step 5: Install Dependencies with Composer

Laravel requires dependencies from **Composer**. Run the following command inside your project:

```bash
C:\xampp\php8.2\php.exe C:\ProgramData\ComposerSetup\bin\composer.phar install
```

This will install all packages listed in `composer.json`.

***

### Step 6: Start Laravel Development Server

Laravel has a built-in development server. Run:

```bash
C:\xampp\php8.2\php.exe -S 0.0.0.0:9000 -t public
```

* The app will be accessible on:\
  👉 `http://localhost:9000`
* If you want to access it from another machine in the same network, use your server’s IP:\
  👉 `http://<your-server-ip>:9000`

***

### Step 7: Configure Apache Virtual Host (Optional for Production)

For production hosting, it’s better to configure Apache instead of running PHP’s built-in server.

1.  Open Apache configuration file:

    ```
    C:\xampp\apache\conf\extra\httpd-vhosts.conf
    ```
2.  Add a VirtualHost entry:

    ```apache
    <VirtualHost *:80>
        DocumentRoot "C:/xampp/htdocs/admission_crm/public"
        ServerName admission-crm.local
        <Directory "C:/xampp/htdocs/admission_crm/public">
            AllowOverride All
            Require all granted
        </Directory>
    </VirtualHost>
    ```
3.  Edit `C:\Windows\System32\drivers\etc\hosts` and add:

    ```
    127.0.0.1 admission-crm.local
    ```
4. Restart Apache from the XAMPP control panel.

Now you can access your app at:\
&#x20;`http://admission-crm.local`

***

### Conclusion

By following these steps, you can successfully **host a Laravel application on Windows Server using XAMPP**. For development, Laravel’s built-in PHP server works fine, but for production, it’s recommended to configure **Apache or Nginx** with proper environment settings and security hardening.



***

## REFERENCES

* [https://laravel.com/docs/10.x](https://laravel.com/docs/10.x)
