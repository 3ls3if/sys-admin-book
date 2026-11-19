---
icon: gear
---

# Cloudflare Tunnel Easy Setup

Cloudflare Tunnels is an AWESOME service for home users and businesses alike. But what is it exactly? Cloudflare Tunnels is kind of like a VPN connection in that it’s a secure way to access resources on your internal private network from the outside world. So for instance, say you have a Synology NAS device that has a local GUI interface, and you want to change some settings. How can you log into that device and make those changes when you’re travelling? There are a number of ways to skin this cat.

The difference with Cloudflare Tunnels vs. your traditional VPN is that you don’t have to open ports in your firewall. With VPN, you connect into your VPN server (or sometimes directly to your router) through a hole that you’ve poked in your firewall.

<img src="../../../.gitbook/assets/blank diagram 1.D62Du_DT_hgQsW.webp" alt="Traditional VPN diagram: a laptop connects through an open firewall port to reach a NAS on the LAN" height="583" width="1395">

With Cloudflare Tunnels, you install a client inside your network that maintains a secure connection out to Cloudflare. You then create different FQDNs (Fully Qualified Domain Names aka. DNS names aka. CNAME records) that associate with your internal services. So in our NAS example, perhaps you create a ‘synology.mydomainname.com’ for your NAS device and tell Cloudflare what the private IP address and port is. In the case of Synology, it’s an HTTP interface that runs on port 5000. BUT, when we go through Cloudflare Tunnels, it becomes an HTTPS connection on port 443 (standard), so this is not only a convenient way to access internal resources, you also get some bonus features like that HTTP port 5000 to HTTPS port redirect. Since you’re connecting to an FQDN that Cloudflare manages, you’re also obscuring your own WAN IP address.

<img src="../../../.gitbook/assets/cloudflare tunnels architecture.B7aflqVk_BVsMi.webp" alt="Cloudflare Tunnels diagram: a Docker connector links out to Cloudflare, which proxies nas.mydomain.com to the NAS" height="943" width="1775">

I recently dug deep into this technology, and it definitely took me a while to wrap my head around…so in this post, I will try to make your life easier and explain it in simple easy terms, THEN we’ll set up our own Cloudflare Tunnel so that we can connect to our internal private devices from the outside world safely and securely. Let’s do this!

## What You Need to Get Started <a href="#what-you-need-to-get-started" id="what-you-need-to-get-started"></a>

**Domain Name:** you’re going to have to give Cloudflare a domain name to use for routing FQDNs to your internal resources. Let’s say you use ‘mydomain.com.’ You’ll first set up the tunnel, and then you can add multiple resources onto this domain name such as webserver.mydomain.com, nas.mydomain.com, pihole.mydomain.com. Whatever you need to connect to from the outside world can be connected to Cloudflare Tunnels…but it all starts with that domain name.

