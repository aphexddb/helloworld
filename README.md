# Hello World

Simple hello world app.

## Continuous Integration

Continuous Integration is done via CircleCI.

### Development

You can use [`circleci`](https://circleci.com/docs/2.0/local-jobs/#circleci-command-line-interface-cli-overview) to check configs locally and build before pushing:

```bash
circleci config validate -c .circleci/config.yml
circleci build -c .circleci/config.yml
```

You can also use a [pre-commit hook](https://circleci.com/blog/circleci-hacks-validate-circleci-config-on-every-commit-with-a-git-hook/) to validate CircleCI config.

### Production

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

