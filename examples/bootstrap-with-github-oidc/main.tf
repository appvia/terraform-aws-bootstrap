module "bootstrap" {
  source = "../../bootstrap"

  environment = "prod"
  name        = "myproject"
  region      = "eu-west-2"

  create_oidc_provider = true
  iam_role_name        = "github"
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
