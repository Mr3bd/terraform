variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
  default = "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"
}

variable "repo_name" {
  description = "Repo Name"
  type        = string
}

variable "branches" {
  description = "List of branches to create"
  type        = list(string)
  default     = ["main"]  # Default value
}

variable "members_file" {
  description = "Path to the JSON file containing team members and repo owner"
  type        = string
  default     = "members.json"
}
