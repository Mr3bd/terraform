terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

# Create a new repository
resource "github_repository" "new_repo" {
  name        = var.repo_name
  description = "Managed by Terraform"
  visibility  = "public"
  auto_init   = true
}

# Add members to the repository
resource "github_team" "team" {
  name        = var.team_name
  description = "Terraform-managed team"
  privacy     = "closed"
}

resource "github_team_membership" "team_membership" {
  for_each = toset(var.members)
  team_id  = github_team.team.id
  username = each.value
  role     = "member"
}

# Create branches
resource "github_branch" "branches" {
  for_each    = toset(var.branches)
  repository  = github_repository.new_repo.name
  branch      = each.value
}
