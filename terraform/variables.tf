variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
  default = "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"
}

variable "repo_name" {
  description = "GitHub repository name"
  type        = string
}

variable "team_name" {
  description = "GitHub team name"
  type        = string
}

variable "members" {
  description = "List of team members"
  type        = list(string)
}

variable "branches" {
  description = "List of branches to create"
  type        = list(string)
}
