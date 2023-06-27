variable "create_oidc_provider" {
  description = "Whether to create an OIDC provider in AWS (only needs to be done once per AWS account)"
  default     = true
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "github_repositories" {
  description = "List of GitHub organization/repository names authorised to assume a role in this account via Web Identity Federation"
  type        = list(string)
  default     = []
}

variable "iam_role_name" {
  description = "Name of the IAM role to create"
  type        = string
  default     = "github"
}

variable "iam_role_policy_arns" {
  description = "List of IAM role policy ARNs to attach to the OIDC role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

variable "max_session_duration" {
  description = "Maximum session duration for the OIDC role"
  type        = number
  default     = 3600
}

variable "name" {
  description = "Name reference for your infrastructure"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(any)
  default     = {}
}
