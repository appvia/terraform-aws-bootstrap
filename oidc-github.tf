module "oidc_github" {
  count = length(var.github_repositories) != 0 ? 1 : 0

  source  = "unfunco/oidc-github/aws"
  version = "1.5.0"

  create_oidc_provider = var.create_oidc_provider
  github_repositories  = var.github_repositories
  iam_role_name        = var.iam_role_name
  iam_role_policy_arns = var.iam_role_policy_arns
  max_session_duration = var.max_session_duration

  tags = var.tags
}
