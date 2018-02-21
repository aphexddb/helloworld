# Hello World

Simple hello world app.

You need to set the following environment variables on CircleCI UI:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_DEFAULT_REGION`
* `ECR_ENDPOINT`: e.g. <ACCOUNT-ID>.dkr.ecr.ap-northeast-1.amazonaws.com

Edit Terraform vars in [terraform/terraform.tfvars](terraform/terraform.tfvars):

```terraform
access_key = ""
secret_key = ""
region = ""
```

Then apply:

```bash
terraform plan && terraform apply
```

