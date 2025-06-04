---
icon: exclamation
---

# Product Introduction

### What is Microsoft Intune?

Microsoft Intune is a cloud-based unified endpoint management ([UEM](https://www.techtarget.com/searchenterprisedesktop/definition/unified-endpoint-management-UEM)) tool that aims to help organizations manage the mobile devices employees use to access corporate data and applications, such as email.

It is a component of Microsoft's Enterprise Mobility + Security (EMS) offering, a [mobile device management](https://www.techtarget.com/searchmobilecomputing/definition/mobile-device-management) and mobile application management ([MAM](https://www.techtarget.com/searchmobilecomputing/definition/mobile-application-management-MAM)) platform. Intune is designed to integrate with other parts of the EMS offering, including Azure Active Directory ([Azure AD](https://www.techtarget.com/searchwindowsserver/definition/Microsoft-Windows-Azure-Active-Directory-Windows-Azure-AD)) and Microsoft Azure Information Protection. Intune's app protection policy component uses the Azure AD identity to separate corporate and personal data.

### Microsoft Intune features and capabilities

Over the years, Microsoft Intune has evolved into a cross-platform tool for managing devices and apps. The most important features and capabilities include the following:

* Manage personally owned and company-owned devices of the most common platforms and provide secure access to company data on those devices. Microsoft Intune currently supports management for [Android](https://www.techtarget.com/searchmobilecomputing/definition/Android-OS), [iOS](https://www.techtarget.com/searchmobilecomputing/definition/iOS) and iPadOS, Linux, macOS, Windows and ChromeOS devices.
* Manage the lifecycle of apps on managed devices, including the deployment, update and removal of apps.
* Manage apps on mobile devices and securely provide access to company data via those apps.
* Enable self-service functionalities, such as resetting PIN or password, installing apps and removing devices, via the Company Portal app.
* Integrate with mobile threat defense services for a real focus on endpoint security.
* Provide report capabilities that provide insights into your environment. This includes reports with insights about policies, profiles, updates, apps and more.

<figure><img src="https://www.techtarget.com/rms/onlineimages/itchannel-intune_mobile.png" alt="Chart with key details of Microsoft Intune, including history, business uses and management approach" height="374" width="560"><figcaption><p>Microsoft Intune is the company's unified endpoint management tool.</p></figcaption></figure>

### How it works

In Microsoft's approach to managing mobile devices, Intune mainly uses protocols or APIs available in [mobile OSes](https://www.techtarget.com/searchmobilecomputing/definition/mobile-operating-system) to execute tasks, such as enrolling devices. Enrollment lets IT personnel maintain an inventory of devices that can access enterprise services. Other tasks include mobile device configuration, certificates, Wi-Fi and VPN profiles, and compliance reporting concerning corporate standards. Intune integrates with Azure AD to provide [access control](https://www.techtarget.com/searchsecurity/definition/access-control) capabilities. That provides the required tool set for working toward a zero-trust environment.

Meanwhile, Microsoft's Intune app management approach covers areas such as assigning mobile apps to the workforce, configuring those apps with standard settings and removing enterprise data from mobile apps. When used with other EMS suite services, Intune lets an organization provide apps that can access additional mobile app and data security features, such as single sign-on ([SSO](https://www.techtarget.com/searchsecurity/definition/single-sign-on)) and multifactor authentication.

### Benefits of Microsoft Intune

Intune provides organizations with the features and capabilities to manage their devices and apps and protect company data. With the integrations of Intune with Azure AD, Windows Autopilot, Microsoft Defender for Endpoint, [Microsoft 365](https://www.techtarget.com/searchenterprisedesktop/definition/Microsoft-Office-365-suite) and Windows Autopatch, it's an important part of the zero-trust strategy in a Microsoft cloud environment.

Intune can provide an IT department with the required features for managing enrollments, configurations, security, compliance, apps and updates on any supported device. That enables IT admins to securely provide access to company data on nearly any device.

With direct integration with Conditional Access via Azure AD, Intune can enable IT administrators to check if a device complies with company policies and only allow access to company data and apps when that device is compliant.

### Challenges of Microsoft Intune

Intune excels within a Microsoft environment because it integrates well with other Microsoft products. While Intune can manage non-Windows platforms, it won't be at the same level as specialized products. For example, a product like [Jamf](https://www.techtarget.com/searchenterprisedesktop/tip/Explore-Jamfs-products-and-features-for-Apple-management) provides more options for managing devices in the Apple ecosystem.

Additionally, organizations that use Linux devices may want to look at alternative UEM platforms. Except for verifying compliance and securely providing access to company data, no other management capabilities are currently available for Linux distributions.

### History and development

Microsoft Intune launched in 2011 as Windows Intune, with the name change to Microsoft Intune announced in 2014. A key development since then was the migration of Microsoft Intune to the Microsoft Azure public cloud. In December 2016, Microsoft unveiled a preview where administrators could access and manage Microsoft Intune using the Azure portal. In June 2017, Microsoft announced the general availability of Intune management through the Azure portal.

Microsoft's Conditional Access feature became available via the Azure portal in 2017. Conditional Access works across the EMS suite, letting organizations control access to enterprise data based on considerations such as location and the sensitivity of a given application.

In 2018, Microsoft announced that the Intune Managed Browser application on iOS and Android could utilize SSO to access all web applications, both SaaS and on premises, provided those applications connect to Azure AD.

Another name change came in 2019 when Microsoft rebranded the suite that contains endpoint management. The new suite, which includes products like Configuration Manager, Intune and Windows Autopilot, was named Microsoft Endpoint Manager.

In 2022, Microsoft rebranded Microsoft Endpoint Manager back to Microsoft Intune with several new product announcements, including Remote Help, Endpoint Privilege Management, advanced endpoint analytics and Microsoft Tunnel for MAM. The first batch of expanded tools launched on March 1, 2023, and more features are planned for release later in 2023.

### Microsoft Intune pricing

Intune is priced per user, per month, and organizations can purchase it as a standalone plan or a component of another subscription. The following are the three individual plans:

1. **Microsoft Intune Plan 1.** Plan 1 includes basic UEM functionality and is included with subscriptions to Microsoft 365 E3, E5, F1, F3, EMS E3 and E5, and Business Premium plans. Notably, the expanded tools in Microsoft Intune Suite are purchasable as add-ons for Plan 1. The price for Plan 1 is $8 per user, per month.
2. **Microsoft Intune Plan 2.** Plan 2 is an add-on to Plan 1 and features additional tools, such as Microsoft Intune Tunnel for MAM and endpoint management for specialty devices. The price for Plan 2 is $4 -- in addition to the $8 for Plan 1 -- per user, per month.
3. **Microsoft Intune Suite.** Intune Suite is the highest-tier plan for Intune as a standalone service. It's an add-on to Plan 1, includes the add-ons from Plan 2 and features even more tools. The additional tools found in Intune Suite include Remote Help, Endpoint Privilege Management, advanced endpoint analytics and more tools set for release later in 2023. The price for Intune Suite is $10 -- in addition to the $8 for Plan 1 -- per user, per month.



***

## REFERENCES

* [https://www.techtarget.com/searchitchannel/definition/Microsoft-Intune](https://www.techtarget.com/searchitchannel/definition/Microsoft-Intune)
* [https://www.microsoft.com/en-us/security/business/endpoint-management/microsoft-intune](https://www.microsoft.com/en-us/security/business/endpoint-management/microsoft-intune)
* [https://www.microsoft.com/en-us/security/business/microsoft-intune-pricing](https://www.microsoft.com/en-us/security/business/microsoft-intune-pricing)
