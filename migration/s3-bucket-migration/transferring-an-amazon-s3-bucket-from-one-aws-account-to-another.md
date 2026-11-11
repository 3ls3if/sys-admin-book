---
icon: aws
---

# Transferring an Amazon S3 Bucket from One AWS Account to Another

### Prerequisites <a href="#id-757d" id="id-757d"></a>

To get started, ensure you have access to both AWS accounts. In addition, you will need the AWS CLI (Command Line Interface) installed and properly configured with the access credentials for each account.

#### Step 1: Configure the Source and Destination Buckets <a href="#b8bc" id="b8bc"></a>

The first thing to do is to allow the destination AWS account to access the S3 bucket in the source account. This is achieved by setting up a bucket policy on the source bucket. Here is an example of a policy you might use:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DelegateS3Access",
            "Effect": "Allow",
            "Principal": {"AWS": "arn:aws:iam::<Destination-Account-ID>:root"},
            "Action": ["s3:ListBucket","s3:GetObject"],
            "Resource": [
                "arn:aws:s3:::<Source-Bucket-Name>/*",
                "arn:aws:s3:::<Source-Bucket-Name>"
            ]
        }
    ]
}
```

\
Remember to replace \`\<Destination-Account-ID>\` with your destination AWS account number and \`\<Source-Bucket-Name>\` with the name of your source S3 bucket.

#### Step 2: Copy the S3 Objects <a href="#cd05" id="cd05"></a>

After configuring the source bucket, the next step is to copy the S3 objects from the source bucket to the destination bucket. Using the AWS CLI, run the following command:

```
aws s3 sync s3://source-bucket s3://destination-bucket
```

The \`sync\` command compares the source and destination buckets and then copies any new or updated files to the destination bucket. This command is idempotent, meaning if you run it multiple times, the result is the same as running it once.

#### Step 3: Verification <a href="#e62c" id="e62c"></a>

Once the \`sync\` command has been completed, you should verify that all the data has been transferred to the new bucket. Run the \`ls\` command on the destination bucket:

```
aws s3 ls s3://destination-bucket
```

Ensure that the list of objects matches the contents of the source bucket.

#### Step 4: Clean Up <a href="#e894" id="e894"></a>

After verifying the successful transfer of your data, it is best practice to remove the bucket policy from the source bucket that granted access to the destination account.



***

## REFERENCES

* [https://medium.com/trendfingers/transferring-an-amazon-s3-bucket-from-one-aws-account-to-another-8dddc1b99a7c](https://medium.com/trendfingers/transferring-an-amazon-s3-bucket-from-one-aws-account-to-another-8dddc1b99a7c)
