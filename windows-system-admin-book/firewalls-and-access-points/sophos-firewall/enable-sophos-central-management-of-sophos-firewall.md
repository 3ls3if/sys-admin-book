---
icon: toggle-on
---

# Enable Sophos Central management of Sophos Firewall

{% hint style="warning" %}
You need to turn on Sophos Central management on Sophos Firewall and accept the request in Sophos Central.
{% endhint %}

You'll need the following products and licenses:

* <mark style="color:green;">A Sophos Central account (a license or a trial).</mark>
* <mark style="color:green;">A Sophos Firewall with an active paid subscription (other than a base license) or an active support contract.</mark>

For more information about Sophos Firewall licenses, see [Firewall licenses](https://docs.sophos.com/central/customer/help/en-us/LicensingGuide/FirewallLicenses/).

{% hint style="warning" %}
You can only register and manage firewalls with Sophos Central that connect to the internet using IPv4 addresses.
{% endhint %}

## Turn on Sophos Central management

1.  Sign in to Sophos Firewall and go to **Sophos Central**.

    ![Sophos Central menu option.](https://docs.sophos.com/central/customer/help/en-us/images/XGCentralSyncMenu.png)
2.  Click **Register**.

    **Register firewall with Sophos Central** appears.

    [![Register firewall with Sophos Central.](https://docs.sophos.com/central/customer/help/en-us/images/RegisterFirewallSophosCentral.png)](https://docs.sophos.com/central/customer/help/en-us/images/RegisterFirewallSophosCentral.png)

    You can register the firewall in the following ways:

    *   <mark style="color:green;">**Use OTP:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Use OTP**</mark><mark style="color:green;">, add the OTP, then click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Register**</mark><mark style="color:green;">.</mark>

        <mark style="color:green;">For instructions on how to generate the OTP, see</mark> [<mark style="color:green;">Use OTP to register with Sophos Central</mark>](https://docs.sophos.com/nsg/sophos-firewall/Latest/help/en-us/webhelp/onlinehelp/index.html?contextID=central-register-OTP) <mark style="color:green;">in the Sophos Firewall help.</mark>
    *   <mark style="color:green;">**Use Sophos Central credentials:**</mark> <mark style="color:green;"></mark><mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Use email address**</mark><mark style="color:green;">, add the email address and password for your Sophos Central administrator account, then click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Register**</mark><mark style="color:green;">.</mark>

        <mark style="color:green;">For instructions on how to create a Sophos Central administrator account, see</mark> [<mark style="color:green;">Add administrators</mark>](https://docs.sophos.com/central/customer/help/en-us/PeopleAndDevices/RoleManagement/AddAdmin/)<mark style="color:green;">.</mark>

        For more information, see [Use the super admin credentials to register with Sophos Central](https://docs.sophos.com/nsg/sophos-firewall/19.5/Help/en-us/webhelp/onlinehelp/AdministratorHelp/SophosCentral/HowToArticles/CentralManageXG/index.html).
3.  Turn on **Sophos Central Services**.

    ![Turn on Sophos Central services.](https://docs.sophos.com/central/customer/help/en-us/images/SFCentralServicesEnable.png)
4.  Select the services that you want.

    ![Select Sophos Central services.](https://docs.sophos.com/central/customer/help/en-us/images/SFCentralServicesSelect.png)

<br>

***

## Approve Sophos Central management

1. Sign in to the [Sophos Central Admin](http://central.sophos.com/) account with which you've registered Sophos Firewall.
2. Go to **My Products** > **Firewall Management**.
3.  On the **Firewalls** page, find your recently registered firewall and click **Accept services**.

    ![Accept services for your firewall.](https://docs.sophos.com/central/customer/help/en-us/images/CentralFirewallAcceptServices.png)
4.  On Sophos Firewall, click **Sophos Central** and check whether the status has changed from **Waiting for approval from Sophos Central** to **Managed**.

    The status can take up to two minutes to change.

    When the status changes to **Managed**, your Sophos Firewall is ready to be managed by Sophos Central.
5.  You can sign out of your Sophos Firewall, and manage it in future by clicking its name on the **Firewalls** page in Sophos Central.

    You must be an Admin or Super Admin in Sophos Central to access your firewalls through Sophos Central.

    ![Your firewall on the Firewalls page in Sophos Central.](https://docs.sophos.com/central/customer/help/en-us/images/CentralFirewallAccessXG.png)

    It may take a few seconds for your firewall's web admin console to open.

    ![Your firewall's web admin console loading.](https://docs.sophos.com/central/customer/help/en-us/images/CentralFirewallXGScreen.png)



***

## REFERENCES

* [https://docs.sophos.com/central/customer/help/en-us/ManageYourProducts/FirewallManagement/Firewalls/FirewallAdd/index.html#add-a-new-firewall](https://docs.sophos.com/central/customer/help/en-us/ManageYourProducts/FirewallManagement/Firewalls/FirewallAdd/index.html#add-a-new-firewall)
* [https://docs.sophos.com/central/customer/help/en-us/ManageYourProducts/FirewallManagement/CentralManageXG/index.html#approve-sophos-central-management](https://docs.sophos.com/central/customer/help/en-us/ManageYourProducts/FirewallManagement/CentralManageXG/index.html#approve-sophos-central-management)
* [https://docs.sophos.com/central/customer/help/en-us/ManageYourProducts/FirewallManagement/FirewallClaim/index.html#synchronize-your-firewall-subscriptions-with-sophos-central](https://docs.sophos.com/central/customer/help/en-us/ManageYourProducts/FirewallManagement/FirewallClaim/index.html#synchronize-your-firewall-subscriptions-with-sophos-central)
