<!-- BEGIN_TF_DOCS -->
# Terraform Module: AWS Bootstrap

This module is used to bootstrap an AWS account with the following resources:
- S3 Bucket for Terraform State
- DynamoDB Table for Terraform State Locking
- [Optional] Configure GitHub Actions as an IAM OIDC identity provider

## Deployment

This module would initially be manually called and applied via the Terraform CLI (e.g. in your project repo, stored under a `bootstrap` directory), with the state stored within your Git repository. Once provisioned, the Terraform state for this module can be stored within the Git repository and should no longer need to be re-run.

Example reference to module:

```hcl
module "bootstrap" {
  source = "../../bootstrap"

  environment = "prod"
  name        = "myproject"
  region      = "eu-west-2"

  create_oidc_provider = true
  iam_role_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  max_session_duration = 3600

  github_repositories = [
    "appvia/tf-aws-myproject",
    "appvia/tf-aws-myproject2:ref:refs/heads/main",
  ]

  tags = {
    BusinessCriticality = "High"
    Environment         = "Production"
    Owner               = "NetworkTeam"
    Project             = "Operations"
    Repository          = "https://github.com/appvia/tf-aws-myproject"
  }
}
```

**Note:** Omit the `github_repositories` variable to skip the IAM OIDC IDP configuration for GitHub Actions.

The following commands can be run to deploy the module:

```bash
terraform init -upgrade
terraform plan
terraform apply
```

Once this is provisioned, you can then reference the remote state in your project repo using the outputs provided by the module (replace variables as appropriate):

```hcl
terraform {
  backend "s3" {
    bucket         = aws_s3_bucket_id
    dynamodb_table = aws_dynamodb_table_id
    encrypt        = true
    key            = "myproject.tfstate"
    region         = "eu-west-2"
  }
}
```

Please see the [examples](./examples) directory for more examples on how to deploy this module.

## Updating Docs

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:
1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Whether to create an OIDC provider in AWS (only needs to be done once per AWS account) | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | List of GitHub organization/repository names authorised to assume a role in this account via Web Identity Federation | `list(string)` | `[]` | no |
| <a name="input_iam_role_policy_arns"></a> [iam\_role\_policy\_arns](#input\_iam\_role\_policy\_arns) | List of IAM role policy ARNs to attach to the OIDC role | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/AdministratorAccess"<br>]</pre> | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration for the OIDC role | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | Name reference for your infrastructure | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_account_id"></a> [aws\_account\_id](#output\_aws\_account\_id) | n/a |
| <a name="output_aws_dynamodb_table_id"></a> [aws\_dynamodb\_table\_id](#output\_aws\_dynamodb\_table\_id) | n/a |
| <a name="output_aws_s3_bucket_id"></a> [aws\_s3\_bucket\_id](#output\_aws\_s3\_bucket\_id) | n/a |
<!-- END_TF_DOCS -->