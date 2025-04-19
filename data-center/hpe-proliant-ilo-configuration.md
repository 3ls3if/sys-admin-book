---
icon: gear
---

# HPE ProLiant ILO Configuration

{% hint style="success" %}
iLO (Integrated Lights-Out) is a proprietary **embedded server management technology by Hewlett Packard Enterprise (HPE)**. It's essentially a **dedicated management processor** built into HPE ProLiant and some other HPE servers, allowing administrators to **remotely manage servers** even when the OS is not running or the server is powered off.\


#### Key Uses of iLO in HPE Servers:

**1. Remote Management**

* <mark style="color:orange;">Full remote access via a web interface or CLI (SSH, XML API, etc.).</mark>
* <mark style="color:orange;">Power on/off/reboot the server.</mark>
* <mark style="color:orange;">Mount ISO images or virtual media for OS installation.</mark>
* <mark style="color:orange;">Access the server console (even pre-boot) using</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**remote KVM (Keyboard Video Mouse)**</mark><mark style="color:orange;">.</mark>

**2. Hardware Monitoring**

* <mark style="color:orange;">Monitor CPU, RAM, fans, power supply, temperature, and storage components.</mark>
* <mark style="color:orange;">Real-time alerts for failures or thresholds being breached.</mark>
* <mark style="color:orange;">Integrates with</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**HPE Insight**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">and other monitoring tools.</mark>

**3. Firmware and BIOS Configuration**

* <mark style="color:orange;">Update firmware remotely.</mark>
* <mark style="color:orange;">Configure BIOS settings without physically accessing the machine.</mark>
* <mark style="color:orange;">Schedule updates and maintenance windows.</mark>

**4. Security and Authentication**

* <mark style="color:orange;">Secure access with user authentication, directory services (LDAP/AD), and two-factor auth.</mark>
* <mark style="color:orange;">Audit logs and session logging for security reviews.</mark>
* <mark style="color:orange;">iLO has its own independent firmware and networking, isolated from the main OS.</mark>

**5. Scripting and Automation**

* <mark style="color:orange;">iLO supports</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**RESTful API**</mark><mark style="color:orange;">,</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**iLO cmdlets for PowerShell**</mark><mark style="color:orange;">, and</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**Redfish API**</mark><mark style="color:orange;">, making automation and integration into devops/security operations easier</mark>
{% endhint %}

## Common Scenarios:

| Scenario                                                          | iLO Feature                                   |
| ----------------------------------------------------------------- | --------------------------------------------- |
| Server is unresponsive                                            | Use iLO to reboot it                          |
| Need to install OS remotely                                       | Mount ISO via iLO virtual media               |
| Physical access is restricted (e.g., data center in another city) | Manage everything through iLO web interface   |
| Hardware failure suspected                                        | Check real-time sensor data and logs          |
| Server hardening and audit                                        | Review iLO logs, update firmware, enforce 2FA |

***

## HPE PROLIANT DL380 GEN10

