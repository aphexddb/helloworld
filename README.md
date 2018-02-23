# Hello World

Simple hello world app.

[![CircleCI](https://circleci.com/gh/aphexddb/helloworld.svg?style=svg)](https://circleci.com/gh/aphexddb/helloworld)

## Building

Build steps are performed via `make`.

* `make lint` performing linting via gometalinter
* `make test` runs tests
* `make release` compiles the application
* `make docker` builds the docker image and tags it

### Dependencies

Dependencies are vendored via `dep`. Running `dep ensure` will make sure all dependencies are vendored.

## Continuous Integration

Continuous Integration is done via CircleCI. The [CI script](.circleci/config.yml) does the following:

1. Runs tests
2. Builds app
3. Builds Docker container via the [`Dockerfile`](Dockerfile)
4. Pushes the container to AWS ECS registry

The Docker container is tagged using the `VERSION` file and the current hash. Ex: `0.1.0-7d375f8`

### Local Builds

You can validate the circleci config by running: (You can also use a [pre-commit hook](https://circleci.com/blog/circleci-hacks-validate-circleci-config-on-every-commit-with-a-git-hook/) to validate CircleCI config.)

```bash
circleci config validate -c .circleci/config.yml
```

Local builds using the [`circleci`](https://circleci.com/docs/2.0/local-jobs/#circleci-command-line-interface-cli-overview) command line tool use a different container for speed purposes. To build the container:

```bash
docker build -t circleci_dev:latest -f Dockerfile.build .
```

Then run this to to a quick local CI build:

```bash
circleci build -c ./.circleci/config_dev.yml
```

To run the real CI build locally, create a file `.env` with the following:

```bash
AWS_ACCESS_KEY_ID=secret
AWS_SECRET_ACCESS_KEY=secret
AWS_DEFAULT_REGION=us-west-2
ECR_ENDPOINT=<someid>.dkr.ecr.us-west-2.amazonaws.com
```

Then run the script `./ci.sh`.

### Production Builds

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
