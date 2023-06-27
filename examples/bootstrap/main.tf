module "bootstrap" {
  source = "../../bootstrap"

  environment = "prod"
  name        = "myproject"
  region      = "eu-west-2"

  tags = {
    BusinessCriticality = "High"
    Environment         = "Production"
    Owner               = "NetworkTeam"
    Project             = "Operations"
    Repository          = "https://github.com/appvia/tf-aws-myproject"
  }
}