![79f46-rear-view-p02463-b21.jpg](https://helpdesk.editshare.com/hc/article_attachments/24621040144539)

1. <mark style="color:green;">Primary Riser. PCI Slots (Slots 1-3 top to bottom, riser standard)</mark>
2. <mark style="color:green;">Secondary Riser. PCI Slots (Slots 4-6top to bottom, second processor)</mark>
3. <mark style="color:green;">Optional serial port</mark>
4. <mark style="color:green;">Tertiary Riser (Slots 7-8). Optional rear 2 SFF HDD</mark>
5. <mark style="color:green;">Power supply Power connection</mark>
6. <mark style="color:green;">Power supply Power LED</mark>
7. <mark style="color:green;">HPE Flexible Slot Power Supply bay 1 (800W shown)</mark>
8. <mark style="color:green;">Power supply Power connection</mark>
9. <mark style="color:green;">Power supply Power LED</mark>
10. <mark style="color:green;">HPE Flexible Slot Power Supply bay 2 (800W shown)</mark>
11. <mark style="color:green;">VGA connector</mark>
12. <mark style="color:green;">Embedded 4 x 1GbE Network Adapter --- This does not usually exist on editshare servers</mark>
13. <mark style="color:red;">**Dedicated iLO management port**</mark>
14. <mark style="color:green;">USB connectors 3.0 (2)</mark>
15. <mark style="color:green;">Unit ID LED</mark>
16. <mark style="color:green;">Optional FlexibleLOM ports (Shown: 4 x 1GbE)</mark>



## Setting up A Static IP Address on HP ILO

{% hint style="warning" %}
**Note:** Once you plug an ethernet cable into the ILO port and connect it to your switch. (number 13 in the above picture) This can be easily done by a Technician using the **ipmitool** assuming they can still ssh to the system.
{% endhint %}

### Configuring static IP address <a href="#n10012" id="n10012"></a>

This step is required only if user want to use a static IP address. When user use dynamic IP addressing, the DHCP server automatically assigns an IP address for iLO.

To simplify installation, Hewlett Packard Enterprise recommends using DNS or DHCP with iLO.

Procedure

1. <mark style="color:green;">Optional: If user access the server remotely, start an iLO remote console session.</mark>
2. <mark style="color:green;">Restart or power on the server.</mark>
3. <mark style="color:green;">Press F9 in the server POST screen. The system utilities start.</mark>
4. <mark style="color:green;">Click System Configuration.</mark>
5. <mark style="color:green;">Click iLO 5 Configuration Utility.</mark>
6. <mark style="color:green;">Disable DHCP:</mark>
   1. <mark style="color:orange;">Click Network options.</mark>
   2. <mark style="color:orange;">Select OFF in the DHCP Enable menu. The IP Address, Subnet Mask, and Gateway IP Address boxes become editable. When DHCP enable is set to ON, user cannot edit these values.</mark>
7. <mark style="color:green;">Enter values in the IP Address, Subnet Mask and Gateway IP Address boxes.</mark>
8. <mark style="color:green;">To save the changes and exit, press F12. The iLO 5 configuration utility prompts user to confirm that user want to save the pending configuration changes.</mark>
9.  <mark style="color:green;">To save and exit, clickYes - Save Changes.</mark>

    <mark style="color:green;">The iLO 5 Configuration Utility notifies user that iLO must be reset in order for the changes to take effect.</mark>
10. <mark style="color:green;">Click OK.</mark>

    <mark style="color:green;">iLO resets, and the iLO session is automatically ended. User can reconnect in approximately 30 seconds.</mark>
11. <mark style="color:green;">Resume the normal boot process</mark>
    1. <mark style="color:orange;">Start the iLO remote console. The iLO 5 configuration utility is still open from the previous session.</mark>
    2. <mark style="color:orange;">Press ESC several times to navigate to the System Configuration page.</mark>
    3. <mark style="color:orange;">To exit the system utilities and resume the normal boot process, click Exit and resume system boot.</mark>

&#x20;

## iLO IP address acquisition DHCP <a href="#ariaid-title1" id="ariaid-title1"></a>

To enable iLO access after it is connected to the network, the iLO management processor must acquire an IP address and subnet mask. You can use a dynamic address or a static address.

**Dynamic IP address**

A dynamic IP address is set by default. iLO obtains the IP address and subnet mask from DNS or DHCP servers. This method is the simplest.

If you use DHCP:

* <mark style="color:green;">The iLO management port must be connected to a network that is connected to a DHCP server, and iLO must be on the network before power is applied. DHCP sends a request soon after power is applied. If the DHCP request is not answered when iLO first boots, it will reissue the request at 90-second intervals.</mark>
* <mark style="color:green;">The DHCP server must be configured to provide DNS and WINS name resolution.</mark>

***

## **Access iLO from Your Laptop**

**1. Connect to the Same Network**

<mark style="color:green;">Make sure your</mark> <mark style="color:green;"></mark><mark style="color:green;">**laptop is on the same network/subnet**</mark> <mark style="color:green;"></mark><mark style="color:green;">as the iLO port, unless you've set it up with a public IP or through VPN access.</mark>

**2. Get the iLO IP Address**

You probably set a static IP or got it from DHCP. If unsure:

* <mark style="color:green;">Check the iLO display on the server’s front panel (if it has one).</mark>
* <mark style="color:green;">Boot into BIOS → iLO Configuration Utility (press</mark> <mark style="color:green;"></mark><mark style="color:green;">`F8`</mark> <mark style="color:green;"></mark><mark style="color:green;">during POST when prompted).</mark>
* <mark style="color:green;">Or check DHCP logs/router if you used dynamic IP.</mark>

**3. Access via Web Browser**

* <mark style="color:green;">Open a browser (Chrome/Firefox/Edge).</mark>
*   <mark style="color:green;">Type in the iLO IP address:</mark>

    ```
    https://<iLO_IP>
    ```

    <mark style="color:green;">Example:</mark>

    ```
    https://192.168.1.100
    ```
* <mark style="color:green;">Accept the SSL certificate warning (iLO uses a self-signed cert by default).</mark>

**4. Log in**

* <mark style="color:green;">Use the</mark> <mark style="color:green;"></mark><mark style="color:green;">**iLO credentials**</mark> <mark style="color:green;"></mark><mark style="color:green;">you configured (or default ones from the server tag/card if unchanged).</mark>
* <mark style="color:green;">Default iLO username is often</mark> <mark style="color:green;"></mark><mark style="color:green;">`Administrator`</mark><mark style="color:green;">.</mark>

**5. You're in!**

Now you’ll see the **iLO web interface**, where you can:

* <mark style="color:green;">View server health</mark>
* <mark style="color:green;">Open remote console</mark>
* <mark style="color:green;">Mount virtual media</mark>
* <mark style="color:green;">Power cycle the server</mark>
* <mark style="color:green;">Configure settings</mark>



***

## REFERENCES

* [https://github.com/ipmitool/ipmitool](https://github.com/ipmitool/ipmitool)
* [https://helpdesk.editshare.com/hc/en-us/articles/24621101608475-Configuring-the-HP-ILO](https://helpdesk.editshare.com/hc/en-us/articles/24621101608475-Configuring-the-HP-ILO)
