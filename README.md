# Hello World

Simple hello world app.

[![CircleCI](https://circleci.com/gh/aphexddb/helloworld.svg?style=svg)](https://circleci.com/gh/aphexddb/helloworld)

## Building

Build steps are performed via `make`.

* `make lint` performing linting via gometalinter
* `make test` runs tests
* `make release` compiles the application
* `make docker` builds the docker image and tags it

## Continuous Integration

Continuous Integration is done via CircleCI. The [CI script](.circleci/config.yml) does the following:

1. Runs tests
2. Builds app
3. Builds Docker container via the [`Dockerfile`](Dockerfile)
4. Pushes the container to AWS ECS registry

The Docker container is tagged using the `VERSION` file and the current hash. Ex: `0.1.0-7d375f8`

### Development

You can use [`circleci`](https://circleci.com/docs/2.0/local-jobs/#circleci-command-line-interface-cli-overview) to check configs locally and build before pushing. You can validate the circleci config by running:

```bash
circleci config validate -c .circleci/config.yml
```

(You can also use a [pre-commit hook](https://circleci.com/blog/circleci-hacks-validate-circleci-config-on-every-commit-with-a-git-hook/) to validate CircleCI config.)

To run the CI build locally, create a file `.env` with the following:

```bash
AWS_ACCESS_KEY_ID=secret
AWS_SECRET_ACCESS_KEY=secret
AWS_DEFAULT_REGION=us-west-2
ECR_ENDPOINT=<someid>.dkr.ecr.us-west-2.amazonaws.com
```

Then run the script `./ci.sh`.

### Production

You need to set the following environment variables on CircleCI UI:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_DEFAULT_REGION`
* `ECR_ENDPOINT`

### ECS Setup

You can create a AWS ECS registry using the Terraform script. Edit [terraform/terraform.tfvars](terraform/terraform.tfvars):

```terraform
access_key = ""
secret_key = ""
region = ""
```

Then apply the plan:

```bash
terraform plan && terraform apply
```
