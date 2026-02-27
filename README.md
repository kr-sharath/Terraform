# Terraform CI/CD Pipeline – GitHub Actions + AWS OIDC

This repository uses GitHub Actions to deploy Terraform-managed infrastructure to AWS using OIDC federation.
The workflow automatically runs when changes are pushed to the `main` branch.

## Workflow Overview

* Workflow Name: lambda pull request
* Trigger: Push to main branch
* Path Filters:  

> environments/dev/\*.tf \
 .github/workflows/\*.yml \
 modules/**

The pipeline only runs when Terraform files or workflow files are modified.

## Authentication Method

OIDC (OpenID Connect) is commonly used when an application that does not run on AWS needs access to AWS resources. You create an IAM identity provider to inform AWS about the external IdP and its configuration. This establishes trust between your AWS account and the external IdP

Configure your applications to request temporary AWS security credentials dynamically when needed using OIDC federation. The supplied temporary credentials map to an AWS role that only has permissions needed to perform the tasks required by the application.

This workflow uses:
* GitHub OIDC
* AWS IAM Role assumption

Permissions required:\
S3 backend access\
Lambda & API Gateway permissions\
IAM read + pass role permissions