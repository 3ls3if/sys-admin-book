---
icon: cloud
---

# Deploy Defender For Cloud Apps (MDCA) & Block Unwanted Applications

## Deploy Defender for Cloud Apps <a href="#deploy-defender-for-cloud-apps" id="deploy-defender-for-cloud-apps"></a>

* Ensure you have the necessary administrative permissions to configure and manage MDCA.
* Access the unified security portal at [www.security.microsoft.com](https://www.hanley.cloud/2025-01-13-Deploy-Defender-for-Cloud-Apps-MDCA-&-Block-Unwanted-Applications/www.security.microsoft.com).
*   Navigate to **settings** blade towards the bottom of the left menu and select **Cloud Apps**.

    ![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/MDE%20Integration%2000.png)
*   Scroll down to **Microsoft Defender for Endpoint** and check the **Microsoft Defender for Endpoint Integration** box.

    ![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/MDE%20Integration%2001.png)
* This integration allows for enhanced threat detection and response capabilities by correlating signals from endpoints and cloud apps.
* If the Defender for Endpoint agent is deployed on devices within your organization, then MDCA can leverage the MDE agent to monitor network activities and traffic, including those related to cloud apps.
* The Defender for Endpoint agent collects detailed information about cloud app usage directly from the endpoints. This includes data on which apps are being accessed, by whom, and from which devices and IP addresses etc.



***

## Integrate with Defender for Endpoint <a href="#integrate-with-defender-for-endpoint" id="integrate-with-defender-for-endpoint"></a>

* Access the unified security portal at [www.security.microsoft.com](https://www.hanley.cloud/2025-01-13-Deploy-Defender-for-Cloud-Apps-MDCA-&-Block-Unwanted-Applications/www.security.microsoft.com).
* Navigate to **settings** blade towards the bottom of the left menu and select **Endpoints**.

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/MDCA%20Integration%2000.png)

<br>

Click on **Advanced Features** under **General** and toggle the **Microsoft Defender for Cloud Apps** Toggle switch to **On** as illustrated below:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/MDCA%20Integration%2001.png)

<br>

* Enabling this feature sends telemetry collected by Defender for Endpoint over to Defender for Cloud Apps. You can confirm by going back to **the unified security portal » Settings » Cloud Apps » Automatic Log Upload** and verifying the following entry populates (it can take a few hours for data to populate):

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Automatic%20Log%20Upload.png)

<br>

> 💡 While you’re in here, you’ll need to toggle **Custom Network Indicators** to the **On** position:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/custom_network_indicators.png)

\
<br>

***

## Onboard a Device to Defender for Endpoint <a href="#onboard-a-device-to-defender-for-endpoint" id="onboard-a-device-to-defender-for-endpoint"></a>

So perhaps you don’t have all of your devices onboarded to Defender for Endpoint, but you have a fair idea of who might be consuming all the bandwidth and want to start there. Follow the steps below to onboard their devices to Defender for Endpoint and get Cloud App Telemetry:

* Logon to your device
* Navigate to the unified security portal at www.security.microsoft.com from your device
* Select the **Settings** blade from the left menu, then choose **Endpoints**

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/MDCA%20Integration%2000.png)

* Scroll down to **Onboarding** and fill out the appropriate settings, then download the onboarding package

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/onboard.png)

* Run it with administrative privilges on the device you wish to onboard.

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/MDE_onboarding_script_DL.png)

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/MDE%20Onboarding%20Completed.png)

* Give it a few minutes and the device will show up in the unified security portal, illustrated below:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/onboarded.png)

\
<br>

***

## Confirm Defender for Endpoint AV Configuration Pre-Requisites via Powershell <a href="#confirm-defender-for-endpoint-av-configuration-pre-requisites-via-powershell" id="confirm-defender-for-endpoint-av-configuration-pre-requisites-via-powershell"></a>

* Logon to your device
* Launch Powershell as an administrator
* Run the following command:

```
Get-MpComputerStatus
```

<br>

* Confirm the following pre-requisites are met:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Powershell_Config.png)

If either of these are **False** then use the following command to set them:

```
Set-MpComputerStatus
```

Here’s a [list of available commands for reference](https://learn.microsoft.com/en-us/powershell/module/defender/?view=windowsserver2025-ps#defender)

> 💡 Alternatively, you’d have to use Intune, Group Policy, SCCM, or a combination thereof to onboard and configure your fleet.

<br>

***

## Investigate Application Usage <a href="#investigate-application-usage" id="investigate-application-usage"></a>

Let’s see who our heavy hitters are on the network.

Navigate to the **Cloud Discovery** blade, then go to the **Discovered Apps** tab to list applications found on your endpoints. You can sort these by traffic and uploaded data etc. to narrow down your hunt:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Traffic01.png)

<br>

I spun up a vm for a couple hours just for this blog post so this traffic is not indicative of a typical production environment. For this example, lets open the **Microsoft 365** app from the **Discovered Apps** tab to see it’s details, including it’s **Cloud App** score. This is great for compliance purposes. As illustrated, the Microsoft 365 app is compliant with GDPR, SOC, ISO 27001, ITAR, FINRA, to name a few:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Traffic02.png)

<br>

Click into the app from the list to bring up additional metrics:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Traffic03.png)

<br>

Lastly, slide over to the **Cloud App Usage** tab to identify usage by user:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Traffic04.png)

<br>

***

## Un-sanction an Unwanted Application <a href="#un-sanction-an-unwanted-application" id="un-sanction-an-unwanted-application"></a>

Now that we’ve got our devices onboarded and our MDE and MDCA platforms integrated, we can enforce MDCA polcies like blocking un-sanctioned applications using the MDE agent directly.

* From the unified security portal, navigate to the **Cloud Discovery** Blade, located under **Cloud Apps**
* Swing over from the **Dashboard** tab to the next one to the right, called **Discovered Apps** to list all of the applications reported from Defender for Endpoint that have run on that device since the **Automatic Log upload** has been deployed from MDE to MDCA earlier:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Automatic%20Log%20Upload.png)

* You can Un-sanction any application found in your environment from here.

> 💡 Why wait until an application is already active in your environment to block it? The **Cloud App Catalogue** blade (directly underneath the **Cloud Discovery** blade) lists all of the applications that Microsoft has evaluated, and there’s thousands of them!

* In this example, we’ll block applications we know we don’t want to see in our network. From the **Cloud App Catalogue** search for your unwanted applications and select the **Unsanction** button to the right for each application you want to block:

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/UnSanctioned.png)

<br>

Give it a few minutes and try to navigate to one of those applications in a browser or through their designated local applications on a device that you’ve onboarded to MDE to see them fail (gloriously):

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Steam_Games_block.png)

<br>

![](https://www.hanley.cloud/assets/img/Defender%20for%20Cloud%20Apps/Netflix_Block.png)

<br>



***

## REFERENCES

* [https://www.hanley.cloud/2025-01-13-Deploy-Defender-for-Cloud-Apps-MDCA-&-Block-Unwanted-Applications/](https://www.hanley.cloud/2025-01-13-Deploy-Defender-for-Cloud-Apps-MDCA-&-Block-Unwanted-Applications/)
