---
icon: square-terminal
---

# CMD / Laravel

{% hint style="warning" %}
To **run a Laravel project using CMD (Command Prompt / Terminal)**, follow these steps:
{% endhint %}

#### Steps to Run Laravel from CMD

1. **Open CMD / Terminal**
   * On Windows: `Win + R`, type `cmd`, then press Enter.
   * On macOS/Linux: open your terminal.
2.  **Navigate to Your Laravel Project Folder**

    ```sh
    cd path\to\your\laravel\project
    ```

    Example:

    ```sh
    cd C:\xampp\htdocs\my-laravel-app
    ```
3.  **Check if Composer is Installed**

    ```sh
    composer -V
    ```

    If not installed, download it here: https://getcomposer.org/download/
4.  **Install Laravel Dependencies**\
    Run inside your project folder:

    ```sh
    composer install
    ```
5.  **Set Application Key** (first time only)

    ```sh
    php artisan key:generate
    ```
6.  **Run Database Migrations** (if you have migrations)

    ```sh
    php artisan migrate
    ```
7.  **Start the Laravel Development Server**

    ```sh
    php artisan serve
    ```

    By default, it runs at:

    ```
    http://127.0.0.1:8000
    ```

***

#### Common Issues

* If `php` is not recognized → install PHP or add it to PATH.
* If `composer` is not recognized → install Composer globally.
* If you want to stop the server → press **CTRL + C** in CMD.
