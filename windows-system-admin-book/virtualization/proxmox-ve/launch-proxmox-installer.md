---
icon: circle-play
---

# Launch Proxmox Installer

1\. Move to the server (machine) where you want to install Proxmox and plug in the USB device.

2\. While the server is booting up, access the boot menu by pressing the required keyboard key(s). Most commonly, they are either **Esc**, **F2**, **F10**, **F11**, or **F12**.

3\. Select the installation medium with the Proxmox ISO image and boot from it.

4\. The Proxmox VE menu appears. Select **Install Proxmox VE** to start the standard installation.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/05/install-proxmox-start-screen.png" alt="Proxmox installation start screen." height="440" width="800"><figcaption></figcaption></figure>

5\. Read and accept the EULA to continue.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/05/agree-to-the-eula.png" alt="Agree to the Proxmox EULA." height="557" width="800"><figcaption></figcaption></figure>

6\. Choose the target hard disk where you want to install Proxmox. Click **Options** to specify additional parameters, such as the filesystem. By default, it is set to [ext4](https://phoenixnap.com/glossary/ext4).

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/05/select-hard-disk.png" alt="Select hard disk for Proxmox installation." height="467" width="800"><figcaption></figcaption></figure>

7\. Next, set the location, time zone, and keyboard layout. The installer autodetects most of these configurations.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/05/select-location-and-time-zone.png" alt="Select location and time zone." height="390" width="800"><figcaption></figcaption></figure>

8\. Create a [strong password](https://phoenixnap.com/blog/strong-great-password-ideas) for your admin credentials, retype the password to confirm, and type in an email address for system administrator notifications.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/05/choose-root-password.png" alt="Choose root password." height="561" width="800"><figcaption></figcaption></figure>

9\. The final step in installing Proxmox is setting up the network configuration. Select the management interface, a [hostname](https://phoenixnap.com/kb/linux-hostname-command) for the server, an available IP address, the default [gateway](https://phoenixnap.com/glossary/what-is-gateway), and a [DNS server](https://phoenixnap.com/kb/what-is-domain-name-system). During the installation process, use either an [IPv4 or IPv6](https://phoenixnap.com/blog/ipv4-vs-ipv6) address. To use both, modify the configuration after installing.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/05/proxmox-network-configuration.png" alt="Configure network for Proxmox." height="521" width="800"><figcaption></figcaption></figure>

10\. The installer summarizes the selected options. After confirming everything is in order, press **Install**.

11\. Remove the USB drive and reboot the system after installation.

#### Step 4: Run Proxmox <a href="#step-4-run-proxmox" id="step-4-run-proxmox"></a>

1\. Once the system reboots, the Proxmox GRUB menu loads. Select **Proxmox Virtual Environment GNU/Linux** and press **Enter**.

2\. Next, the Proxmox VE welcome message appears. It includes an IP address that loads Proxmox. Navigate to that IP address in a web browser of your choice.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/proxmox-welcome-output.png" alt="Proxmox welcome output." height="212" width="774"><figcaption></figcaption></figure>

3\. After navigating to the required IP address, you may see a warning message that the page is unsafe because Proxmox VE uses self-signed [SSL certificates](https://phoenixnap.com/kb/types-of-ssl-certificates). Click the IP link to proceed to the Proxmox web management interface.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/accept-proxmox-certificate-and-proceed.png" alt="Accept proxmox certificate and proceed." height="410" width="532"><figcaption></figcaption></figure>

4\. To access the interface, [log in as root](https://phoenixnap.com/glossary/what-is-root-access) and provide the password you set when installing Proxmox.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/proxmox-ve-login.png" alt="Logging in as root user to the Proxmox web interface." height="249" width="482"><figcaption></figcaption></figure>

5\. A dialogue box pops up saying there is no valid subscription for the server. Proxmox offers an optional add-on service to which you can subscribe. To ignore the message, click **O**K.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/no-valid-subsciption-proxmox-message.png" alt="Confirming the no subscription message in Proxmox." height="241" width="566"><figcaption></figcaption></figure>
