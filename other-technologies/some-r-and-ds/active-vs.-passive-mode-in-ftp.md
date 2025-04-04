---
icon: file-invoice
---

# Active vs. Passive Mode in FTP

## **Active vs. Passive Mode in FTP**

FTP uses two channels for communication:

1. <mark style="color:green;">**Command Channel**</mark> <mark style="color:green;"></mark><mark style="color:green;">– Used for sending commands and responses.</mark>
2. <mark style="color:green;">**Data Channel**</mark> <mark style="color:green;"></mark><mark style="color:green;">– Used for transferring files.</mark>

**Active Mode (Default FTP Mode)**

* <mark style="color:green;">The</mark> <mark style="color:green;"></mark><mark style="color:green;">**client**</mark> <mark style="color:green;"></mark><mark style="color:green;">connects to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**server’s port 21**</mark> <mark style="color:green;"></mark><mark style="color:green;">(Command Channel).</mark>
* <mark style="color:green;">The server then</mark> <mark style="color:green;"></mark><mark style="color:green;">**initiates a connection**</mark> <mark style="color:green;"></mark><mark style="color:green;">from its</mark> <mark style="color:green;"></mark><mark style="color:green;">**port 20**</mark> <mark style="color:green;"></mark><mark style="color:green;">to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**client’s dynamic port**</mark> <mark style="color:green;"></mark><mark style="color:green;">(Data Channel).</mark>
* <mark style="color:green;">This can be blocked by</mark> <mark style="color:green;"></mark><mark style="color:green;">**client-side firewalls**</mark> <mark style="color:green;"></mark><mark style="color:green;">since the incoming connection from the server is often treated as suspicious.</mark>

**Passive Mode (Recommended for NAT & Firewalls)**

* <mark style="color:green;">The</mark> <mark style="color:green;"></mark><mark style="color:green;">**client**</mark> <mark style="color:green;"></mark><mark style="color:green;">connects to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**server’s port 21**</mark> <mark style="color:green;"></mark><mark style="color:green;">(Command Channel).</mark>
* <mark style="color:green;">Instead of the server initiating the Data Channel, it provides a</mark> <mark style="color:green;"></mark><mark style="color:green;">**random port range**</mark> <mark style="color:green;"></mark><mark style="color:green;">for the client to connect.</mark>
* <mark style="color:green;">The client</mark> <mark style="color:green;"></mark><mark style="color:green;">**initiates the Data Channel connection**</mark><mark style="color:green;">, which bypasses client-side firewalls and NAT restrictions.</mark>

