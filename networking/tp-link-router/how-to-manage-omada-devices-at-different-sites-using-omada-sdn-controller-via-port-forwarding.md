---
icon: people-roof
---

# How to Manage Omada Devices at Different Sites Using Omada SDN Controller via Port Forwarding

As the network scenario shown below, the Controller and the devices which need to be managed are running in different site across the Internet. In this article, we will describe how to use the Controller on PC1 to manage the devices via Port Forwarding.

![](https://static.tp-link.com/upload/faq/image_20230423070153z.png)

### Step1: Set Port Forwarding for Router A on Omada SDN Controller

Note: In this article, we suppose Router A is an Omada gateway managed by the Controller, in practice, it is enough if Router A can set up the Port Forwarding.

1\. Go to Settings > Transmission > NAT > Port Forwarding, and click on Create New Rule.

![](https://static.tp-link.com/upload/faq/image-20230423150018-196_20230423070019h.jpeg)

2\. Set the parameters of the Port Forwarding rule. In this example:

Source Port: 29810-29814

Destination IP: 192.168.0.101

Destination Port: 29810-29814

### Step2: Inform the Router A’s WAN IP to the Omada devices

#### **Method 1: Omada Discovery Utility**

1\) Download the [Omada Discovery Utility](https://www.tp-link.com/en/support/download/omada-software-controller/#Omada_Discovery_Utility) and run it on PC2.

<div align="left"><img src="https://static.tp-link.com/upload/faq/image-20230423150019-198_20230423070020z.png" alt=""></div>

2\) Router B, switch, and EAP will be discovered by Utility. Click the "Select All" and "Batch Setting" buttons in the lower right corner.

![Show the positions of the 'Select All' and 'Batch Setting' buttons.](https://static.tp-link.com/upload/faq/3641-1_20251229130620w.jpeg)

3\) Enter the parameters needed, the Center IP is Router A's WAN IP, 192.168.1.200.

![Fill in the information as required.](https://static.tp-link.com/upload/faq/3641-2_20251229131625k.png)

Note: The default username and password of the devices in factory reset mode are admin/admin, if you have already set them in standalone mode and changed their username and password, you can manage them and enter their username and password separately.

4\) The devices will appear in the devices list with "PENDING" status, then you can adopt and manage them.

![The device shows "Pending" on the controller.](https://static.tp-link.com/upload/faq/3641-3_20251229130933i.jpeg)

#### **Method 2: Standalone Management Page**

* For Router B,

Go to System Tools > Controller Settings > Controller Inform URL, input the Router A WAN IP 192.18.1.200 in the box, then Router B can find the Controller.

![](https://static.tp-link.com/upload/faq/image-20230423150019-203_20230423070020d.jpeg)

* For Switch

Go to SYSTEM > Controller Settings > Controller Inform URL, then input 192.168.1.200.

![](https://static.tp-link.com/upload/faq/image-20230423150019-204_20230423070020r.jpeg)

* For EAP

Go to System > Controller Settings > Controller Inform URL, then input 192.168.1.200.

![](https://static.tp-link.com/upload/faq/image-20230423150019-205_20230423070020f.jpeg)

After informing the devices of the Controller IP, the devices will appear in the Controller Device list with the "PENDING" status, then you can adopt them.

![The device status displays as "Pending" on the controller.](https://static.tp-link.com/upload/faq/3641-3_20251229131022w.jpeg)

#### **Method 3: CLI Command**

#### Note: Currently, this method is only suitable for Switch and EAP.

* For Switch

1\) Access its management page, then go to SECURITY > Access Security > SSH Config > Global Config on the switch management page, and check the box to enable SSH.

![](https://static.tp-link.com/upload/faq/image-20230423150019-207_20230423070020p.jpeg)

2\) Enter the Switch’s IP in Putty and click on Open to access the CLI of the switch.

![](https://static.tp-link.com/upload/faq/image-20230423150019-208_20230423070020z.jpeg)

3\) The commands for informing the Controller IP are as below.

_enable_

_configure_

_controller inform-url 192.168.1.200_

![](https://static.tp-link.com/upload/faq/image-20230423150019-209_20230423070019p.png)

* For EAP

1\) Access its management page, then go to Management > SSH > SSH Server on the EAP management page, and check the box to enable SSH.

![](https://static.tp-link.com/upload/faq/image_20230423071228m.png)

2\) Enter EAP’s IP in Putty and click on Open to access the CLI of the EAP.

![](https://static.tp-link.com/upload/faq/image_20230423071251s.png)

3\) The commands for informing the Controller IP are as below.

_xsetctrladdr “192.168.1.200:29810”_

![](https://static.tp-link.com/upload/faq/image-20230423150019-212_20230423070019a.png)

#### **Method 4: DHCP Option 138**

Note: This method is only suitable for the DHCP clients, in most cases it is for the switch and EAP.

1\. Configure the DHCP Option 138

1\) Configure the DHCP server, in this example, it is Router B. Access Router B’s management page and go to Network > LAN > LAN, click the Operation ICON to modify the DHCP configuration.

![](https://static.tp-link.com/upload/faq/image-20230423150019-213_20230423070019k.png)

2\) Click on the "Advanced DHCP Options", and enter the WAN IP of Router A in the Option 138 entry. In this example, it is 192.168.1.200.

![](https://static.tp-link.com/upload/faq/image-20230423150019-214_20230423070020q.png)

3\) Reconnect the Switch and EAP to obtain the IP address again, the Switch and EAP will get the Controller IP from DHCP Option 138 and find Controller properly.

![The device successfully found the controller.](https://static.tp-link.com/upload/faq/3640-5_20251229131114p.png)

<br>

***

## REFERENCES

* [https://support.omadanetworks.com/ae/document/13141/](https://support.omadanetworks.com/ae/document/13141/)
