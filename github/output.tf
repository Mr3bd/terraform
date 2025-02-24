output "repository_url" {
  description = "URL of the created repository"
  value       = github_repository.repo.html_url
}

output "repository_name" {
  description = "Name of the created repository"
  value       = github_repository.repo.name
}

output "repository_members" {
  description = "List of members added to the repository"
  value       = var.repository_members
}

output "repository_branches" {
  description = "List of branches created in the repository"
  value       = var.repository_branches
}