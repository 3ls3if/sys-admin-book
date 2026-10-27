---
icon: anchor-circle-check
---

# Allow Ports on Windows Firewall

## Using CMD (Command Prompt / PowerShell)

```powershell
netsh advfirewall firewall add rule name="Allow Port XYZ" dir=in action=allow protocol=TCP localport=PORT_NUMBER

# To allow port 8080 for TCP:
netsh advfirewall firewall add rule name="Allow TCP 8080" dir=in action=allow protocol=TCP localport=8080

# To allow port 53 for UDP:
netsh advfirewall firewall add rule name="Allow UDP 53" dir=in action=allow protocol=UDP localport=53

# To delete the rule:
netsh advfirewall firewall delete rule name="Allow TCP 8080"
```



## Using GUI (Graphical User Interface)

* <mark style="color:blue;">Press</mark> <mark style="color:blue;"></mark><mark style="color:blue;">`Win + R`</mark><mark style="color:blue;">, type</mark> <mark style="color:blue;"></mark><mark style="color:blue;">`wf.msc`</mark><mark style="color:blue;">, and press</mark> <mark style="color:blue;"></mark><mark style="color:blue;">**Enter**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">(opens</mark> <mark style="color:blue;"></mark>_<mark style="color:blue;">Windows Defender Firewall with Advanced Security</mark>_<mark style="color:blue;">).</mark>
* <mark style="color:blue;">In the left pane, click on</mark> <mark style="color:blue;"></mark><mark style="color:blue;">**Inbound Rules**</mark><mark style="color:blue;">.</mark>
* <mark style="color:blue;">In the right pane, click</mark> <mark style="color:blue;"></mark><mark style="color:blue;">**New Rule...**</mark>
* <mark style="color:blue;">In the New Inbound Rule Wizard:</mark>
  * <mark style="color:green;">**Select "Port"**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>
  * <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**TCP**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**UDP**</mark>
  * <mark style="color:green;">Enter the</mark> <mark style="color:green;"></mark><mark style="color:green;">**specific port number**</mark> <mark style="color:green;"></mark><mark style="color:green;">(e.g., 8080) → Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>
  * <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Allow the connection"**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>
  * <mark style="color:green;">Select where this rule applies (Domain, Private, Public) → Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>
  * <mark style="color:green;">Give the rule a</mark> <mark style="color:green;"></mark><mark style="color:green;">**name**</mark> <mark style="color:green;"></mark><mark style="color:green;">(e.g., "Allow TCP 8080") → Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Finish**</mark>



{% hint style="warning" %}
#### Notes:

* Use **inbound rules** to allow incoming connections.
* Use **outbound rules** to control outgoing connections.
* You can modify rules later via `wf.msc` under **Inbound/Outbound Rules**.
{% endhint %}

