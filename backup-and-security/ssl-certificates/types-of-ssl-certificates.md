---
icon: font-case
---

# Types of SSL Certificates

### What does an SSL certificate do?

An [SSL certificate](https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/) (more accurately called a [TLS](https://www.cloudflare.com/learning/ssl/transport-layer-security-tls/) certificate), is necessary for a website to have [HTTPS](https://www.cloudflare.com/learning/ssl/what-is-https/) encryption. An SSL certificate contains the website's [public key](https://www.cloudflare.com/learning/ssl/how-does-public-key-encryption-work/), the [domain name](https://www.cloudflare.com/learning/dns/glossary/what-is-a-domain-name/) it's issued for, the issuing certificate authority's digital signature, and other important information. It's used for authenticating an origin server's identity, which helps prevent [on-path attacks](https://www.cloudflare.com/learning/security/threats/on-path-attack/), domain spoofing, and other methods attackers use to impersonate a website and trick users.

HTTPS creates an encrypted connection between a user's browser and the web server they are communicating with, protecting the communications from being intercepted. SSL certificates are necessary for establishing this encrypted connection (see [What is an SSL certificate?](https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/) to learn more).

### What are the different types of SSL certificates?

**Single Domain SSL Certificates**

A single-domain SSL certificate applies to one domain and one domain only. It cannot be used to authenticate any other domain, not even subdomains of the domain it is issued for.

All pages on this domain are also secured with the certificate; for instance, if cloudflare.com has a single-domain certificate, then cloudflare.com/learning (the Learning Center main page) is also covered by that certificate.

<figure><img src="https://cf-assets.www.cloudflare.com/slt3lc6tev37/ND4BUNi8xaqKuKcYEfbXo/e05775718674775f2241d89c6333ab52/single-domain-ssl-certificate.svg" alt=""><figcaption></figcaption></figure>

**Wildcard SSL Certificates**

Wildcard SSL certificates are for a single domain and all its subdomains. A subdomain is under the umbrella of the main domain. Usually subdomains will have an address that begins with something other than 'www.'

For example, www.cloudflare.com has a number of subdomains, including blog.cloudflare.com, support.cloudflare.com, and developers.cloudflare.com. Each is a subdomain under the main cloudflare.com domain.

<figure><img src="https://cf-assets.www.cloudflare.com/slt3lc6tev37/7uh7zF2RnXoBNGblm7fYfM/20d4aed32e69d6b420385e752e522ea4/wildcard-ssl-certificate.svg" alt=""><figcaption></figcaption></figure>

A single Wildcard SSL certificate can apply to all of these subdomains. Any subdomain will be listed in the SSL certificate. Users can see a list of subdomains covered by a particular certificate by clicking on the padlock in the URL bar of their browser, then clicking on "Certificate" (in Chrome) to view the certificate's details.

**Multi-Domain SSL Certificates (MDC)**

A multi-domain SSL certificate, or MDC, lists multiple distinct domains on one certificate. With an MDC, domains that are not subdomains of each other can share a certificate.

<figure><img src="https://cf-assets.www.cloudflare.com/slt3lc6tev37/41egOiqMSGKk0tbChVC3HT/fa4517eacbe2bcd874a93e7926482850/multi-domain-ssl-certificate.svg" alt=""><figcaption></figcaption></figure>

### What are SSL certificate validation levels?

A bank doesn't issue a loan to someone before performing a credit check. Similarly, before a certificate authority (CA) issues an SSL certificate to an organization, they have to validate the organization; it has to be proven that the organization actually owns and operates the domain. This is what's known as SSL certificate validation.

However, there are different levels of validation, ranging from bare minimum validation to thorough background investigations. An SSL certificate from any of these validation levels provides the same degree of TLS encryption; the only difference is how thoroughly the CA has authenticated the organization's identity.

**Domain Validation SSL Certificates**

Domain Validation is the least-stringent level of validation. To obtain one of these SSL certificates, an organization only has to prove they control the domain. They can do this by altering the [DNS record](https://www.cloudflare.com/learning/dns/dns-records/) associated with the domain, or sometimes just by sending the CA an email. Often the process is automated.

This level of validation is the cheapest. It's a good option for blogs, portfolio sites, or for small businesses that are just looking to quickly launch HTTPS, especially if a business doesn't sell products via its website (e.g. a restaurant or coffee shop).

**Organization Validation SSL Certificates**

Organization Validation involves a manual vetting process: The CA will contact the organization requesting the SSL certificate, and they may do some further investigating. Organization Validation SSL certificates will contain the organization's name and address, making them more trustworthy for users than Domain Validation certificates.

**Extended Validation SSL Certificates**

<figure><img src="https://www.cloudflare.com/resources/images/slt3lc6tev37/2mkpUOPzl2jEPEERn2e57B/3b180ecab3ff7e0a5da1706434722573/ssl-certificate-secure-browsing.png" alt=""><figcaption></figcaption></figure>

Extended Validation involves a full background check of the organization. The CA will make sure that the organization exists and is legally registered as a business, that they actually are present at the address they list, and so on. This validation level takes the longest and costs the most, but Extended Validation SSL certificates are more trustworthy than other types of SSL certificates. Consequently, these certificates are necessary for a website's address to turn the browser URL bar green, the visual representation for users of a trustworthy TLS-encrypted site.

Large enterprises, financial institutions, and [eCommerce stores](https://www.cloudflare.com/ecommerce/)] should obtain Extended Validation certificates. This is especially crucial if a site or application handles sensitive customer data, such as passwords, credit card numbers, or names and addresses.

To learn more about how to get a free SSL certificate from Cloudflare, see our [SSL page](https://www.cloudflare.com/application-services/products/ssl/).



***

## REFERENCES

* [https://www.cloudflare.com/learning/ssl/types-of-ssl-certificates/](https://www.cloudflare.com/learning/ssl/types-of-ssl-certificates/)
* [https://www.cloudflare.com/learning/ssl/what-is-ssl/](https://www.cloudflare.com/learning/ssl/what-is-ssl/)

