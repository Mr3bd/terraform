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

# Read members and repo owner from the JSON file
locals {
  members = jsondecode(file(var.members_file))
  repo_owner = local.members.repo_owner
}

# Create GitHub repository
resource "github_repository" "example_repo" {
  name        = var.repo_name
  description = "This repo was created using Terraform"
  visibility  = "private"
  auto_init   = true
  owner       = local.repo_owner  # Set the repository owner from the JSON file
}

# Create multiple branches dynamically
resource "github_branch" "branches" {
  for_each   = toset(var.branches)
  repository = github_repository.example_repo.name
  branch     = each.value
}

resource "github_repository_collaborator" "repo_collaborators" {
  for_each = { for member in local.members.members : member.username => member }

  repository = github_repository.example_repo.name
  username   = each.value.username
  permission = each.value.role
}

resource "github_repository_file" "codeowners" {
  repository          = github_repository.example_repo.name
  file                = ".github/CODEOWNERS"
  content             = <<EOT
# Define code ownership for specific files
# Format: path @username or @team
*.tf @terraform-admins
src/ @developers
docs/ @tech-writers
EOT
  commit_message      = "Add CODEOWNERS file"
  commit_author       = "Terraform Bot"
  commit_email        = "terraform-bot@example.com"
}

# Protect main branch
# resource "github_branch_protection" "main_protection" {
#  repository_id  = github_repository.example_repo.node_id
#  pattern        = "main"

#  required_pull_request_reviews {
#    required_approving_review_count = 2
#  }

#  required_status_checks {
#    strict   = true
#    contexts = ["CI/CD Checks", "Security Scan"]
#  }

#  enforce_admins    = true
#  allows_deletions  = false
#  allow_force_pushes = false
#}
