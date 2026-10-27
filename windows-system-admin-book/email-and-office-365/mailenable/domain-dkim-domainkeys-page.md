---
icon: key-skeleton
---

# Domain - DKIM (DomainKeys)Page

### DKIM Overview

DKIM provides a mechanism for verifying the integrity of a message. The message is signed before sending by encrypting a hash of its headers using public key encryption and then verified upon receipt by decrypting the signature using a public key (provided by the sender in a DNS record) and comparing the hash. This provides extremely strong assurance of a message's fidelity and authenticity, since any change to the message's headers or body will cause verification to fail.

The only real disadvantage is the extra time it takes to process each message, since signing and verifying both involve relatively expensive cryptographic calculations and verifying requires a lookup of the sender's DNS records.

### How to enable DKIM for the server

1. Navigate to the following location within the administration console: **Servers > Localhost > Extensions**
2. Right click on **Domain Keys (DKIM)** and select properties.
3. Tick the option for **Enable DomainKeys Identified Mail (DKIM) functionality on this server**

### How to configure DKIM for a domain <a href="#i-heading-how-to-configure-dkim-for-a-domain" id="i-heading-how-to-configure-dkim-for-a-domain"></a>

1. Navigate to within the administration console to: **MailEnable management > Messaging Manager > Post Offices > (postofficename) > Domains**
2. Right-click on the domain you wish to configure **DKIM** for and select **Properties**_._
3. Select the **DKIM** tab and click the **Configure** butto&#x6E;_._

![](https://www.mailenable.com/documentation/10.0/Standard/images/ScreenShot019.png)

1. Check the **Sign outgoing messages** box to enable message signing.
2. Set the options for message signing. The following options are present:<br>
   * _Encryption algorithm_: choose which algorithm will be used for signing the headers hash.
   * _Canonicalization algorithm_: this can be set independently for the headers and the body. The simple algorithm is stricter and will cause verification to fail if the message is changed at all in transit, whereas the relaxed algorithm will tolerate some whitespace insertion.
   * _Impose body hash length limit_: this allows you to limit how much of the message body will be used in the body hash.**Note:** setting a limit means that verification may succeed even if extra data is appended to the message somewhere in transit.
   * _Include user identity_: if checked, includes the sending user's identity in the signature header.
3. Configure selectors. A selector represents a private/public key pairing and, from the verifier's point of view, an entry in a DNS text record.
   1. Clicking New will bring up the _New Selector_ dialog: enter a unique name for the selector and choose a key size (the larger the key, the more secure the encryption, but the longer it will take to sign and verify each message).
   2. Options for each selector can be set by selecting the selector from the Selectors list, setting the options on the right, and then clicking Update. The following options are present:
      * _Test mode_: if this is checked, it indicates to verifiers that the server is testing DKIM, and that signed messages should not be treated any differently to unsigned messages, even if their verification fails.
      * _Granularity_: tells verifiers that only messages sent by a specified user should pass verification. This works by comparing the granularity with the user identity.
      * _Notes_: notes for human perusal.
      * _Make this the active selector_: use this selector for all outgoing messages. Only one selector can be active at a time, activating one will deactivate all others (however, even deactivated selectors are available for verifying against previously sent messages, so long as their entry remains in the appropriate DNS text record).
   3. It is recommended that selectors be regularly deactivated then decommissioned to prevent the key for the active (or a recently active) selector from being cracked. Selectors can be deleted with the _Delete_ button.
   4. To make a selector available to verifiers, that selector must be selected, and the text generated in the box at the bottom of the form must be copied into a specially created DNS text record. This record must exist within a \_domainkey sub domain and must have the same name as the selector.
4. Click _OK_ to save settings and exit, or _Cancel_ to simply exit.

![](https://www.mailenable.com/documentation/10.0/Standard/images/ScreenShot020.png)

&#x20;

To begin signing messages with DKIM, a DNS text record must be created for the sending domain in a sub domain called \_domainkey. The text record will contain necessary information for verifiers, including the public key required for decrypting the signature hash. This information will be generated as part of the configuration process, and must be copied from the configuration window into the text record.

**Note:** instructions on setting up and maintaining DNS records are outside the scope of this document. Please contact your DNS administrator for more information.

### Testing the DKIM Configuration <a href="#i-heading-testing-the-dkim-configuration" id="i-heading-testing-the-dkim-configuration"></a>

To test DKIM right away, try the following configuration:

* _Encryption algorithm_: rsa-sha256
* _Canonicalization algorithm_:
*
  * _Header_: relaxed
  * _Body_: relaxed
* _Impose body hash length limit_: false
* _Include user identity_: false

Create a new selector called "test" with a key size of 1024. With this new selector selected, set the following options:

* _Test mode_: true
* _Make this the active selector_: true

Click Update.

Now copy the text in the box into the DNS text record at test.\_domainkey.\<your domain>.

<br>
