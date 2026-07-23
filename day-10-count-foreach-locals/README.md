# Day 10: `count`, `for_each`, Locals, and Dynamic Blocks

This lesson demonstrates how Terraform can create repeated resources and nested blocks without duplicating configuration.

## Topics covered

- Creating a VPC and calculating a subnet range with `cidrsubnet()`.
- Storing values in `variables` and `locals`.
- Using a `dynamic "ingress"` block to create rules for ports `22`, `80`, `443`, `3000`, and `8000`.
- Using `count` with list indexes to create multiple resources.
- Using `for_each` with a set and accessing the current value through `each.value`.
- Understanding why `for_each` gives resources stable keys such as `["dev"]` and `["prod"]`.

## Files

- `main.tf`: VPC, subnet, and dynamically generated ingress rules.
- `count-vs-foreach.tf`: commented `count` example and active `for_each` example.
- `variables.tf`: VPC CIDR and inbound port definitions.

> **Security note:** The current dynamic rules use `0.0.0.0/0`, so every listed port is publicly reachable. In real infrastructure, restrict sensitive ports such as SSH (`22`) to a trusted IP using a `/32` CIDR.

```bash
terraform init
terraform plan
terraform apply
```