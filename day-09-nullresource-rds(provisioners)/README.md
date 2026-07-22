# Day 09: Null Resources and RDS Provisioners

Focused on using Terraform provisioners for tasks that run after infrastructure is created.

## Topics covered

- `null_resource` for running operational steps outside a managed AWS resource.
- `depends_on` to control provisioning order.
- `triggers` with `filemd5()` to rerun a provisioner when a script changes.
- `file` and `remote-exec` provisioners to copy and run scripts over SSH.
- `local-exec` to initialize an RDS database from the local machine.
- AWS data sources to read an existing VPC or RDS instance.

## Examples

- `ec2withNullResource`: provisions an EC2 instance and runs `setup.sh` remotely.
- `rds-local-execution`: creates RDS and imports `init.sql` from the local machine.
- `rds-remote-execution`: uses an EC2 host to run `init.sql` against an existing RDS instance.