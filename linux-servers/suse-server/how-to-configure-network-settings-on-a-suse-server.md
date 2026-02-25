---
icon: diagram-project
---

# How to Configure Network Settings on a SUSE Server

## How to Configure Network Settings on a SUSE Server

Managing network configuration on a SUSE server can be done in several ways, depending on your environment and level of expertise. SUSE provides flexible tools ranging from an intuitive graphical interface to powerful command-line utilities and direct configuration file editing.

On systems such as SUSE Linux Enterprise Server (SLES) and openSUSE, network configuration is typically handled using:

* **YaST (Yet another Setup Tool)** – Recommended for most users
* **Command-line tools** such as Wicked or NetworkManager
* **Manual editing of configuration files** in `/etc/sysconfig/network/`

This article explains each method and when to use it.

***

### 1. Using YaST (Recommended Method)

YaST provides a user-friendly, menu-driven (or graphical) interface for configuring system settings, including networking. It is the preferred method for most administrators because it reduces configuration errors and automatically manages related settings.

#### Steps to Configure Network with YaST

1.  **Open YaST**

    ```
    sudo yast
    ```
2. **Navigate to Network Settings**
   * Go to: `System` → `Network Settings`
3. **Select and Edit Interface**
   * In the **Overview** tab, select the interface (e.g., `eth0`)
   * Click **Edit**
4. **Configure IP Address**
   * Choose:
     * **Dynamic Address (DHCP)**, or
     * **Statically Assigned IP Address**
   * For static configuration, enter:
     * IP address
     * Subnet mask
     * Default gateway
5. **Configure Hostname and DNS**
   * Go to the **Hostname/DNS** tab
   * Enter hostname and DNS server addresses
6. **Configure Routing**
   * Use the **Routing** tab to define:
     * Default gateway
     * Static routes
7. **Apply Changes**
   * Click **OK** to save and apply the configuration

**Why use YaST?**

* Guided interface
* Reduces misconfiguration
* Ideal for system administrators who prefer structured workflows

***

### 2. Using the Command Line Interface (CLI)

For advanced users, automation, or headless servers, command-line tools provide more granular control. The specific tool depends on the network management service in use.

#### A. Using Wicked (Default on SLES)

wicked is the default network management framework on SUSE Linux Enterprise Server.

**View Current Configuration**

```
sudo wicked show all
```

**Bring Interface Up or Down**

```
sudo wicked ifup eth0
sudo wicked ifdown eth0
```

**Reload All Configurations**

```
sudo wicked ifreload all
```

Wicked is commonly used in enterprise server environments where stable, predictable networking is required.

***

#### B. Using NetworkManager (Default on openSUSE Desktop)

NetworkManager is typically used in desktop environments like openSUSE Leap or SLED.

**View Existing Connections**

```
nmcli connection show
```

**Configure a Static IP Address**

```
sudo nmcli connection modify "connection_name" \
  ipv4.method manual \
  ipv4.addresses 192.0.2.1/24 \
  ipv4.gateway 192.0.2.254 \
  ipv4.dns 192.0.2.200
```

**Activate the Connection**

```
sudo nmcli connection up "connection_name"
```

**Why use CLI tools?**

* Ideal for remote administration
* Suitable for scripting and automation
* Preferred in production server environments

***

### 3. Manual Configuration File Editing

For full control, administrators can directly edit configuration files located in:

```
/etc/sysconfig/network/
```

#### Example: Configure `eth0` with a Static IP

1. **Edit the Interface File**

```
sudo nano /etc/sysconfig/network/ifcfg-eth0
```

2. **Modify Parameters**

```
BOOTPROTO='static'      # or 'dhcp'
IPADDR='192.168.1.10/24'
GATEWAY='192.168.1.1'
STARTMODE='auto'
```

> Note: The gateway can also be defined in:\
> `/etc/sysconfig/network/ifroute-eth0`

3. **Restart the Network Service**

```
sudo systemctl restart network
```

or:

```
sudo wicked ifup eth0
```

**When to use manual configuration:**

* Automated deployments
* Advanced routing or bonding setups
* Fine-tuned enterprise configurations

***

### Choosing the Right Method

| Method                 | Best For                     | Skill Level              |
| ---------------------- | ---------------------------- | ------------------------ |
| YaST                   | Most administrators          | Beginner to Intermediate |
| Wicked CLI             | Enterprise servers           | Intermediate to Advanced |
| NetworkManager (nmcli) | Desktop systems              | Intermediate             |
| Manual file editing    | Automation & advanced setups | Advanced                 |

***

### Conclusion

Network configuration on a SUSE server is flexible and adaptable to different administrative styles.

* Use **YaST** for a guided, reliable configuration experience.
* Use **Wicked or NetworkManager CLI tools** for scripting and remote management.
* Use **manual configuration files** when you need precision and automation control.

Understanding all three approaches ensures you can effectively manage networking across both enterprise and community SUSE environments.
