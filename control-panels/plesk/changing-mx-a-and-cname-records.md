---
icon: arrows-rotate-reverse
---

# Changing MX, A, and CNAME Records

## **Changing the DNS Zone Records**

To navigate to the DNS Editor in Plesk, please follow the instructions below.

1. Log in to **Plesk**.
2.  Click the **Websites & Domains** tab.

    ![Websites and Domains Tab](https://content.hostgator.com/img/plesk-websites-and-domains.png)
3.  Find the domain to be edited and click the **DNS Settings** link.

    ![HostGator Plesk 18 DNS Settings](https://content.hostgator.com/img/plesk18-dns-settings.png)
4.  Choose from **DNS, SOA,** or **Zone Transfers,** depending on what changes you want to make with your domain.

    ![DNS Settings](https://content.hostgator.com/img/plesk18_dns_settings-section.png)
5.  After you make the change, there will be a box on the main DNS settings page for applying the changes to the DNS zone. This is to prompt you that if multiple changes need to be made, they would only be applied once to avoid repeatedly updating the serial number, as that can result in the zone being locked.

    ![DNS zone update alert](https://content.hostgator.com/img/plesk18_dns_change_alert.png)



***

## **How to edit an MX Record**

1. Log in to **Plesk**.
2.  Click the **Websites & Domains** tab.

    ![Websites and Domains Tab](https://content.hostgator.com/img/plesk-websites-and-domains.png)
3.  Find the domain to be edited and click the **DNS Settings** link.&#x20;

    ![HostGator Plesk 18 DNS Settings](https://content.hostgator.com/img/plesk18-dns-settings.png)
4.  Click on the existing **MX Record** under **Host** to edit.

    ![Select Domain](https://content.hostgator.com/img/plesk18_host_to_edit.png)
5. Change the **Record type** to **MX**.
6. The **Mail domain** field should be left blank.
7. Set the **Mail exchange server** to the name of your mail server (for example, _ghs.google.com_).
8. **Priority Number(s)** would be provided by the party who gave you the mail exchange server; if not, **very high(0)** is acceptable.
9.  After making your changes, click **OK**.&#x20;

    ![Host to Edit](https://content.hostgator.com/img/ples18_edit_mx.png)

\


***

## **How to edit an A Record**

1. Log in to **Plesk**.
2.  Click the **Websites & Domains** tab.

    ![Websites and Domains Tab](https://content.hostgator.com/img/plesk-websites-and-domains.png)
3.  Find the domain to be edited and click the **DNS Settings** link.

    ![HostGator Plesk 18 DNS Settings](https://content.hostgator.com/img/plesk18-dns-settings.png)
4.  Click on the existing **A Record** under **Host** to edit.

    ![Plesk - edit an A record](https://content.hostgator.com/img/plesk18_host_to_edit_a_record.png)
5. Keep the Domain name field blank.
6. Set the **TTL** to **14400**.
7.  For **IP Address**, enter the new IP of your desired server.

    ![edit existing A record in Plesk](https://content.hostgator.com/img/plesk18_edit_existing_a_record.png)
8. After making your changes, click **OK**.

\


***

## **How to edit a CNAME Record**

1. Log in to **Plesk**.
2.  Click the **Websites & Domains** tab.

    ![Websites and Domains Tab](https://content.hostgator.com/img/plesk-websites-and-domains.png)
3.  Find the domain to be edited and click the **DNS Settings** link.

    ![HostGator Plesk 18 DNS Settings](https://content.hostgator.com/img/plesk18-dns-settings.png)
4.  Click on the existing **CNAME Record** under **Host** to edit.

    ![Edit Cname Record in Plesk](https://content.hostgator.com/img/host_to_edit_cname_record.png)
5. Change the **Record type** to **CNAME.**
6. For **Domain name**, put in the subdomain you want to host.
7. For **Canonical name**, enter the name of your desired server.
8.  Set the **TTL** to **14400**.

    ![Edit CNAME in Plesk](https://content.hostgator.com/img/plesk18_edit_cname_records.png)
9. After making your changes, click **OK**.





***

## REFERENCES

* [https://www.hostgator.com/help/article/changing-mx-a-cname-records-plesk](https://www.hostgator.com/help/article/changing-mx-a-cname-records-plesk)





