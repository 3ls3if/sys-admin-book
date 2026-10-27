---
icon: globe-pointer
---

# DNS Zone Editor



DNS Zone Editor

OVIPanel provides a simple and powerful module named DNS Zone Editor using which you can configure DNS records for your domain. DNS will maintain a directory of domain names and translates it to IP address. This is helpful because domain names are very easy to remember and can be accessed very easily. It helps a lot for the web owners to change their web hosts without changing their domain names, instead change the DNS entry of domain name and point them to the new web host’s name servers.

&#x20;

DNS Zone Editor Consists of A,  AAAA, CNAME, MX, TXT, SRF, SPF, NS Records. In this page, we will discuss in detail regarding the records, its purpose, and its syntax.

&#x20;

A Record: It commonly known as address record, It is used to map your domain name to the IP address means it will find the IP address of a computer connected to the internet from a name. For example: Whenever you send request from your browser to the website i.e hostingraja.in, will get re-directed to the server with IP address 182.18.188.139. You can use dig command on the terminal to determine the A record associated with a domain name. The result is contained in the ANSWER section and it contains the fully-qualified domain name (FQDN), the remaining time-to-live (TTL) and the IP address. A Record maps a hostname to a 32-bit IPv4 address.

&#x20;

Example of A Record with Syntax:

hostingraja.in       IN A 182.18.188.139

Where

hostingraja.in: is the domain name

IN: indicates Internet

A: indicates the Address record.

The above example indicates that the IP Address for the domain hostingraja.in is 182.18.188.139

You can use ping and dig check your IP address which is associated with your domain name.

&#x20;

&#x20;

AAAA Record: An AAAA record or IPv6 address record maps a hostname to a 128-bit IPv6 address. It indicates that the IPv6 address is four times the size of the IPv4 address.

Example of AAAA Record with Syntax:

linux  aaaa 3ffe:1900:4545:2:02d0:09ff:fef7:6d2c

&#x20;

CNAME Record: A CNAME record makes one domain name as an alias of another domain name. The aliased domain name gets all the subdomains and DNS records of the original. We can make use of CNAME record whenever we want to associate a new subdomain to an already existing A record i.e. we can make "www.hostingraja.in" to "hostingraja.in", which should already have been assigned an IP with an A record. So that we can have many subdomains as per our requirement without having to specify the IP for every record. Use a CNAME if you have more services pointing to the same IP. This way you will have to update only one record in the convenience of a change of IP address.

Example Of CNAME With syntax:

mail.hostingraja.IN CNAME mail.hostingraja.info

&#x20;

MX Record: An MX record or mail exchange record sets the mail delivery destination for a domain or subdomain.MX Entries must point to a domain and never point directly to an IP address.

Example with MX Record Syntax:

hostingraja.info  86400 IN MX 10 mail.hostingraja.info

Where

Hostingraja.info: indicates hostname

86400:  is TTL

IN:  indicates Internet

MX: indicates Mail exchange record

10: is the priority

Mail.hostingraja.info: indicates the target

&#x20;

&#x20;

TXT Record: This record is used to implement the Sender Policy Framework specification. It is used by many email systems which will help to identify if the email is coming from a trusted source, helping filter out spam or messages pretending to be from your domain. It is commonly used to create an SPF record on nameservers, also used to create a DKIM record for mail signing.

&#x20;

Example of TXT Record with syntax :

1. SPF Record:

hostingraja.info   3600 IN TXT v=spf1 a mx ptr a:103.92.235.94 mx:hostingraja.info ip4:103.92.235.94 \~all

2. DKIM Record:

default\_domainkey  3600 IN TXT v=DKIM1;k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDUSPDLgfkKIR8EvIP3nCWZ0jK3C1JzTBBabcADE7bXziKGW0MgeGkiA7YMJzaaZ67CeO6B+kLTvNTbOYI0CxG3NPC9cS55FtCkxj6Iq/eHFRRQfgOphQuHssALD/xGa4ZJsNJlsZ/3CUktSv3eszFP1yLvRzAWdvsM6IId8FneOwIDAQAB

