---
icon: windows
---

# IIS: Generate CSR for Multi-Domain SSL

### How To Generate A Multi-Domain CSR On A Windows Server?

Let’s see how to generate a multi-domain CSR on a Windows Server that can be used to secure multiple domains. Let’s learn how to add multiple SAN, DNS, or Alt Names to the CSR.

**Step 1. Open MMC on the Windows server**

Hit **Win + R** to open the Run utilityType **mmc** in the box.Press **Ok**.<br>

<figure><img src="https://www.datocms-assets.com/104397/1708625732-2021-03-10_19h12_16.png?auto=format" alt=""><figcaption></figcaption></figure>

**Step 2. Add Certificate Snap-in**

Go to File > Add/Remove Snap-in..

<figure><img src="https://www.datocms-assets.com/104397/1708625739-2021-03-10_19h14_20.png?auto=format" alt=""><figcaption></figcaption></figure>

**Step 3. Select Certificates and press Add**

<figure><img src="https://www.datocms-assets.com/104397/1708625746-2021-03-10_19h16_52.png?auto=format" alt=""><figcaption></figcaption></figure>

**Step 4. Select the User or Computer Certificate snap-in**

Select the snap-in which you want to create the certificate. For demonstration, we are choosing **a Compute account**.Click **Next**.<br>

<figure><img src="https://www.datocms-assets.com/104397/1708625754-2021-03-10_19h26_45.png?auto=format" alt=""><figcaption></figcaption></figure>

**Step 5. Select Local Computer**

Select **the local computer** as you are going to create CSR on the same computer.Click **Finish**.

<figure><img src="https://www.datocms-assets.com/104397/1708625758-2021-03-10_19h28_19.png?auto=format" alt=""><figcaption></figcaption></figure>

**Step 6. Select Certificate (Local Computer) and click Ok**

<figure><img src="https://www.datocms-assets.com/104397/1708625765-2021-03-10_19h33_09.png?auto=format" alt=""><figcaption></figcaption></figure>

**Step 7. Create Custom Request**

Access your MMC snap-in> **right-click** the **Personal** folder.Select **All Tasks** > **Advanced Operations** > **Create Custom Request.**

<figure><img src="https://www.datocms-assets.com/104397/1708625772-create-custom-csr-request.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 8. CSR generation wizard**

The CSR generation wizard will open > Click **Next.**

<figure><img src="https://www.datocms-assets.com/104397/1708625776-csr-generation-wizard.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 9. Proceed without enrollment policy**

Select the option to **Proceed without enrollment policy** > Click **Next.**

<figure><img src="https://www.datocms-assets.com/104397/1708625783-proceed-without-enrollment-policy.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 10. Click Next at the PKCS # 10 window.**

<figure><img src="https://www.datocms-assets.com/104397/1708625790-select-pkcs-10.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 11. Edit Properties**

From the **Details** drop-down menu > Click **Properties.**

<figure><img src="https://www.datocms-assets.com/104397/1708625798-edit-properties.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 12. Enter a Friendly Name**

<figure><img src="https://www.datocms-assets.com/104397/1708625805-five-a-name.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 13. Add the CSR contents:**

Access the **Subject** tab > in the **Subject name:** select the types (Common name) from the dropdown list and add the values required for your CSR. Just add the multiple DNS values as shown here. Each DNS represents a domain name.\
\
**Example:**\
**CN =** \<thesecmaster.com>\
**DNS =** \<thecrypticworld.com>\
**DNS =** \<example.com>\
**DNS =** \<deals.com>\
**DNS =** \<domain>\
<br>

<figure><img src="https://www.datocms-assets.com/104397/1708634743-multi-domain-csr-1.png?auto=format" alt=""><figcaption></figcaption></figure>

**Step 14. Set Private Key settings**

Click the **Private Key** tab > click the drop-down for **Key options** > select **Key size: 2048** and check the option to **Make private key exportable** > Click **OK.**

<figure><img src="https://www.datocms-assets.com/104397/1708625816-set-private-key-settings.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 15. Save the CSR file to a location.**

Select **Base 64** and Click **Next** > Click **Browse.**

<figure><img src="https://www.datocms-assets.com/104397/1708625820-save-csr-file.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 16. Select a location to save the CSR file. Enter a name for the file and click Save.**



<figure><img src="https://www.datocms-assets.com/104397/1708625828-chose-location-to-save-csr-file.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 17. Click Finish.**

<figure><img src="https://www.datocms-assets.com/104397/1708625835-fisish.jpeg?auto=format" alt=""><figcaption></figcaption></figure>

**Step 18. The CSR file will be present at the location you saved it and can be used to request the SSL certificate as needed.**



***

If you ever try opening a CSR from using a text editor, you will see a base64 encoded text. You should need to decode it to read the content of the CSR. Either you can use [OpenSSL](https://thesecmaster.com/procedure-to-install-openssl-on-the-windows-platform/) or online tools to decode the CSR. We want to introduce one such wonderful tool for you.

[Namecheap](https://decoder.link/result): https://decoder.link/resultt![](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHBwgHBgoICAgFCgoFBQwFBQUFBREJCgUMFxMZGBYTFhUaHysjGh0oHRUWJDUlKC0vMjIyGSI4PTcwPCsxMi8BCgsLBQUFEAUFEC8cFhwvLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vL//AABEIAA4AGAMBIgACEQEDEQH/xAAVAAEBAAAAAAAAAAAAAAAAAAAAB//EABQQAQAAAAAAAAAAAAAAAAAAAAD/xAAVAQEBAAAAAAAAAAAAAAAAAAACAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AJkAQgCT/9k=)

<figure><img src="https://www.datocms-assets.com/104397/1708625846-2021-03-10_20h35_15.png?auto=format" alt=""><figcaption></figcaption></figure>

Copy and paste the content of your CSR here in the box and click **Decode**. It not only decodes the CSR but also reports any errors if it has.
