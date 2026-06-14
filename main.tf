module "vpc" {
  source = "./vpc"

  project_name = var.project_name
  aws_region   = var.aws_region
}


module "ecr" {
  source = "./ecr"

  project_name = var.project_name
}



module "github_oidc" {
  source = "./oidc"

  github_org  = var.github_org
  github_repo = var.github_repo
}


module "eks" {
  source = "./eks"

  project_name = var.project_name

  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
}
