# Terraform IAM policies to assume read-only access to S3 in another AWS account

## Overview
This project deploys a set of IAM policies attached to an IAM role granting a file share read-only access to an S3 bucket in a separate account.

Note that the account hosting the S3 bucket being accessed must apply a bucket policy to the S3 bucket granting this account read-only rights to the bucket.
Deploying this project in an AWS account can launch resources that are not free to deploy and use.  Consult the various AWS pricing guides available for the resources included in this project before deploying these resources.

## Disclaimer
The author of this terraform example bears no responsibility for any costs that may arise as a result of using this project.  User of this example code assumes full responsibility for it's use and any results that may come from its deployment.
  
## Usage Instructions
The code in this repo is meant to be incorporated into a separate project deploying one or more storage gateways across multiple accounts.

This code can also be consumed as a terraform module.  To use this project as a module, you can call it by doing the following: 
 ```hcl-terraform
module "cross_account_iam_policy" {
  source                = "${path_to_this_module}"
  role_name             = "read-only-from-other-account"
  cross_account_bucket_arn = "${arn_of_bucket_in_other_account}"
}
```

