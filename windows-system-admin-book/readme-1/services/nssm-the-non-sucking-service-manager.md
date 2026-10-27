---
icon: wind-turbine
---

# NSSM - the Non-Sucking Service Manager

## Introduction

NSSM (Non-Sucking Service Manager) is a tool that allows you to install and manage Windows services easily. It is particularly useful for running non-service applications as Windows services.

#### **Steps to Create a Custom Windows Service Using NSSM**

**1. Download NSSM**

* Download NSSM from the official website or a trusted source:\
  https://nssm.cc/download
* Extract the ZIP file to a directory, e.g., `C:\nssm`.

**2. Open Command Prompt as Administrator**

* Press `Win + R`, type `cmd`, and press `Ctrl + Shift + Enter` to open an elevated command prompt.

**3. Install the Custom Service**

*   Use the following command to install your application as a Windows service:

    ```shell
    C:\nssm\nssm.exe install MyService
    ```

    This will open the NSSM GUI.

**4. Configure the Service in the NSSM GUI**

* In the `Application` tab:
  * Set **Path** to the full path of the executable (e.g., `C:\myapp\myapp.exe`).
  * Optionally, set **Startup directory** if required.
  * If your app requires arguments, enter them in the **Arguments** field.
* In the `Details` tab:
  * Set **Display Name** and **Description** for the service.
* In the `Log on` tab:
  * Specify the user account under which the service should run (default: `LocalSystem`).
* In the `Startup` tab:
  * Set **Startup Type** to `Automatic` if you want the service to start on boot.
* Click **Install service** to complete the setup.

**5. Start the Service**

*   Start the service using:

    ```shell
    net start MyService
    ```

    Or via the **Services** (`services.msc`) management console.

**6. Managing the Service**

*   **Stop the service**:

    ```shell
    net stop MyService
    ```
*   **Remove the service**:

    ```shell
    C:\nssm\nssm.exe remove MyService confirm
    ```

This method ensures that your application runs as a Windows service and restarts automatically if it crashes.&#x20;

