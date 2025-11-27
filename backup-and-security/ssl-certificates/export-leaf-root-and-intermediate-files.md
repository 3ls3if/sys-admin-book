---
icon: id-card-clip
---

# Export Leaf, Root, and Intermediate Files

## How to extract the Root and Intermediate certificates from the certificate bundle

### <mark style="color:red;">Root Certifcate</mark>

To get the **Root Certificate:**\
\
1\. Double-click the Certificate to open the file.\
2\. Go to the Certification Path tab, highlight the first certificate (Root), then click the View Certificate.\
\
![root\_cert\_image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EMHt000005rn4x)\
<br>

3\. Go to the Details Tab and hit Copy to file.\
\
![image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EM2J000003ssY1)\
\
4\. This would open the Certificate Export Wizard and Hit Next.\
\
![image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EM2J000003ssYQ)\
\
5\. Select Base-64, then hit Next.\
\
![image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EM2J000004XmdJ)\
\
6\. Save the file as <mark style="color:green;">Root.txt</mark>.



***

### <mark style="color:red;">Intermediate Certificate</mark>

To get the **Intermediate Certificate:**\
\
1\. Double-click the Certificate to open the file.\
2\. Go to the Certification Path tab, highlight the second certificate (Intermediate), then click the View Certificate.\
![inter\_cert\_image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EMHt000005rn52)\
\
\
3\. Go to the Details Tab and hit Copy to file.\
\
![image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EM2J000003ssY1)\
\
4\. This would open the Certificate Export Wizard and Hit Next.\
\
![image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EM2J000003ssYQ)\
\
5\. Select Base-64, then hit Next.\
\
![image.png](https://solarwindscore.my.site.com/SuccessCenter/servlet/rtaImage?eid=ka1Ht000000H7qg\&feoid=00N5000000AcxPm\&refid=0EM2J000004XmdJ)\
\
6\. Save the file as <mark style="color:green;">intermediate.txt</mark>.



***

### <mark style="color:red;">Leaf Certificate</mark>

The **Leaf certificate** (also called the **end-entity certificate**) is the actual `.crt` file you received for your domain. This certificate is issued specifically for your server and is the first certificate in the chain.

* <mark style="color:green;">Rename the .crt file to leaf.txt and you are done.</mark>



***

## REFERENCES

* [https://learn.microsoft.com/en-us/azure/application-gateway/mutual-authentication-certificate-management](https://learn.microsoft.com/en-us/azure/application-gateway/mutual-authentication-certificate-management)





