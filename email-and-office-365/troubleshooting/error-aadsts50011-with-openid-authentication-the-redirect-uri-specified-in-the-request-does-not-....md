---
icon: tree-deciduous
---

# Error AADSTS50011 with OpenID authentication: The redirect URI specified in the request does not ...

{% hint style="warning" %}
## Error AADSTS50011 with OpenID authentication: The redirect URI specified in the request does not match <a href="#error-aadsts50011-with-openid-authentication-the-redirect-uri-specified-in-the-request-does-not-matc" id="error-aadsts50011-with-openid-authentication-the-redirect-uri-specified-in-the-request-does-not-matc"></a>
{% endhint %}

### Symptoms <a href="#symptoms" id="symptoms"></a>

You receive the following error message when you try to sign in to an application that uses OIDC or OAuth2 authentication protocols with Microsoft Entra ID:

> Error AADSTS50011 - The redirect URI \<Redirect URI> specified in the request does not match the redirect URIs configured for the application \<AppGUID>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to [https://aka.ms/redirectUriMismatchError](https://aka.ms/redirectUriMismatchError) to learn more about how to fix this.

### Cause <a href="#cause" id="cause"></a>

This error occurs if the redirect URI (reply URL) configured in the application (code) and the Microsoft Entra app registration don't match.

When a user accesses the application for authentication, the application redirects the user to Microsoft Entra ID with a predefined redirect URI. Once the user is authorized successfully, Microsoft Entra ID verifies the following values:

* The redirect URI sent from the application
* The redirect URI values in the registered application in Microsoft Entra ID

If the redirect URI the application sent doesn't match any of the redirect URIs in Microsoft Entra ID, error AADSTS50011 will be returned. If the values match, Microsoft Entra ID sends the user to the redirect URI.

### Resolution <a href="#resolution" id="resolution"></a>

To fix the issue, follow these steps to add a redirect URI in Microsoft Entra app registration.

1.  Copy the application ID from the error message. This is the ID of your application that has been registered in Microsoft Entra ID.&#x20;

    <figure><img src="https://learn.microsoft.com/en-us/troubleshoot/entra/entra-id/app-integration/media/error-code-aadsts50011-redirect-uri-mismatch/aadsts50011-error-appid.png" alt=""><figcaption></figcaption></figure>
2. Go to the [Azure portal](https://portal.azure.com/). Make sure you sign in to the portal by using an account that has permissions to update Microsoft Entra Application registration.
3.  Navigate to **Microsoft Entra ID**, select **App registrations**, locate the application registration by using the application ID, and then open the app registration page.

    You can also open the page directly by using the following links:

    * If this app is owned by an organization (Microsoft Entra tenant), use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<AppGUID>`.
    * If this app is owned by your personal Microsoft (MSA) account, use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<AppGUID>/isMSAApp/true`.
4.  On the app registration page, select **Authentication**. In the **Platform configurations** section, select **Add URI** to add the redirect URI displayed in the error message to Microsoft Entra ID.

    ![The screenshot about redirect URI in the AADSTS50011 error message](https://learn.microsoft.com/en-us/troubleshoot/entra/entra-id/app-integration/media/error-code-aadsts50011-redirect-uri-mismatch/aadsts50011-error-redirecturi.png)
5. Save the changes and wait three to five minutes for the changes to take effect, and then send the login request again. You should now be able to sign in to the application. If you don't see the Microsoft Entra login page, try clearing the password cache from your browser or use InPrivate browsing.



***

## REFERENCES

* [https://learn.microsoft.com/en-us/troubleshoot/entra/entra-id/app-integration/error-code-AADSTS50011-redirect-uri-mismatch](https://learn.microsoft.com/en-us/troubleshoot/entra/entra-id/app-integration/error-code-AADSTS50011-redirect-uri-mismatch)