There are a number of ways to get free domain names, and you can absolutely Google search those out. For me though, I like to use [Namecheap.com](https://www.dpbolvw.net/click-8531363-15332761) for my domains. Namecheap has very cost effective domain names without all the extra fluff. They also often have $0.99 sales on new domain name purchases.

The domain name that I’m going to use for this tutorial is crosstalkwireless.net, which is a spare domain that I’m not using for anything else.

**Cloudflare Account:** This is pretty straight forward. Head over to cloudflare.com and click the ‘Sign Up’ button in the upper right. You’ll be walked through the sign-up process, and eventually you’ll be logged into the Cloudflare dashboard. It’s free!

**Cloudflared Connector:** This is a server or Docker container on your local network that connects out to Cloudflare. The service that it runs is called ‘cloudflared’ (short for cloudflare daemon). Essentially, this is a device on your network that authenticates and holds open a connection to Cloudflare’s services. Cloudflare allows you to install the cloudflared connector on Windows, macOS, Linux, Docker: lots of options.

<img src="../../../.gitbook/assets/image 18.Dg89vCr6_ZtLS6X.webp" alt="Cloudflared connector environment choices: Windows, Mac, Debian, Red Hat and Docker, 64-bit or 32-bit" height="304" width="1036">

_Cloudflared options_

In this tutorial, we’re going to be using Docker on a Synology NAS since it’s very lightweight. I have also successfully set up cloudflared in Ubuntu running on a virtual machine in my Synology NAS, which was pretty easy, but the overhead of the operating system takes away from the resources of the NAS vs. Docker which isn’t quite as resource intensive. You can pick the best way to set up the connector for your own environment. As long as it connects and authenticates to Cloudflare, it’ll work. We’ll dig more into the connector a bit later in this tutorial.

## Let’s Get Started! <a href="#lets-get-started" id="lets-get-started"></a>

The first thing you want to do is add your domain name to Cloudflare and switch over the root nameservers for that domain. From the Cloudflare dashboard, click on Websites in the left-hand menu and then click ‘Add a Site.’

Enter in your domain name and click ‘Add site.’

<img src="../../../.gitbook/assets/image 81.COr vjKw_VUoKK.webp" alt="Cloudflare Add site screen with crosstalkwireless.net entered in the domain field" height="289" width="745">

_Add your site (domain name) and click ‘Add site.’_

You’re going to be presented with some pricing options, but if you scroll down to the bottom, you have the option to click on a Free version of Cloudflare. Pick the Free version and then click ‘Continue.’

<img src="../../../.gitbook/assets/image 82.Cd1OC46b_Z1NnXP2.webp" alt="Cloudflare plan options with the Free plan selected and the Continue button highlighted" height="861" width="896">

_Scroll down to the Free version and click ‘Continue.’_

Cloudflare then scans your domain and replicates any existing records for you. Since this is a brand new domain that we’re using for our Tunnels setup, we can just click on ‘continue’ at the bottom.

<img src="../../../.gitbook/assets/image 20.gRRbyzoG_JEJXe.webp" alt="Cloudflare DNS management showing records imported for crosstalkwireless.net, with Continue at the bottom" height="736" width="1098">

_Technically, I can delete the ‘parkingpage’ CNAME record since I won’t be using that. Or just click ‘continue.’_

Next, Cloudflare is going to give us the DNS names for the DNS servers that we should use as the root domain servers for our domain name. Basically, this just means that right now, when you perform a DNS lookup to crosstalkwireless.net, that lookup is being handled by Namecheap’s DNS nameservers. We want to change our domain name so that all DNS lookups are instead handled by Cloudflare’s nameservers.

<img src="../../../.gitbook/assets/image 21.Dq0KEB F_BSXpz.webp" alt="Cloudflare Change your nameservers page listing Namecheap nameservers to remove and Cloudflare ones to add" height="859" width="907">

Every domain name provider is going to give you a way to do this, and they’ll all be slightly different. If you’re using Namecheap for your domain names, these instructions will work, but if you’re using a different domain name provider, you’ll have to search out how it’s done for your own DNS host.

Logging into Namecheap.com, first click on Domain List in the left-hand menu, and then click the ‘Manage’ button next to the domain name you’re using with Cloudflare.

In the section that says ‘Nameservers,’ by default it’s going to be set to ‘NameCheap Basic DNS.’ Drop down that option and instead choose ‘Custom DNS.’

<img src="../../../.gitbook/assets/image 22.vuLldxeh_1hzu4o.webp" alt="Namecheap Nameservers dropdown with Custom DNS selected" height="212" width="867">

_Change your domain’s name servers to Cloudflare_

Cloudflare already gave us the nameservers to enter in here, so go back to Cloudflare and copy each of those nameservers and then paste them into Namecheap (or your own domain hosting provider):

<img src="../../../.gitbook/assets/image 23.C_1dEX6g_Z2sAeEf.webp" alt="Cloudflare nameservers jade.ns.cloudflare.com and jay.ns.cloudflare.com with Click to copy links" height="166" width="383">

_Copy from Cloudflare_

<img src="../../../.gitbook/assets/image 24.DlQAJaqC_1gPfQn.webp" alt="Namecheap Custom DNS with both Cloudflare nameservers entered and the green Save checkmark" height="211" width="1160">

_Paste into Namecheap and then click the green checkmark to save._

Once those are pasted in, click the green checkmark to save.

Go back to Cloudflare and click the ‘Done, check nameservers’ button. You should be routed to the Quick Start Guide. You can just click ‘Finish Later’ or you can take all the defaults.

<img src="../../../.gitbook/assets/image 25.RdzwO7bT_Z2a4DTl.webp" alt="Cloudflare Quick Start Guide with Get started button and Finish later link" height="428" width="847">

_Finish later or take the defaults here._

Back in the Overview screen, you may be given a button to check Nameservers again. Just click it and you’ll see this notification:

<img src="../../../.gitbook/assets/image 26.q0gvdDi8_1dQO9b.webp" alt="Cloudflare notice that it is now checking the nameservers for crosstalkwireless.net" height="160" width="645">

_And now…we wait._

This process can take some time, but you’ll receive an email once Cloudflare has detected the name server change. Now would be a great time to go grab a cup of coffee!

Once your nameservers have been updated and verified by Cloudflare, you’ll see the domain as ‘Active’ in the Cloudflare dashboard.

<img src="../../../.gitbook/assets/image 27.D9rCjN8S_1WcuA.webp" alt="Cloudflare dashboard tile showing crosstalkwireless.net as Active" height="78" width="519">

_Success!_

## Create a Tunnel <a href="#create-a-tunnel" id="create-a-tunnel"></a>

The next step is to set up our Cloudflare tunnel. This is the connection between your LAN and the Cloudflare services. There are two pieces to this puzzle: creating the tunnel itself, and then creating a connector on our LAN that will communicate outbound with the tunnel that we created. When we have both of these pieces working, we have effectively created a secure connection between our LAN and Cloudflare that we can then build upon to access our internal services.

In the Cloudflare dashboard (you can get there by clicking the Cloudflare logo in the upper left-hand corner), you should see all of your Cloudflare-managed domains. Click on the domain that you just added.

<img src="../../../.gitbook/assets/image 28.Cm4irOhr_rYOyg.webp" alt="Cloudflare Home websites list with the crosstalkwireless.net domain highlighted" height="346" width="1284">

_Click on the domain that you added to Cloudflare._

Then click on ‘Cloudflare Tunnel’ which is located in the left-hand menu underneath ‘Traffic.’

<img src="../../../.gitbook/assets/image 29.DzdVXeEW_ZLxdRF.webp" alt="Cloudflare domain menu with Cloudflare Tunnel selected under Traffic" height="671" width="268">

_Click on Cloudflare Tunnel_

This will get us to the link to the Zero Trust Dashboard, which is where we will do the bulk of configuration with our tunnel.

<img src="../../../.gitbook/assets/image 30.DfTvHVg9_ZnxSxF.webp" alt="Cloudflare Tunnel page with the Launch Zero Trust Dashboard button" height="506" width="1087">

Click on ‘Tunnels’ under the ‘Access’ section of the left-hand menu and then click on ‘Create a Tunnel.’

<img src="../../../.gitbook/assets/image 83.u w31e2J_Z5Fyp3.webp" alt="Cloudflare Zero Trust Access menu with Tunnels selected and the Create a tunnel button" height="583" width="1015">

_Access > Tunnels > Create a tunnel_

Give your tunnel a descriptive name such as the highly imaginative name ‘mytunnel’ that I used in the screenshot below, and then click ‘Save tunnel.’

<img src="../../../.gitbook/assets/image 32.CJV_JJ5n_ZRIssQ.webp" alt="Create a tunnel screen with the tunnel name mytunnel entered and the Save tunnel button" height="736" width="1220">

_Name your tunnel and save._

On the next screen, you’re going to be asked about the environment in which your tunnel will be installed. For the purposes of this tutorial, we’re going to be using Docker, but if you’re using Windows, Linux, macOS, etc., you’ll want to pick the appropriate environment and then follow the instructions in the box below your selection.

<img src="../../../.gitbook/assets/image 33.BfEZowiu_gDIcH.webp" alt="Configure mytunnel with Docker selected and the docker run cloudflared connector command shown" height="838" width="1551">

_Choose your environment. Notice how the connector instructions change based on the environment selected._

Below those instructions, you’ll see the connector status. This will be blank for now since we haven’t set up our connector yet, but when you do create the connector, this is where you can check if it’s connected and working properly.

REMEMBER THIS PAGE! We’re going to be back here in just a minute.

## Create the Connector <a href="#create-the-connector" id="create-the-connector"></a>

We’re going to be using Docker for this tutorial, and more specifically, we’re going to be using the Docker application in the Synology NAS. If you’re using more traditional command-line based Docker, you can simply copy/paste the Docker command that Cloudflare gives you right into your CLI. If you’re using something like Portainer to manage your Docker containers, you’ll have to modify the command similar to what we’re going to do with Synology’s Docker application, but all the info you need is in that command line string.

These next steps will be in the Synology Docker application, so head over to your Synology NAS, log in, and then install and/or run the Docker application. Once you’re in Docker, click on ‘Registry’ in the left-hand menu and then search for Cloudflare in the search box. You will see a list of Cloudflared-related items in the resulting window. Click on the one that says ‘cloudflare/cloudflared’ and then click the ‘Download’ button in the top bar.

<img src="../../../.gitbook/assets/image 36.BsuXv9EK_Z19BLDs.webp" alt="Synology Docker Registry search for Cloudflare with the cloudflare/cloudflared image selected" height="406" width="1420">

_Search for the Cloudflare docker image. Select it and choose ‘Download.’_

Pick ‘latest’ when prompted and then click ‘Select.’

<img src="../../../.gitbook/assets/image 37.Ced29uT4_1mlcCL.webp" alt="Synology Docker Choose Tag dialog with latest selected" height="236" width="582">

_Choose ‘latest’ and then click ‘Select.’_

The Cloudflare Docker image will download and you’ll get a notification when it’s done (should just take a few seconds). You can now click on ‘Images’ in the left-hand menu, and you’ll see the Cloudflare Docker image that was just downloaded.

Click on the image and then click ‘Launch.’

<img src="../../../.gitbook/assets/image 38.7oghANZl_Z15akqW.webp" alt="Synology Docker Image list with cloudflare/cloudflared:latest selected and the Launch button" height="398" width="784">

_Click on the Docker Image and then click ‘Launch.’_

This will start the Create Container wizard. For the first step, we don’t really need this Docker container to have its own IP address on the network, so we can choose ‘Use the same network as the Docker Host. Click Next.

<img src="../../../.gitbook/assets/image 39.B6Lt4IDI_Z1Y2E7L.webp" alt="Synology Create Container network step with Use the same network as Docker Host selected" height="701" width="759">

_Use the same network as the Docker Host._

On the next screen, give your connector container a name. I’m calling mine ‘crosstalknetworking-cloudflared.’ Then check the box for ‘Enable auto-restart.’ DO NOT click ‘Next’ yet.

<img src="../../../.gitbook/assets/image 84.DINkHkk3_1WJpuH.webp" alt="Synology container General Settings with a container name entered and Enable auto-restart checked" height="564" width="613">

_Name it, click Enable auto-restart, but don’t click Next yet!_

Here’s the trickiest part of creating this connector: we have to give it a specific execution command that includes the cloudflared token for authentication with Cloudflare.

Remember the Docker configuration page in Cloudflare that had our instructions for the Docker container? Let’s go back to that page.

We’re going to want to copy the Docker command that Cloudflare gives us. Click the ‘copy’ button to copy the whole string to your clipboard, then open a text editor like Windows Notepad and paste it in. Let’s take a closer look at that command:

```
docker run cloudflare/cloudflared:latest tunnel --no-autoupdate run --token eyJhIjoiNTU2MDgwOGM3ZDk1NGNlZjNjZTBhYzg1NmRiODZjN2IiLCJ0IjoiMDNkYjdmNjEtZmQ1Zi00NGMzLTkyMjItNmQ3MDQzZjAzNzAzIiwicyI6Ik1UZzBZelJsTnpBdE9UZGpOaTAwTjJRekxUa3lNRFl0TURRMU1XVTNZekZoT1dVNCJ9
```

There are a few components here. I have indicated in **BOLD** the ones we need to keep…but first, let’s take a close look at this string.

* docker is the executable command we would run if we were doing this in the Linux CLI. That can be disregarded since we’re using Synology’s Docker application.
* run means ‘run’ this command. We’ll need to keep the ‘run’ but we’re going to move it to a different spot.
* cloudflare/cloudflared:latest is the Docker container that we want to run, but since we’ve already selected cloudflare/cloudflared:latest in the Synology application, we can disregard it here.
* tunnel means create a tunnel.
* run again! (we’ll leave this one)
* `--no-autoupdate` means that we want to manually run updates for this Docker container.
* `--token` is our authentication token (don’t worry that I’ve shown mine here, this tunnel will be destroyed by the time this article is published).

So now we’ve broken down the various components of this command, we need to adjust it a bit. Here’s what we need to do in Notepad:

* delete out anything that is not in BOLD above (docker, cloudflare/cloudflared:latest, and `--no-autoupdate`)
* second, just to be sure, make sure you deleted the first ‘run’ but not the second one

When you’re finished, the string should look like this:

```
tunnel run --token eyJhIjoiNTU2MDgwOGM3ZDk1NGNlZjNjZTBhYzg1NmRiODZjN2IiLCJ0IjoiMDNkYjdmNjEtZmQ1Zi00NGMzLTkyMjItNmQ3MDQzZjAzNzAzIiwicyI6Ik1UZzBZelJsTnpBdE9UZGpOaTAwTjJRekxUa3lNRFl0TURRMU1XVTNZekZoT1dVNCJ9
```

Copy this new command to the clipboard and then head on back over to the Synology Create Container wizard.

Back at the Wizard, click on ‘Advanced Settings.’

<img src="../../../.gitbook/assets/image 42. MAYoFH7_Z1adYWV.webp" alt="Synology container General Settings with an arrow pointing to the Advanced Settings button" height="562" width="610">

_Click Advanced Settings._

In Advanced Settings, click the ‘Execution Command’ tab and then paste our re-formatted command string into the ‘Command’ box. Side note: notice how the ‘Entrypoint’ has `--no-autoupdate`? This is why we were able to remove that portion of the original command string. Once that’s done, click ‘Save.’

<img src="../../../.gitbook/assets/image 43.drgjPy1i_Z1Axfja.webp" alt="Synology Advanced Settings Execution Command tab with the tunnel run token command pasted in" height="560" width="658">

_Paste in the re-formatted command string. Then click ‘Save.’_

Once you’ve saved the Advanced settings, you can click ‘Next’ on the General Settings window.

<img src="../../../.gitbook/assets/image 44.b1qHi6Tr_1fAqEo.webp" alt="Synology container General Settings with an arrow pointing to the Next button" height="558" width="605">

_NOW you can click Next. Thank you for following instructions._

On the Volume Settings step, you can just click ‘Next.’ This is where we would normally tell Docker where we are storing files or folders outside of the Docker container. Since this Cloudflare Connector is basically just a command we’re executing, we don’t need any external files or folders.

<img src="../../../.gitbook/assets/image 45.BSjAdmnL_1ukUsY.webp" alt="Synology Create Container Volume Settings step with no volumes added and Next highlighted" height="558" width="606">

_Click ‘Next.’_

Finally, on the Summary page, click ‘Done.’ Make sure ‘Run container after the wizard is finished’ is checked (it is by default).

<img src="../../../.gitbook/assets/image 46.C1wRctwm_Z1qslpk.webp" alt="Synology container Summary page with Run this container after the wizard is finished checked" height="555" width="605">

_Done!_

After a few seconds, you should see the Docker Container show up under Containers. It should be ‘Running’ with no issues. If there are any problems, it will likely just restart over and over, and you’ll see error messages popping up. If that happens, just delete it and go back through the container creation. You probably messed up the command string.

<img src="../../../.gitbook/assets/image 47.vgw2FDbk_Z4MuzQ.webp" alt="Synology Docker container list showing the crosstalknetworking-cloudflared container running" height="379" width="1133">

_Running container!_

Back in the Cloudflare Zero Trust Dashboard, if we click on Tunnels we should see that our tunnel is now active and healthy!

<img src="../../../.gitbook/assets/image 85.C0pRjBRC_ZDau9q.webp" alt="Cloudflare Zero Trust tunnels list showing mytunnel with a HEALTHY status" height="242" width="976">

_Cloudflare tunnel looks healthy!_

OK, so at this point, our connector is done, and we can start the REAL configuration of opening up access to our LAN resources. We’re done with the Synology NAS portion. It’s basically set it and forget it.

## Adding LAN Services <a href="#adding-lan-services" id="adding-lan-services"></a>

In order to gain access to our internal resources, we need to add them to the Cloudflare Tunnel. When we add a new service, such as the GUI interface of our Synology NAS, Cloudflare will automatically create a DNS CNAME record and route it through the tunnel for us.

This routing gives us a bunch of really cool advantages:

* **HTTP to HTTPS:** the surfing done through the Cloudflare tunnel is HTTPS…even if the GUI interface we’re pointing to is only HTTP!
* **Port redirection:** we can use standard HTTPS port 443 for all LAN device interfaces that we push through the tunnel, even if the GUI port is not 443. For example, the Synology NAS interface runs on port 5000, but when we push it through the tunnel, it will be HTTPS port 443 and we never have to remember that port number again.
* **IP address obfuscation:** Cloudflare creates a CNAME record that points to a Cloudflare IP address. Our own WAN IP address is never exposed to the Internet, which adds an additional layer of security.

Let’s add our first LAN server! I’m going to start off with the GUI interface of my Synology NAS which exists on my LAN at `http://192.168.200.11:5000`. Notice that this interface is HTTP, not HTTPS:

<img src="../../../.gitbook/assets/image 49.1aX0WYq7_ZVFHKF.webp" alt="Browser address bar showing Not secure for the Synology NAS at 192.168.200.11:5000" height="166" width="284">

_Non-secure HTTP port for LAN access to the Synology NAS._

Head over to the Cloudflare Zero Trust Dashboard and navigate to Access > Tunnels. Then click on the tunnel that we just created. A right-side window will pop out. Click the ‘Configure’ button.

<img src="../../../.gitbook/assets/image 50.DM1 bYej_1i3koN.webp" alt="Zero Trust Tunnels list with mytunnel selected and the Configure button in the side panel" height="491" width="1797">

_Configure ‘mytunnel.’_

Once you’re in ‘mytunnel,’ (what you named your tunnel may be different), click on the Public Hostname tab, and then click ‘+ Add a public hostname.’

<img src="../../../.gitbook/assets/image 51.F7_WFfyn_YQ0H6.webp" alt="mytunnel Public Hostname tab with the Add a public hostname button" height="322" width="545">

_Public Hostname tab > Add a public hostname_

Now, we need to enter in some info:

* Subdomain: this is the beginning of the FQDN (the hostname in front of our domain name). Since I’m opening up access to my NAS, I’m just calling it ‘nas’. The resulting full domain name will end up being nas.crosstalkwireless.net.
* Domain: select the domain for the FQDN. If you have only set up one domain, it should be the only one in the list.
* Service Type: this is going to be HTTP since we’re redirecting internally to an HTTP interface.
* URL: this is what I would type into my browser locally on the LAN to access my NAS. In this case it’s the IP address (:) port number, or 192.168.200.11:5000.

Click ‘Save hostname’ when you’re done.

<img src="../../../.gitbook/assets/image 52.D4m75S7Q_Z2mnMNQ.webp" alt="Public hostname form: subdomain nas, domain crosstalkwireless.net, type HTTP, URL 192.168.200.11:5000" height="697" width="1110">

_Create a new hostname to direct to a LAN resource through the tunnel._

Now, if we open up that FQDN (nas.crosstalkwireless.net) in a browser, we’re redirected to the NAS interface, and this should happen pretty much immediately after you click ‘Save hostname.’ Amazing!

<img src="../../../.gitbook/assets/image 53.CxG9YSXG_eCd0g.webp" alt="Synology DSM sign-in page loaded at nas.crosstalkwireless.net through the tunnel" height="665" width="1022">

_Pop the new FQDN into a browser, and we’re redirected through the tunnel!_

Notice also that the connection is HTTPS secure with a valid certificate:

<img src="../../../.gitbook/assets/image 55.DEP_iMgJ_Z1L6MBN.webp" alt="Chrome security panel for nas.crosstalkwireless.net showing Connection is secure and Certificate is valid" height="294" width="402">

_HTTPS secured!_

Let’s add another one! I use PiHole for network-wide ad-blocking on my LAN. It runs on `http://192.168.200.50/admin`. Let’s create a tunnel for that service as well:

In the Cloudflare Zero Trust dashboard, navigate to Access > Tunnels. Click on ‘mytunnel’ and then the ‘Public Hostname’ tab. Click ‘Add a public hostname.’

In this example, PiHole runs on standard HTTP port 80, so we don’t need to add a port after the IP address:

<img src="../../../.gitbook/assets/image 56.DtHqLxJt_Z2s880j.webp" alt="Public hostname form for subdomain pihole1 pointing to HTTP 192.168.200.50" height="493" width="1095">

_Adding PiHole to the tunnel._

Once saved, we can now open up our PiHole through the tunnel. The only caveat with this one is that we have to remember to add /admin to the FQDN since the PiHole interface runs locally on my LAN on 192.168.200.50/admin.

<img src="../../../.gitbook/assets/image 57.Bkii5rZN_Z1iWofR.webp" alt="Pi-hole admin login page loaded at pihole1.crosstalkwireless.net/admin" height="461" width="1002">

_PiHole through the tunnel._

Let’s add one more: the GUI interface of my firewall which is an EdgeRouter 4 running on `https://192.168.200.1` (note HTTPS not HTTP):

<img src="../../../.gitbook/assets/image 60.7 0qqXFZ_Z2tBbm2.webp" alt="Public hostname form for subdomain firewall with service type HTTPS and URL 192.168.200.1" height="493" width="1093">

_Adding my firewall interface to the tunnel._

Let’s try going to firewall.crosstalkwireless.net!

<img src="../../../.gitbook/assets/image 59.8mWOMdjr_2rCxC3.webp" alt="Cloudflare Bad gateway error 502 page for firewall.crosstalkwireless.net with the host in error" height="578" width="1004">

_UH-OH. Error time!_

OH NO!! Massive error screen. What happened here?? Well, in this case, the internal protocol for connecting to my firewall is HTTPS, which requires a certificate (or else you get an error in the browser that you have to click past). In this case, the certificate being provided by Cloudflare is a mismatch to what the EdgeRouter is expecting, so it throws an error. In order to fix this, we’re going to have to get into the ‘Additional application settings’ of our tunnel rule for this firewall.

Back in the ‘Public hostnames’ tab of our ‘mytunnel’ tunnel, click on the firewall rule that was created, then click ‘Configure.’

Open up the ‘Additional application settings’ and then open up the TLS sub-menu. There’s a setting called ‘No TLS Verify’. Shift that to Enabled:

<img src="../../../.gitbook/assets/image 62.CktTl3ve_Z276ur1.webp" alt="Public hostname TLS settings with No TLS Verify switched to Enabled" height="817" width="1241">

_Disable TLS verification of the secure certificate._

Now scroll to the bottom and click ‘Save hostname.’ Let’s try to open up that firewall interface again:

<img src="../../../.gitbook/assets/image 63.CXbG9aaC_sDrDt.webp" alt="EdgeMAX router login page loaded at firewall.crosstalkwireless.net" height="367" width="1024">

_Success!_

This time it works perfectly. Moral of the story here is that sometimes, you’ll have to dig into the advanced settings to make a tunnel rule work, but by and large, this is pretty straight forward.

So now we’re done right?? Absolutely not. At this point, we have our tunnel up and running but literally ANYONE can connect to these FQDNs and get into our network…now, there may be cases where you DO want to open up a tunnel connection to the whole wide world (such as if you’re running a public web server), but in this case, we’re just trying to access some stuff on our own local LAN. We absolutely do not want the whole wide world to be able to connect in. We only want to be able to access it ourselves!

## Lock That S#!& Down! <a href="#lock-that-s-down" id="lock-that-s-down"></a>

The security options for Cloudflare Tunnels are pretty robust (see the screenshot below)…you can use basically any of the popular SSO services such as Google/Facebook/GitHub/Azure/etc. Each one of these is going to have its own way to do the initial setup. I have personally done the Google integration, and it wasn’t too difficult as long as you can follow directions.

<img src="../../../.gitbook/assets/image 64.NCwcH iu_2qM70S.webp" alt="Cloudflare Add a login method list of identity providers including Azure AD, Google, GitHub and One-time PIN" height="628" width="907">

_So many authentication options!_

For the purposes of this tutorial however, we’re going to just use a One-time PIN. This means that when you first try to access any resource you’ve shared through the Cloudflare tunnel, you’ll be prompted for your email address (this can be individual email addresses, or an entire domain such as \*@crosstalkwireless.net). When you input an email address that matches the rules you have set up, you receive an email with a PIN code that can then be used to provide access to your tunnel. Keep in mind though that you will STILL have to log into whichever resource you’re trying to reach.

For instance, the whole process for me logging into my Synology NAS through the tunnel is 1. Open the FQDN and enter my email address when prompted. 2. Receive the PIN code in email and authenticate to the Cloudflare tunnel. 3. Log into the Synology NAS.

<img src="../../../.gitbook/assets/image 65.DRZf4C9n_ZCPvky.webp" alt="Cloudflare Access One-time PIN screen asking for an email to send a login code" height="375" width="597">

_The Cloudflare One-time PIN screen._

Let’s get started with the lockdown! The first thing you need to do is open the Cloudflare Zero Trust dashboard and click Settings > Authentication.

<img src="../../../.gitbook/assets/image 66.D7  YsyQ_JfOI4.webp" alt="Cloudflare Zero Trust Settings page with the Authentication card highlighted" height="638" width="1039">

_Go to Settings > Authentication to add an Authentication method._

Under Login methods, click ‘Add new’ and then select One-time PIN.

<img src="../../../.gitbook/assets/image 67.CjYL8XpI_Z1lEFJ3.webp" alt="Zero Trust Login methods section with the Add new button" height="207" width="1088">

_Click Add new to add a new login method._

On the next screen, just click One-time PIN.

<img src="../../../.gitbook/assets/image 68.pof3QpJM_ZkwEUx.webp" alt="Add a login method list with One-time PIN marked" height="632" width="914">

_Click One-time PIN. There’s no additional configuration needed for this Login method._

That’s it! We can now use One-time PIN as our Login method. Let’s now create an access rule that uses it.

In the Zero Trust dashboard, click Applications under the Access menu. Then click ‘Add an application.’

<img src="../../../.gitbook/assets/image 86.DR_KTDhb_907xW.webp" alt="Zero Trust Access Applications page with the Add an application button" height="592" width="1024">

_Applications > Add an application_

For the type of application, choose Self-hosted.

<img src="../../../.gitbook/assets/image 70.cJ9bQcR2_1FMstp.webp" alt="Add an application type options with an arrow pointing to Self-hosted" height="585" width="1141">

_Click Self-hosted._

Now we get into the Add an application wizard. First, give your application a name such as ‘mytunnel-access.’ Then you can either lock down individual FQDNs and have different access rules for different resources, or you can use a wildcard for the subdomain which is what I’m going to do here. Add an ‘\*’ into the subdomain field, and then drop down the Domain box to pick your domain.

This means that “anything” (dot) crosstalkwireless.net will be protected by this rule.

<img src="../../../.gitbook/assets/image 71.lDQi Ite_Z1iqdQW.webp" alt="Application configuration named mytunnel-access with a wildcard subdomain on crosstalkwireless.net" height="418" width="1089">

_Set a wildcard to protect access to any FQDN in your domain._

Now, scroll down to the Identity Providers section. Accept all available identity providers should be enabled by default, which means that any of the authentication/login methods that you configured will be used for access to this resource. Typically you just want to leave this default, but do understand that you can individually select login methods. In the screenshot below, I have disabled ‘Accept all available identity providers’ and specifically selected One-time PIN (this is just for the purposes of this tutorial). Click Next.

<img src="../../../.gitbook/assets/image 72.BQgGepy6_Pmgio.webp" alt="Identity providers section with Accept all turned off and One-time PIN selected" height="421" width="1658">

_Typically, just leave this section default._

On the next screen, we can name our policy. I’m going to call it Default, and the Action is set to ‘Allow.’

<img src="../../../.gitbook/assets/image 73.6AtQIDSa_SvpwK.webp" alt="Add policies step with the policy name Default and the action set to Allow" height="303" width="956">

_Name the policy._

If this is your first time configuring Cloudflare Tunnels, you likely won’t have anything in the ‘Assign a group’ section, but it is good to understand what this section is for. Basically, if you click on Access > Access Groups in the Zero Trust sidebar, you have the option of pre-configuring access rules that can be used in your application policies. This way, if you are administering multiple tunnels, but you want to re-use the access rules, you can do it as a group instead of having to modify each Application individually. For our purposes however, we’re going to skip over this.

Down in the ‘Create additional rules’ section: this is where we will input the list of emails that we want to grant access to. In the ‘Include’ section, choose ‘Emails’ for the selector and then type in your email address, or multiple email addresses if you need multiple people to connect.

You can also optionally choose ‘Emails ending in’ as the selector and then put in your whole email domain such as @crosstalkwireless.net if you want anyone with an email address in your domain to have access. Just like with individual email addresses, you can add multiple email domains here.

To add more than one Selector, you can just click ‘+ Add include’ down toward the bottom of this section.

There are other types of Selectors you can use as well, such as ‘Anyone with IP range XYZ’ or ‘Anyone from Country X.’ All sorts of different ways you can grant access.

<img src="../../../.gitbook/assets/image 74.Ddb7ON8__Z20ESWF.webp" alt="Access policy Include rules using Emails and Emails ending in @crosstalkwireless.net selectors" height="438" width="912">

_An example of two different Selectors in use._

Below the ‘Include’ section is the ‘Require’ section. This is where you can even further lock things down. For instance, I’m going to choose ‘Country’ and then select United States. This means that only people with IP addresses originating in the US will have access…which isn’t super locked down since everyone knows how to use a VPN, but it does still lock it down somewhat.

<img src="../../../.gitbook/assets/image 75.C51D_7Ig_1xJwST.webp" alt="Access policy Require rule with Country set to United States" height="157" width="748">

_Lock your access down further with Require rules._

Scroll down to the bottom and click ‘Next.’ Leave everything default and click ‘Add application’ on the final wizard step to create this access rule.

**\*\*\* NOTE:** It seems that when you add access/application rules to your tunnel, it can take a few minutes to take effect.

You should now see your Application in the list when you go to Access > Applications. Let’s try it out! Try browsing to one of your tunnel FQDNs (you may have to clear cache first). You should be given the One-time PIN screen like this:

<img src="../../../.gitbook/assets/image 76.CK5KU pY_UajS0.webp" alt="One-time PIN login screen for mytunnel-access asking for an email address" height="396" width="609">

_One-time PIN screen._

Now when you enter in a valid email address, you will receive an email with a One-time PIN code.

<img src="../../../.gitbook/assets/image 77.CXewt6pX_ZKkT7E.webp" alt="Cloudflare email with a one-time login code for pihole1.crosstalkwireless.net" height="400" width="671">

_Your One-time PIN._

Enter in that PIN, and you should then be redirected to the resource you requested!

<img src="../../../.gitbook/assets/image 78.D_3iHWiO_nwPPP.webp" alt="Pi-hole login page reached after passing the Cloudflare One-time PIN check" height="636" width="511">

_Access granted!_

Congrats! You’re in! Your Cloudflare Tunnel is configured and secure.

Let’s now try something: I’m going to use Private Internet Access to change my geographical location to London, England.

<img src="../../../.gitbook/assets/image 79.C8KSzHLq_2mLmSI.webp" alt="IP lookup showing the public IP location as London, England via a VPN" height="206" width="417">

_Let’s try connecting in from across the pond!_

Navigating to that same PiHole FQDN, I’m straight blocked by Cloudflare:

<img src="../../../.gitbook/assets/image 80.CTHAPlg8_ZDKA03.webp" alt="Cloudflare Access Forbidden page saying you do not have permission to view this" height="270" width="569">

_BLOCKED! Our rules are working!_



***

## REFERENCES

* [https://www.crosstalksolutions.com/cloudflare-tunnel-easy-setup/](https://www.crosstalksolutions.com/cloudflare-tunnel-easy-setup/)
