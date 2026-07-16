# 🚀 Terraform Day 05 - AWS Lambda with IAM, S3 Event Triggers & Automatic ZIP Packaging

## 📌 Overview

Demonstrated how to provision an AWS Lambda function completely using Terraform, including its IAM execution role, CloudWatch logging permissions, S3 event-driven invocation, and automatic deployment package generation using the Terraform Archive provider.

---


## ⚙️ Infrastructure Created

### AWS Lambda Function

- Creates a Lambda function using Terraform
- Configures:
  - Function Name
  - Runtime
  - Handler
  - Execution Role
  - Source Code Hash
  - Deployment Package

---

### IAM Execution Role

Creates an IAM Role with a Lambda Trust Policy.

Trust Policy:

- Principal: `lambda.amazonaws.com`
- Action: `sts:AssumeRole`

The execution role is attached to the Lambda function.

---

### IAM Managed Policy Attachment

Attaches the AWS managed policy:

```
AWSLambdaBasicExecutionRole
```

This provides permissions for:

- CloudWatch Log Groups
- Log Streams
- Writing Logs

---

### Amazon S3 Bucket

Creates an S3 bucket using Terraform.

---

### Lambda Invoke Permission

Creates an `aws_lambda_permission` resource allowing Amazon S3 to invoke the Lambda function.

---

### S3 Event Notification

Configures S3 bucket notifications to automatically invoke the Lambda function whenever an object is created.

```
Object Upload
      ↓
S3 Bucket
      ↓
ObjectCreated Event
      ↓
Lambda Function
      ↓
CloudWatch Logs
```

---

## 📦 Automatic ZIP Packaging

Demonstrated automatic Lambda deployment package creation using Terraform's **Archive Provider**.

Instead of manually creating:

```
lambda_function.zip
```

Terraform automatically:

```
Lambda Source Files
        ↓
archive_file
        ↓
Creates ZIP Package
        ↓
Calculates SHA256 Hash
        ↓
Updates Lambda Function
```

### Benefits

- No manual ZIP creation
- Automatic packaging during `terraform plan` / `terraform apply`
- Detects code changes automatically
- Redeploys Lambda only when source files change

---

## 🔄 Automatic Lambda Code Updates

The deployment package hash is generated automatically.

Whenever any file inside the Lambda source directory changes:

```
Edit Source Code
        ↓
archive_file creates new ZIP
        ↓
SHA256 Hash Changes
        ↓
Terraform detects change
        ↓
Lambda Function Updated
```

No manual packaging is required.

---

## 🛠 Terraform Resources Used

- `aws_lambda_function`
- `aws_iam_role`
- `aws_iam_role_policy_attachment`
- `aws_lambda_permission`
- `aws_s3_bucket`
- `aws_s3_bucket_notification`
- `archive_file`

---

## 📚 Concepts Demonstrated

- AWS Lambda Deployment
- IAM Trust Policy
- IAM Managed Policies
- Lambda Execution Role
- CloudWatch Logging
- Amazon S3
- Lambda Invoke Permissions
- S3 Event Notifications
- Event-Driven Architecture
- Automatic ZIP Packaging
- Source Code Hash Detection
- Terraform Archive Provider
- Implicit & Explicit Dependencies

---

## 🚀 Deployment

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## 🔁 Event Flow

```
Terraform Apply
        │
        ▼
Creates IAM Role
        │
Attaches IAM Policy
        │
Creates Lambda Function
        │
Creates S3 Bucket
        │
Grants S3 Invoke Permission
        │
Configures Bucket Event Notification
───────────────────────────────────────

User uploads file
        │
        ▼
S3 ObjectCreated Event
        │
        ▼
Lambda Function
        │
        ▼
CloudWatch Logs
```