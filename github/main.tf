provider "github" {
  token = var.G_TOKEN        # This should be the GitHub personal access token
  owner = var.github_owner   # GitHub organization or user
}

# Create a new repository
resource "github_repository" "repo" {
  name        = var.repository_name   # Name of the repository to create
  description = "A new repository created with Terraform"
  visibility  = "private"
  auto_init   = true
}

# Add members to the repository
resource "github_repository_collaborator" "collaborator" {
  for_each   = toset(var.repository_members)  # List of GitHub usernames to add
  repository = github_repository.repo.name    # The repository created above
  username   = each.value
  permission = "push"                         # Permissions (e.g., "push")
}

# Create branches
resource "github_branch" "branch" {
  for_each      = toset(var.repository_branches)  # List of branches to create
  repository    = github_repository.repo.name    # The repository created above
  branch        = each.value
  source_branch = "main"  # Default branch to create new branches from
}