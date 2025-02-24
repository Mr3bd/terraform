provider "github" {
  token = var.G_TOKEN
  owner = var.github_owner
}

resource "github_repository" "repo" {
  name        = var.repository_name
  description = "A new repository created with Terraform"
  visibility  = "private"
  auto_init   = true

  lifecycle {
    create_before_destroy = false
  }
}

resource "github_repository_collaborator" "collaborator" {
  for_each   = toset(var.repository_members)
  repository = github_repository.repo.name
  username   = each.value
  permission = "push"
}

resource "github_branch" "branch" {
  for_each      = toset(var.repository_branches)
  repository    = github_repository.repo.name
  branch        = each.value
  source_branch = "main"
}