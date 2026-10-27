---
icon: windows
---

# Win-ACME Let's Encrypt SSL

## Install with Win-acme Client

This method is easier for most users.

Win-Acme is another Let's Encrypt client that is easier to use and installs SSL certificates directly to the IIS certificate store. [Download the latest win-acme version from the official website](https://www.win-acme.com/) and follow the steps below.

1. Extract files from the downloaded win-acme zip archive.
2. Navigate to the extracted folder and open the `wacs.exe` application.
3. Click **More info** in the Windows Defender SmartScreen pop-up window, and **Run anyway**.
4. In the open command prompt console, enter **N** to create a new SSL certificate with default options.
5. Select your target IIS domain to install the SSL certificate on.
6. Enter **A** to use all bindings of the IIS domain.
7. Enter `y' to continue with your selection,` y' to open with the default web server application, \`y' to agree to the Let's Encrypt terms.
8. Enter your email address to receive important certificate notifications.
9. Your SSL Certificate is automatically stored in the IIS certificate store and registered for your domain name.
10. Visit your domain name to confirm **HTTPS** access.

    ```
     https://example.com
    ```
