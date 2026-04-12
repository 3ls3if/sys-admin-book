# Simple-ACME guide for Windows Server | FairSSL

Simple-acme is the most widely used ACME client for Windows Server and a drop-in replacement for [win-acme](https://www.win-acme.com/), built by the same developer. It can be used everywhere win-acme is used today. This guide covers everything from installation to production with FairSSL as ACME server.

## Naming history

The project has changed names several times, which can cause confusion when searching:

* 2017-2023: **win-acme** (WACS) by Wouter Tinus. Windows-only, .NET Framework.
* 2024-now: **simple-acme**, fork with new maintainer. Cross-platform (.NET 8), ARI support, active development.

The domain [win-acme.com](https://www.win-acme.com/) still exists, but we recommend [simple-acme.com](https://simple-acme.com/) as the source.

## Download and requirements

| Version               | Description                                                                                                                                                                 |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Trimmed (recommended) | Much smaller download. For FairSSL Auto DNS, no plugins are needed since FairSSL handles DNS validation. Covers most setups.                                                |
| Pluggable             | All plugins included: DNS validation via your own DNS API keys, PEM/PFX export, Azure Key Vault. Use this if you need direct DNS API integration or special export formats. |

* **OS:** Windows Server 2012+ (x64). Linux beta available.
* **Runtime:** .NET 8 (bundled with download).
* **Current version:** v2.3.5
* **Licence:** Apache 2.0 (open source).
* **Installation:** Extract to `C:\Simple-Acme`. No installer, just copy the folder. Scripts are in `C:\Simple-Acme\Scripts`.

## Setup with FairSSL ACME server

Before starting simple-acme, you need to create EAB credentials in the FairSSL control panel. EAB (External Account Binding) links ACME certificates to your FairSSL account, so all certificates, clients and renewals are visible and monitored.

{% stepper %}
{% step %}
### Create EAB keys in FairSSL

Log in to the **control panel**, go to ACME and click **Connect ACME client**. You will receive a `Key ID` and an `HMAC Key`.
{% endstep %}

{% step %}
### Register account with EAB

Run simple-acme with FairSSL as server and the EAB keys from step 1:

```bash
simple-acme.exe --register ^
  --baseuri https://acme.fairssl.dk/acme/ ^
  --eab-key-identifier YOUR_KEY_ID ^
  --eab-key YOUR_HMAC_KEY ^
  --eab-algorithm HS256 ^
  --emailaddress your@email.com ^
  --accepttos
```
{% endstep %}

{% step %}
### Verify registration

Check in the FairSSL control panel that the client is visible under your ACME profile. The account is now linked to FairSSL.
{% endstep %}
{% endstepper %}

**Server URL:** FairSSL's ACME server URL is `https://acme.fairssl.dk/acme/`. It follows [RFC 8555](https://datatracker.ietf.org/doc/html/rfc8555) and supports ARI ([RFC 9773](https://datatracker.ietf.org/doc/html/rfc9773)). Use the staging server `https://acme.fairssl.dk/acme-staging/` for testing.

## Interactive menu: your first certificate

Start `simple-acme.exe` without arguments to open the interactive menu. On first run, you select the ACME server and register your account.

```
 Please choose from the menu:
  N: Create certificate (default settings)
  M: Create certificate (full options)
  R: Run renewals (0 currently due)
  A: Manage renewals (1 total)
  O: More options...
  Q: Quit
```

### M: Full configuration (recommended)

We recommend **M** (full options) so you have full control over all settings and do not miss anything. You select manually:

1. Source — Where domain names come from: IIS (automatic), manual (you specify names), or CSR (existing key).
2. Validation — HTTP-01 (selfhosting, filesystem, FTP, WebDAV), DNS-01 (23+ DNS providers, acme-dns, script) or TLS-ALPN-01.
3. CSR — Key type: RSA (default 3072 bit) or EC/ECDSA (default P-384). Can be changed.
4. Store — Where the certificate is stored: Windows Certificate Store, IIS Central Certificate Store, PEM files, PFX, Azure Key Vault.
5. Installation — What happens after: IIS binding update, script execution, or both.

**N** (default settings) is faster, but uses HTTP-01 and default settings. For servers behind a firewall, wildcard certificates, or special installations such as Exchange and RDP, always use **M**.

## CLI automation (unattended mode)

For automation and CI/CD, use CLI arguments instead of the interactive menu. Below are the most common scenarios.

### IIS site with FairSSL Auto DNS

Wildcard + apex domain, validated via DNS-01 with FairSSL Auto DNS. No DNS API keys needed. `--siteid 1` installs the certificate on IIS site 1 and automatically binds it to the hostnames in the site that match the certificate's names.

```bash
simple-acme.exe ^
  --baseuri https://acme.fairssl.dk/acme/ ^
  --source manual ^
  --host "*.your-domain.com,your-domain.com" ^
  --validationmode dns-01 ^
  --validation acme-dns ^
  --csr ec ^
  --store certificatestore ^
  --installation iis ^
  --siteid 1 ^
  --accepttos
```

### DNS validation with your own DNS provider and extra PEM + PFX (pluggable)

If you are not using Auto DNS and instead have direct API access to your DNS provider (requires the pluggable version). This example validates via Cloudflare API, stores the certificate in Windows Certificate Store, as PEM files and as PFX, and installs on IIS site 1:

```bash
simple-acme.exe ^
  --baseuri https://acme.fairssl.dk/acme/ ^
  --source manual ^
  --host www.your-domain.com,your-domain.com ^
  --validationmode dns-01 ^
  --validation cloudflare ^
  --cloudflareapitoken YOUR_CF_TOKEN ^
  --csr ec ^
  --store certificatestore,pemfiles,pfxfile ^
  --pemfilespath C:\certs\your-domain.com ^
  --pfxfilepath C:\certs\your-domain.com ^
  --pfxpassword PASSWORD ^
  --installation iis ^
  --siteid 1 ^
  --accepttos
```

### Storage options (store)

Simple-acme can store certificates in multiple ways. Combine them with commas in `--store`.

#### Windows Certificate Store

```bash
--store certificatestore
```

Default for IIS, Exchange, RDP. Certificate is installed in the Local Machine store.

#### PEM files (certificate + key)

```bash
--store pemfiles ^
--pemfilespath C:\certs\
```

For Nginx, HAProxy, network equipment. Generates .pem and .key files.

#### PFX file (PKCS#12)

```bash
--store pfxfile ^
--pfxfilepath C:\certs\ ^
--pfxpassword PASSWORD
```

For import into other systems. Password-protected.

Combine storage types: `--store certificatestore,pemfiles` saves to Windows Certificate Store and exports PEM files simultaneously.

### Post-renewal script

Run a script after successful renewal, for example to activate the certificate on network equipment or restart a service:

```bash
simple-acme.exe ^
  --baseuri https://acme.fairssl.dk/acme/ ^
  --source manual ^
  --host rdp.your-domain.com ^
  --validationmode dns-01 ^
  --validation acme-dns ^
  --csr ec ^
  --store pemfiles ^
  --pemfilespath C:\certs\rdp ^
  --installation script ^
  --script "C:\scripts\deploy-cert.ps1" ^
  --scriptparameters "'{CertThumbprint}' '{StoreType}'" ^
  --accepttos
```

All arguments with `^` are Windows CMD line continuation characters. In PowerShell, use backtick `` ` `` instead. Values with special characters (wildcards, spaces) must be enclosed in double quotes.

## Validation methods

### HTTP-01

Simple-acme places a file on port 80, which the CA fetches. Default in the N menu (selfhosting).

**Advantages**

* Simple setup, no DNS access needed
* Works with all DNS providers

**Limitations**

* Port 80 must be open from the outside
* Cannot be used for wildcards
* Redirects from HTTP to HTTPS are not allowed during validation
* All SAN names must resolve to the same server

### DNS-01

**Recommended**

Creates a TXT record `_acme-challenge.domain` in your DNS. Works behind firewalls and for wildcards.

**Advantages**

* Works behind firewalls, no open ports needed
* Supports wildcards
* Server does not need to be exposed to the internet

**Requirements**

* DNS provider API, acme-dns, CNAME delegation or script
* See [FairSSL Auto DNS](https://www.fairssl.dk/en/ssl-automation/auto-dns) for the simplest solution

### TLS-ALPN-01

Presents a self-signed certificate on port 443 with ALPN extension ([RFC 8737](https://datatracker.ietf.org/doc/html/rfc8737)).

**Advantages**

* Does not require port 80
* Works when HTTP is disabled

**Limitations**

* Requires simple-acme to temporarily bind port 443
* Cannot be used for wildcards
* IIS must be stopped during validation

### DNS plugins (23+ providers)

Simple-acme supports automatic DNS validation with the following providers via the pluggable version:

Cloudflare\
AWS Route 53\
Azure DNS\
Google Cloud DNS\
DigitalOcean\
Hetzner\
GoDaddy\
Linode\
TransIP\
Simply.com\
Domeneshop\
DreamHost\
DNS Made Easy\
DNSExit\
NS1\
LuaDNS\
Aliyun\
Tencent Cloud\
HuaWei Cloud\
Infomaniak\
Webnames.ca\
acme-dns\
RFC 2136 (nsupdate)

**FairSSL Auto DNS:** If your DNS provider is not on the list, or you do not want to give DNS API keys to the server, you can use [FairSSL Auto DNS](https://www.fairssl.dk/en/ssl-automation/auto-dns). Create a permanent CNAME record `_acme-challenge.your-domain` pointing to FairSSL's validation service. FairSSL then handles DNS validation automatically, without keys or scripts.

## Key types and sizes

Simple-acme supports RSA and ECDSA keys. The choice affects handshake speed, bandwidth and future-proofing.

| Key type | CLI flag    | Default            | Our recommendation                |
| -------- | ----------- | ------------------ | --------------------------------- |
| RSA      | `--csr rsa` | 3072 bit (SHA-512) | 4096 bit, only for legacy clients |
| ECDSA    | `--csr ec`  | P-384 (secp384r1)  | P-384 for new installations       |

**Our recommendation: ECDSA P-384.** Stronger than RSA 3072 with a fraction of the key size. Faster handshakes, lower CPU usage, smaller certificates. All modern browsers, operating systems and servers support ECDSA. P-384 is simple-acme's default for EC.

**Avoid RSA 2048 if possible.** ECDSA is faster and more future-proof. CA/Browser Forum has discussed raising the minimum threshold for RSA, but nothing has been decided yet. If you must use RSA, choose 3072 bit or higher. See our [guide to key types](https://www.fairssl.dk/en/what-is-ssl) for details.

Simple-acme defaults to P-384 for EC, which we recommend. If you need to change key type, it can be done via `settings.json`:

```json
{
  "CSR": {
    "EC": {
      "CurveName": "secp384r1"
    }
  }
}
```

## IIS binding management

The simplest approach is to use `--installation iis`. Simple-acme automatically finds the IIS sites that have hostnames matching the certificate's domain names, and updates their HTTPS bindings.

### Automatic (recommended)

Without `--siteid`, simple-acme finds the matching sites automatically:

```bash
simple-acme.exe --source iis --installation iis
```

This does not work on default sites without a hostname. For those, you must either manually update the binding or specify `--siteid`.

### Specific site

Specify a site ID to bind the certificate to a specific IIS site. You can find the ID in IIS Manager under the Sites folder:

```bash
simple-acme.exe --source iis --siteid 1 --installation iis
```

### Multiple sites (SNI)

IIS 8+ supports Server Name Indication (SNI), which allows multiple certificates on the same IP and port. Simple-acme creates SNI bindings automatically. Specify multiple site IDs with commas:

```bash
simple-acme.exe --source iis --siteid 1,2,3 --installation iis
```

You can also create separate renewals per site. Each certificate gets its own `.renewal.json` file and renews independently.

### IIS Central Certificate Store (CCS)

For web farms with multiple IIS servers, you can use Central Certificate Store. Certificates are exported as PFX files to a shared file share, and all IIS servers retrieve them from there:

```bash
simple-acme.exe --source iis --store centralssl ^
  --centralsslstore "\\\\fileserver\\certs" ^
  --installation iis
```

## Task Scheduler and renewal

Simple-acme creates a Windows Task Scheduler task on the first certificate. The task runs daily and renews certificates approaching expiry.

**Important:** The scheduled task and `settings.json` must be in sync. Run time, random delay and paths must match in both places. If you change settings in one, the other must be updated accordingly. Mismatches between the two are one of the most common causes of silent renewal failures.

### Default settings

* Run time: 09:00 + random delay
* Random delay: up to 4 hours
* Max run time: 2 hours
* Renewal at: 55 days remaining

### With ARI (FairSSL)

When ARI is enabled (automatic with FairSSL), simple-acme checks daily with the CA for the optimal renewal time. The CA can signal early renewal during security events.

FairSSL monitors ARI check-ins and can contact you if a client stops checking in.

**We recommend setting `RenewalDays` to 365** in `settings.json`, as ARI determines the correct renewal time. If ARI is unavailable, simple-acme has a built-in backup of 7 days before expiry. `RenewalDays` is only a fallback.

**Run renewal outside production hours.** With 200-day certificates (2026) and upcoming 100-day (2027) and 47-day (2029) lifetimes, renewal frequency increases. Schedule Task Scheduler to run early in the morning or late in the evening, so any validation errors can be handled before normal business hours. Adjust in `settings.json`:

```json
"ScheduledTask": {
  "StartBoundary": "05:00:00",
  "RandomDelay": "01:00:00"
}
```

### Short certificate lifetime (47 days from 2029)

With [47-day certificate lifetimes](https://www.fairssl.dk/en/ssl-lifetime) from March 2029, renewal must run more frequently and reliably. Simple-acme with ARI handles this automatically. The CA determines the optimal renewal time, and the client follows it. We recommend testing your setup thoroughly now, while certificates still have 200-day lifetimes, so you are ready for the shorter lifetimes.

## Post-renewal scripts

Simple-acme can run scripts after a successful renewal. Use this when the certificate needs to be deployed to services outside IIS: RDP Gateway, Exchange, SQL Server, network equipment or other servers.

The script receives certificate information as parameters. The most important variables:

| Variable             | Description                             |
| -------------------- | --------------------------------------- |
| `{CertThumbprint}`   | SHA-1 thumbprint of the new certificate |
| `{CacheFile}`        | Path to the PFX file in cache           |
| `{CachePassword}`    | Password for the PFX file               |
| `{CertFriendlyName}` | Certificate's friendly name             |
| `{StorePath}`        | Path to PEM/PFX export folder           |

### Example: RDP Gateway binding

PowerShell script that binds the new certificate to RD Gateway after renewal:

```powershell
# deploy-rdgateway.ps1
param(
    [string]$Thumbprint
)
# Bind to RD Gateway
$gwConfig = Get-Item "RDS:\GatewayServer\SSLCertificate"
Set-Item "RDS:\GatewayServer\SSLCertificate\Thumbprint" -Value $Thumbprint
# Restart RD Gateway service
Restart-Service TSGateway -Force
Write-Host "RD Gateway certificate updated: $Thumbprint"
```

Configure in simple-acme: `--installation script --script "C:\\scripts\\deploy-rdgateway.ps1" --scriptparameters "{CertThumbprint}"`

### Example: SQL Server (private key permissions)

SQL Server requires its service user to have read access to the certificate's private key. On each renewal, a new key is generated and permissions must be set again. This script assigns permissions and restarts SQL:

```powershell
# deploy-sqlserver.ps1
param(
    [string]$Thumbprint
)
# Find the certificate in Certificate Store
$cert = Get-ChildItem "Cert:\LocalMachine\My\$Thumbprint"
$keyPath = $cert.PrivateKey.CspKeyContainerInfo.UniqueKeyContainerName
$fullPath = "$env:ProgramData\Microsoft\Crypto\RSA\MachineKeys\$keyPath"

# Grant SQL Server service account read access to private key
$acl = Get-Acl $fullPath
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "NT Service\MSSQLSERVER", "Read", "Allow"
)
$acl.AddAccessRule($rule)
Set-Acl $fullPath $acl

# Update SQL Server to use the new certificate
# (requires SQL Server Configuration Manager or registry)
Restart-Service MSSQLSERVER -Force
Write-Host "SQL Server certificate updated: $Thumbprint"
```

Adjust `NT Service\\MSSQLSERVER` to your SQL Server service account if it runs under a different account.

## Troubleshooting

### HTTP-01 validation fails

Check that port 80 is open in Windows Firewall and any external firewall. Simple-acme must be able to bind port 80 (selfhosting) or write to the IIS webroot (filesystem). Redirects from HTTP to HTTPS are **not allowed** during validation. Check IIS URL Rewrite rules. If the server is behind a load balancer, consider DNS validation instead.

### DNS-01 validation fails (timeout)

DNS propagation can take 30-300 seconds depending on the provider. Check that the TXT record `_acme-challenge.your-domain` is visible with `nslookup -type=TXT _acme-challenge.your-domain`. If you are using CNAME delegation (Auto DNS), check that the CNAME record points correctly. Consider increasing `DnsPropagationDelay` in settings.json.

### Certificate is installed but IIS uses the old one

Check that `--installation iis` is included in the renewal configuration. Open the `.renewal.json` file and verify that InstallationPluginOptions contains the IIS configuration. Alternatively, run `simple-acme.exe --renew --force` to force renewal.

### Task Scheduler runs but certificates are not renewed

Check the log files in simple-acme's log folder (default: `%ProgramData%\simple-acme\logs`). The most common causes: the account running the task does not have IIS permissions, DNS API keys have expired, or the certificate has not yet reached its renewal date (default: 55 days before expiry). Run manually with `--renew --verbose` to see detailed output.

### CAA record blocks issuance

If you have CAA DNS records, they must allow the CA issuing the certificate. FairSSL uses DigiCert, GlobalSign and Sectigo as CAs. Use our [CAA Record Generator](https://www.fairssl.dk/en/tools/caa-generator) to generate correct CAA records for your domain.

