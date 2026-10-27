---
icon: globe-pointer
---

# Block Access to Specific Websites

## **Use Windows Firewall to Block Domains**

Block access by creating outbound rules.

#### Steps:

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Windows Defender Firewall with Advanced Security**</mark>
2. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Outbound Rules > New Rule**</mark>
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Custom**</mark><mark style="color:green;">, then click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>
4. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Program**</mark><mark style="color:green;">, select “All programs”</mark>
5. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Protocol and Ports**</mark><mark style="color:green;">, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>
6. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Scope**</mark><mark style="color:green;">, in the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Remote IP addresses**</mark><mark style="color:green;">, choose “These IP addresses”</mark>
7. <mark style="color:green;">Add known IP ranges for the services (not always reliable as they change).</mark>
8. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Action**</mark><mark style="color:green;">, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Block the connection**</mark>
9. <mark style="color:green;">Name the rule, e.g., “Block Facebook”</mark>

{% hint style="warning" %}
⚠️ These services use CDNs and rotating IPs, so manual blocking via IPs may be incomplete unless a dedicated firewall/proxy is used.
{% endhint %}



***

## REFERENCES

* [https://www.esecurityplanet.com/networks/how-to-block-program-in-firewall/](https://www.esecurityplanet.com/networks/how-to-block-program-in-firewall/)
