---
icon: mixer
---

# Protecting Endpoints with Xcitium OpenEDR

<a href="https://www.openedr.com/" target="_blank">https://www.openedr.com</a>

<figure><img src="https://miro.medium.com/v2/resize:fit:1040/1*lck5CmVwXv0ph6RVazHCsw@2x.jpeg" alt="" height="270" width="520"><figcaption></figcaption></figure>

Xcitium OpenEDR is a free, open-source endpoint protection and response (EDR) system. Like typical EDR systems, Xcitium OpenEDR follows a client-server model: a centrally managed server hosts a security program, and an accompanying client program runs on each endpoint. This client program, or agent, sends information such as logs, local machine data, and malware scan results to the server. With the server EDR program, the server administrator analyzes this information to defend endpoints from malware and additional threats.

### Learning objectives <a href="#id-9051" id="id-9051"></a>

After completing this lab, I am now able to:

* Set up the Xcitium cloud manager
* Add an endpoint device to the OpenEDR system
* Locate endpoint data in the cloud manager
* Manage endpoint patches from the cloud manager
* Scan an endpoint for malware and find the results in the cloud manager

### Prerequisites <a href="#id-42fd" id="id-42fd"></a>

* A smartphone with an authenticator application installed.
* One or more devices to use as an endpoint.

Some examples of common authenticator applications include the following programs:

\- Google Authenticator

\- Microsoft Authenticator

\- LastPass Authenticator

\- **2FAS** — \*Downloaded in the App Store and used for this lab _(shown below)_

<figure><img src="https://miro.medium.com/v2/resize:fit:774/1*BNAzNCF1tzfwyw5yl92vJw@2x.jpeg" alt="" height="130" width="387"><figcaption></figcaption></figure>

Note: The device must be an internet-enabled computer, tablet, or smartphone with one of the following operating systems (OSs) installed:

\- Windows

\- MacOS

\- Linux

\- iOS

\- Android

<figure><img src="https://miro.medium.com/v2/resize:fit:660/1*pG0WWNOGfZT9Sr6JBlvJkA@2x.jpeg" alt="" height="153" width="330"><figcaption></figcaption></figure>

For the sake of this lab, I set up endpoint protection on the same device that I used to explore the cloud manager. But for a more realistic experience, use a separate device as your endpoint.

### _Overview_ <a href="#d91e" id="d91e"></a>

> _In this lab, I gained skills in handling and safeguarding endpoints with Xcitium OpenEDR. I started by configuring the Xcitium cloud manager, a tool for overseeing and controlling endpoints. After that, I incorporated two endpoints into the EDR system: my Mac OS and iOS device. I then grasped the process of utilizing the cloud manager to access security data for the endpoints and managing their protection settings. Lastly, I acquired knowledge about scanning endpoints for malware and locating the scan outcomes within the cloud manager interface._

<figure><img src="https://miro.medium.com/v2/resize:fit:572/1*d-tJ_4ufJOvfBaGZ5abCkg@2x.jpeg" alt="" height="176" width="286"><figcaption></figcaption></figure>

_Here’s a view of the OpenEDR interface after logging in, along with a sneak peek at some of the platform’s notable features as I navigated through the platform:_

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*59rPqdaKMCzZ0hXq_b4F0Q@2x.jpeg" alt="" height="279" width="700"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*aTj4zrHrohj-tSVPrZeUWg@2x.jpeg" alt="" height="497" width="700"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*8qt4mzn68rI6RBhccgZlgw@2x.jpeg" alt="" height="497" width="700"><figcaption><p>After creating an account, installing the software and enrolling my devices as instructed, the OpenEDR cloud manager is deployed and ready for use. My next step is to add one or more endpoints, which I completed (shown above)</p></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:4808/1*CUQHoDQvbVEC-C4cGtYISg@2x.jpeg" alt="" height="1694" width="500"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:4808/1*bmitcnRX-9kIsXsjgqRAUw@2x.jpeg" alt="" height="1694" width="500"><figcaption><p>The Audit pane provides an overview of the endpoints that OpenEDR is monitoring. It displays information such as the operating systems and device types. It also displays the number of corporate-owned devices versus personal devices, which would require different compliance rules to ensure they meet enterprise guidelines. (shown above)</p></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*6JNSrUn8WR11Rl-1dJhIgg@2x.jpeg" alt="" height="497" width="700"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*re_mi7f4o8Uoci9jqnVfhA@2x.jpeg" alt="" height="494" width="700"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*BgSLm0MLIhI83yfoMrCj1A@2x.jpeg" alt="" height="112" width="700"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*y1NdjGOjk-WKwBT1EB2n9A@2x.jpeg" alt="" height="162" width="700"><figcaption></figcaption></figure>

**Note:** _Depending on your device update status, you might not have any results. More entries will appear over time as patches become available._

Next, let’s secure the OS!

As you can see below, it’s as easy as 1,2,3 — where I selected my endpoint device (MacOS) to scan and check for viruses.

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*2iezUDW-VvzFWxbq8znJfA@2x.jpeg" alt="" height="439" width="700"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*tfilpP2yfk55DVUkRLZcAw@2x.jpeg" alt="" height="492" width="700"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:1400/1*-e3x38LEZ4F68HctI7lTUA@2x.jpeg" alt="" height="445" width="700"><figcaption></figcaption></figure>

<br>

***

## REFERENCES

* [https://medium.com/@lexuscollins/hands-on-lab-protecting-endpoints-with-xcitium-openedr-2ab310cf740f](https://medium.com/@lexuscollins/hands-on-lab-protecting-endpoints-with-xcitium-openedr-2ab310cf740f)