SRV Record: An SRV i.e Service record points one domain to another domain name using a specific destination port. SRV records allow specific services, such as VOIP or IM, to be directed to a separate location.

&#x20;

Example of SRV Record with the syntax:

\_service.\_protocol.example.com  SRV 10 0 5060 service.example.com

1. Service: The name of the service must be preceded by an underscore (\_) and followed by a period (.). The service could be something like \_xmpp.
2. Protocol: The name of the protocol must be proceeded by an underscore (\_) and followed by a period (.). The protocol could be something like \_tcp.
3. Domain: The name of the domain that will receive the original traffic for this service.
4. Priority: The first number (10 in the example above) allows you to set the priority for the target server. You can set different targets with different priorities, which allows you to have a fallback server (or servers) for that service. Lower numbers have a higher priority.
5. Weight: If two records have the same priority, weight is used instead.
6. Port: The TCP or UDP port on which the service runs.
7. Target: The target domain or subdomain. This domain must have an A or AAAA record that resolves to an IP address.

&#x20;

NS Record: A name server translates domain names into IP addresses. This makes it possible for a user to access a website by typing in the domain name instead of the website's actual IP address. For example, when you type in "www.hostingraja.in" the request gets sent to the demo site's nameserver which returns the IP address of the hostingraja site website.

Each domain name must have at least two name servers listed when the domain is registered. These name servers are commonly named ns1.servername.com and ns2.servername.com, where "servername" is the name of the server. The first server listed is the primary server, while the second is used as a backup server if the first server is not responding. Once you update with the name server it takes around 48 hours to get into reflecting, usually it takes 3 to 4 hours because it takes time for each DNS server to update other servers around the world about the change you made. The main advantage of using this Name server is you can change name server whenever you want and if do not want your domain to our name server you will be not able to use our web and email systems to configure your domain name, nor will you be able to use our hosting solutions. To check your name server details you can go to https://intodns.com/ and enter your domain and submit.

&#x20;

Example of NS Record with the syntax:

hostingraja.info   172800 IN NS ns1.hostingraja.info

hostingraja.info   172800 IN NS ns2.hostingraja.info

&#x20;

Steps you need to follow to Configure DNS:

Step1: Select the domain name from the Drop-down and click on Edit.

&#x20;

Step2: Now you will be able to see DNS Types like A, AAAA, CNAME, MX, TXT, SRF, SPF, NS. Select appropriate type

![](https://image.hostingraja.in/images/dns-zone-editor.png)

Step 3: Click on Add New Record and fill the details and click on Save changes which are present in the top. Kindly follow the same steps for other DNS Types. The syntax of each type is mentioned in the above examples.

For adding  CNAME >> select Cname >> enter the hostname, TTL and target and click on save

\
![](https://image.hostingraja.in/images/dns-zone-editor1.png)

For adding MX >> select hostname >> enter the hostname, TTL, priority, target and click on save.\
\
![](https://image.hostingraja.in/images/dns-zone-editor2.png)

For adding TXT record >> select TXT >> enter the hostname, TTL and Target and save changes\
\
![](https://image.hostingraja.in/images/dns-zone-editor3.png)

For adding NS record (nameserver record) >> select NS >> enter the nameserver details like hostname, TTL, target and click on save\
\
![](https://image.hostingraja.in/images/dns-zone-editor4.png)

![](https://image.hostingraja.in/images/dns-zone-editor5.png)\
<br>

Step 4: After it is done log-in to root access in the command prompt and execute the following command

&#x20;                       service named restart

&#x20;

Note:

\>> Any DNS record which is been updated will take 24-48 hours to reflect globally

\>>You can check, if the record is updated correctly using the website :

{% embed url="https://mxtoolbox.com" %}



***

## REFERENCES

* [https://www.ovipanel.in/tutorials/3-1/3646-dns-zone-editor](https://www.ovipanel.in/tutorials/3-1/3646-dns-zone-editor)
