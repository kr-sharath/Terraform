# Terraform CI/CD Pipeline – GitHub Actions + AWS OIDC

This repository uses GitHub Actions to deploy Terraform-managed infrastructure to AWS using OIDC federation.
The workflow automatically runs when changes are pushed to the `main` branch.

## Authentication Method

OIDC (OpenID Connect) is commonly used when an application that does not run on AWS needs access to AWS resources. You create an IAM identity provider to inform AWS about the external IdP and its configuration. This establishes trust between your AWS account and the external IdP.

Configure your applications to request temporary AWS security credentials dynamically when needed using OIDC federation. The supplied temporary credentials map to an AWS role that only has permissions needed to perform the tasks required by the application.

This workflow uses:
* GitHub OIDC
* AWS IAM Role assumption

Permissions required:\
S3 backend access\
Lambda & API Gateway permissions\
IAM read + pass role permissions

## Workflow Overview

* Workflow Name: lambda pull request
* Trigger: Push to main branch
* Path Filters:  

> environments/dev/\*.tf \
  .github/workflows/\*.yml \
  modules/**
  
The workflow is triggered when `push` is made to main `branch` and when Terraform files or workflow files are modified mentioned above.

### Workflow job

The workflow contain only one job `deployTerraform` with default like the *shell* and *working-directory*.  

The permissions specified for the job to fetch an OpenID Connect (OIDC) token. This requires `id-token: write`, `contents: read` permits an action to list the commits.
```
permissions:
  id-token: write      
  contents: read
```

## Workflow Steps

1. **Checkout Repository** : The `actions/checkout@v4` is a GitHub Action that checks out your repository into the runner's workspace, allowing your workflow to access its code for building, testing, or deployment.
```
- name: Checkout code
        uses: actions/checkout@v4 
```
2. **Configure AWS Creds** : The `aws-actions/configure-aws-credentials@v4` action for GitHub Actions configures AWS credentials and region environment variables for subsequent steps in a workflow.
```
- name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ vars.ASSUME_ROLE }}
          role-session-name: ${{ github.run_id }}
          aws-region: ${{ vars.REGION }}
```
*aws-region*: Region to use (Required)\
*role-to-assume*: Role for which to fetch credentials.\
Additional [options](https://github.com/aws-actions/configure-aws-credentials?tab=readme-ov-file#options) can be provided for the action.

3. **Setup Terraform** : The `hashicorp/setup-terraform@v3` action for workflow step used to install a specific version of the Terraform CLI and configure it for use within a GitHub Actions job. 
```
- name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.6.0
```
4. **tfsec** : The `aquasecurity/tfsec-action@v1.0.0` is a specific version of a GitHub Action used to run tfsec, a static analysis security scanner for Terraform code, within a GitHub Actions workflow.\
```
- name: tfsec
        uses: aquasecurity/tfsec-action@v1.0.0
        with: 
          soft_fail: true
```
The action checks your Terraform code for potential security issues and misconfigurations across major cloud providers (AWS, Azure, GCP) using hundreds of built-in rules. It can be configured to fail a workflow if insecure code is detected.\
In this workflow soft_fail set to true in order to not to break the build.