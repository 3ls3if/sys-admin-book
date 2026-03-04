---
icon: chart-network
---

# How to Change the IPv4 Address in AlmaLinux

## How to Change the IPv4 Address in AlmaLinux

Changing the IPv4 address on an AlmaLinux system is a common administrative task—whether you're configuring a server with a static IP, moving to a new network, or troubleshooting connectivity. AlmaLinux (8 and 9) uses **NetworkManager** by default, which provides multiple ways to manage network settings.

This guide explains the recommended and alternative methods step by step.

***

### Understanding IPv4 Configuration in AlmaLinux

In modern AlmaLinux systems:

* **NetworkManager** controls network interfaces.
* Configuration can be done using:
  * `nmcli` (command line)
  * `nmtui` (text-based interface)
  * Manual configuration files

Most systems—especially servers and VPS instances—use predictable interface names like:

* `ens33`
* `enp0s3`
* `eth0`

You can check your interface name with:

```
ip link
```

***

## Method 1: Using nmcli (Recommended Method)

`nmcli` is the official command-line tool for managing NetworkManager.

#### Step 1: List Active Connections

```
nmcli connection show
```

Take note of the **connection name** (for example: `System ens33`).

***

#### Step 2: Set a Static IPv4 Address

Replace the example values with your network details:

```
nmcli connection modify "System ens33" \
ipv4.addresses 192.168.1.100/24 \
ipv4.gateway 192.168.1.1 \
ipv4.dns "8.8.8.8 8.8.4.4" \
ipv4.method manual
```

Explanation:

* `192.168.1.100/24` → IP address and subnet prefix
* `192.168.1.1` → Default gateway
* DNS servers → Google DNS (example)
* `manual` → Enables static configuration

***

#### Step 3: Restart the Connection

```
nmcli connection down "System ens33"
nmcli connection up "System ens33"
```

***

#### Step 4: Verify the Changes

```
ip a
```

or

```
nmcli device show
```

***

## Switching Back to DHCP

If you want the system to automatically obtain an IP address:

```
nmcli connection modify "System ens33" ipv4.method auto
nmcli connection up "System ens33"
```

***

## Method 2: Using nmtui (Text-Based UI)

If you prefer a guided interface:

```
nmtui
```

Steps:

1. Select **Edit a connection**
2. Choose your network interface
3. Change IPv4 configuration from _Automatic_ to _Manual_
4. Enter:
   * IP address
   * Gateway
   * DNS servers
5. Save and activate the connection

This method is useful for administrators who prefer interactive configuration over command-line arguments.

***

## Method 3: Editing Configuration Files Manually

In AlmaLinux 8 and 9, NetworkManager stores configuration files in:

```
/etc/NetworkManager/system-connections/
```

Older legacy configurations (less common in modern AlmaLinux) may use:

```
/etc/sysconfig/network-scripts/
```

Example static configuration in legacy format:

```
BOOTPROTO=none
ONBOOT=yes
IPADDR=192.168.1.100
PREFIX=24
GATEWAY=192.168.1.1
DNS1=8.8.8.8
```

After editing, restart NetworkManager:

```
systemctl restart NetworkManager
```

***

## Important Considerations

#### 1. Avoid IP Conflicts

Ensure the IP address is not already assigned to another device on the network.

#### 2. Be Careful on Remote Servers

If you're connected via SSH, changing the IP incorrectly can disconnect your session. Always confirm:

* Correct gateway
* Correct subnet mask
* Correct DNS

#### 3. Verify Network Status

Check status with:

```
nmcli device status
```

***

## Conclusion

Changing the IPv4 address in AlmaLinux is straightforward thanks to NetworkManager. The recommended method is using `nmcli`, especially for servers and automation. For beginners or quick configuration, `nmtui` provides a simple interface.

By understanding these methods, system administrators can confidently manage network settings on AlmaLinux systems in both desktop and server environments.
