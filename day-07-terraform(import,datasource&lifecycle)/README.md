# Terraform Day 07 — Import, Data Sources & Lifecycle

## Overview

Demonstrated how Terraform can manage existing infrastructure, retrieve information from existing AWS resources, and customize resource behavior during create, update, and destroy operations.

## Topics Covered

* Terraform Import
* Importing existing AWS resources into Terraform state
* Understanding Terraform State after import
* Synchronizing imported resources with Terraform configuration
* Terraform Data Sources
* Reading existing AWS resources using data sources
* Using data source attributes in other resources
* Terraform Lifecycle Meta-Arguments

  * `prevent_destroy`
  * `ignore_changes`
  * `create_before_destroy`

* Resource dependency using data sources
* Drift detection and lifecycle behavior

## AWS Resources Used

* Amazon VPC
* Amazon EC2 Instance
* Amazon Subnet
* AWS Availability Zones

## Commands Used

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform import
terraform state list
terraform state show
terraform destroy
```

## Key Concepts

* Importing existing infrastructure into Terraform state without recreating resources
* Reading existing infrastructure using data sources
* Referencing data source attributes across resources
* Protecting resources from accidental deletion
* Ignoring specific configuration drift
* Controlling replacement behavior during infrastructure updates