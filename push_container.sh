#!/bin/sh

source .env

circleci build \
-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
-e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
-e ECR_ENDPOINT=${ECR_ENDPOINT} \
-c ./.circleci/config.yml