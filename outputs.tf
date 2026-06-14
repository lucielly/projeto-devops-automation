output "ecr_repository_url" {
  value = module.ecr.repository_url
}


output "github_role_arn" {
  value = module.github_oidc.github_role_arn
}


output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}