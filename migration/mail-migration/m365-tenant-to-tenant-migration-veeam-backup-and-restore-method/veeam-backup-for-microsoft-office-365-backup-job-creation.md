---
icon: clipboard-list
---

# Veeam Backup for Microsoft Office 365 – Backup Job Creation

Head back to the “organizations” section of your console and select Backup.

Very simply add a name and description for your backup job.\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam1.png" alt=""><figcaption></figcaption></figure>

Our first choice is do you want to backup the entire organisation or a subset of users. I have one user in my organisation so that makes my selection easy.

<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam2.png" alt=""><figcaption></figcaption></figure>

![121919 2304 HowToVeeam3](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam3.png)

The next screen is choosing anything you wish to exclude, you may have selected entire organisation but there may be some accounts you do not need to protect.

\


<figure><img src="https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam4.png" alt=""><figcaption></figcaption></figure>

The next screen is where we configure our Proxy and Backup Repository.

![121919 2304 HowToVeeam5](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam5.png)

The above is the correct setting but if we want to go directly off to Object Storage you must make sure that the Backup Repository has some additional configuration steps completed before starting the job. This was covered in the previous post.

Next up is the schedule.

![121919 2304 HowToVeeam6](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam6.png)

That’s the job created and will run against the schedule you have configured. Pretty simple stuff.

If you wanted to perform a job, then you can do by navigating back to the window below and here you can start the backup job. You will see it connecting and processing all available data.

![121919 2304 HowToVeeam7](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam7.png)

Once the job is completed then you will see the recovery options when you right click against the organisation.

![121919 2304 HowToVeeam8](https://vzilla.co.uk/wp-content/uploads/2019/12/121919_2304_HowToVeeam8.png)

The next post is going to cover those recovery options that you can see above as well as later in the series go into a few use cases where recovery will be required.



***

## REFERENCES

* [https://vzilla.co.uk/vzilla-blog/how-to-veeam-backup-for-microsoft-office-365-backup-job-creation](https://vzilla.co.uk/vzilla-blog/how-to-veeam-backup-for-microsoft-office-365-backup-job-creation)
