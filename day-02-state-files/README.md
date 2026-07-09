# Terraform Learning – Day 02


## Topics Covered

* Terraform State
* Resource tracking and resource identity
* Resource dependencies
* Implicit dependencies
* Creating an EC2 instance using Terraform
* Connecting EC2 → Subnet → VPC
* Understanding `terraform plan`
* Understanding `terraform apply`
* Understanding `terraform destroy`
* Viewing resources managed by Terraform

## Infrastructure Created

The infrastructure created during this practice:

```text
VPC
 └── Subnet
      └── EC2 Instance
```

Terraform automatically understands the creation order through resource references:

```text
VPC
 ↓
Subnet
 ↓
EC2 Instance
```

For example:

```hcl
vpc_id = aws_vpc.first_vpc.id
```

creates an implicit dependency between the subnet and VPC.

Similarly:

```hcl
subnet_id = aws_subnet.first_subnet.id
```

creates an implicit dependency between the EC2 instance and subnet.

## Terraform State

Terraform state keeps track of the real infrastructure resources managed by Terraform.

For example:

```text
Terraform Resource Address
aws_vpc.first_vpc

        ↓ maps to

Actual AWS Resource
vpc-xxxxxxxxxxxxxxxxx
```

The state allows Terraform to understand whether a resource should be:

* Created
* Updated
* Replaced
* Destroyed
* Left unchanged

The local state is stored in:

```text
terraform.tfstate
```

The state file should not be committed to Git because it can contain sensitive information and should not be independently modified or shared between team members.

## Useful State Commands

List all resources currently managed by Terraform:

```bash
terraform state list
```

Inspect a specific managed resource:

```bash
terraform state show aws_instance.first_ec2
```

## Terraform Workflow Practiced

```text
Write Terraform Configuration
            ↓
terraform init
            ↓
terraform plan
            ↓
Review Planned Changes
            ↓
terraform apply
            ↓
Infrastructure Created in AWS
            ↓
Terraform State Updated
```

## Working with Multiple Variable Files

Using multiple Terraform variable files for different environments or configurations.

Example:

```text id="dk7wty"
terraform.tfvars
test.tfvars
dev.tfvars
```

A specific variable file can be passed during planning:

```bash id="h47j65"
terraform plan -var-file="test.tfvars"
```

and during apply:

```bash id="21kj60"
terraform apply -var-file="test.tfvars"
```

This allows the same Terraform configuration to be reused with different input values.

For example:

```text id="8uc13s"
Same Terraform Code
        │
        ├── dev.tfvars  → Development values
        │
        ├── test.tfvars → Testing values
        │
        └── prod.tfvars → Production values
```

This approach helps separate infrastructure configuration values from the main Terraform resource definitions and makes the configuration more reusable across environments.


## Destroying Infrastructure

Terraform can destroy the resources it manages using:

```bash
terraform destroy
```

Before destroying, the destruction plan can be reviewed using:

```bash
terraform plan -destroy
```

Terraform destroys resources in dependency-safe order.

For this infrastructure:

```text
EC2 Instance
      ↓
Subnet
      ↓
VPC
```