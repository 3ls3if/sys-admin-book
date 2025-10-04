---
icon: gears
---

# Veeam Backup for Microsoft Office 365 – Configuration

This post will walk through the configuration steps. The screen below is what you will see when you open the console and connect to a brand-new installation.

The first task we have to perform is adding an organisation. Here we can add an Office 365 organisation but this product will also allow for protecting Microsoft Exchange on premises.\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam1.png" alt=""><figcaption></figcaption></figure>

\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam2.png" alt=""><figcaption></figcaption></figure>

For the walkthrough I am going to add my Office 365 organisation, I mean who has Microsoft Exchange in their lab anymore. We can also choose here if we have Exchange Online, SharePoint Online and OneDrive for business.

![121919 2303 HowToVeeam3](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam3.png)

In the previous release of the product Modern Authentication was added as well as the existing basic authentication. It is always advised here to use Modern Authentication. Falko Banaszak did an awesome post for how to configure modern authentication within Microsoft Azure Active Directory for Veeam Backup for Microsoft Office 365, you can find that [here](https://www.virtualhome.blog/2019/05/02/modern-authentication-with-veeam-backup-for-office-365-v3/).\


\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam4.png" alt=""><figcaption></figcaption></figure>

That’s it, supply credentials and connect.

![121919 2303 HowToVeeam5](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam5.png)

Now we have our organisation but no backup jobs configured we will come back to that in the next post.

![121919 2303 HowToVeeam6](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam6.png)

Next we need configure our backup infrastructure, the backup infrastructure consists of Proxies to perform the lifting of the data between Microsoft Office 365 and the Backup environment. The backup repositories and Object Storage Repositories.

There is always a default backup repository created, we are not going to use this and we are going to create a new one because we cannot add the Object Storage Repository to the default repository.

![121919 2303 HowToVeeam7](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam7.png)

Before we create that new Backup Repository, we need to connect to our Object Storage Repository.

\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam8.png" alt=""><figcaption></figcaption></figure>

A very simple wizard driven approach again, give your new repository a name.

\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam9.png" alt=""><figcaption></figcaption></figure>

The biggest feature added in Veeam Backup for Microsoft Office 365 v4 is the fact you can now backup directly to Object Storage. On the next screen you can choose your Object Storage type.

![121919 2303 HowToVeeam10](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam10.png)

For the series I am using AWS S3, all should become clearer later on in the series. We need to provide our cloud credentials here. This will be your access key and secret key for AWS accounts. Be careful here as you don’t want to be letting them get into the wrong hands.

\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam11.png" alt=""><figcaption></figcaption></figure>

![121919 2303 HowToVeeam12](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam12.png)

Next, we need to choose our location, bucket and folder.

![121919 2303 HowToVeeam13](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam13.png)

We also have the ability to configure some advanced settings on if you want to limit the storage consumption or to use AWS S3 Infrequent Access.

![121919 2303 HowToVeeam14](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam14.png)

Click finish and you have your Object Storage Repository listed.

![121919 2303 HowToVeeam15](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam15.png)

Before we can get going with creating a backup job, we need to create that repository that I mentioned. If you right click in that white space, you can create a new Backup Repository

![121919 2303 HowToVeeam16](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam16.png)

Next you elect your backup proxy and the path to your local backup repository; this will be where metadata and cache will be stored. If you choose not to use Object Storage then this is where you would determine the location for all of your backup files.

\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam17.png" alt=""><figcaption></figcaption></figure>

If you are intending to use the direct to Object Storage, then you will need to select this and choose your previously added Object Storage Repository.

We also have another new feature here in the fact that you can encrypt the data being uploaded to object storage. Specifically calling out security when sending data into the public cloud.

\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam18.png" alt=""><figcaption></figcaption></figure>

Finally, we can choose our retention policy,

**Item-Level Retention**\


Select this type if you want to keep an item until its creation time or last modification time is within the retention coverage.

**Snapshot-Based Retention**\


Select this type if you want to keep an item until its latest restore point is within the retention coverage.

User guide shout out for an awesome description to the two options – [https://helpcenter.veeam.com/docs/vbo365/guide/retention\_policy.html?ver=40](https://helpcenter.veeam.com/docs/vbo365/guide/retention_policy.html?ver=40)

![121919 2303 HowToVeeam19](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam19.png)

Below you will now see the new object storage enabled backup repository.

![121919 2303 HowToVeeam20](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2303_HowToVeeam20.png)

Click finish and we have everything configured. Next up is getting our data backed up from Microsoft Office 365.



***

## REFERENCES

* [https://vzilla.co.uk/vzilla-blog/how-to-veeam-backup-for-microsoft-office-365-configuration](https://vzilla.co.uk/vzilla-blog/how-to-veeam-backup-for-microsoft-office-365-configuration)
