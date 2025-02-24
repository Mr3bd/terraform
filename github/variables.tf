variable "G_TOKEN" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
  default = "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"
}

variable "github_owner" {
  description = "GitHub organization or user"
  type        = string
  default = "Mr3bd"
}

variable "repository_name" {
  description = "Name of the repository to create"
  type        = string
  default     = "MyNewRepo143"
}

variable "repository_members" {
  description = "List of GitHub usernames to add as members"
  type        = list(string)
  default     = ["Mr3bd"]
}

variable "repository_branches" {
  description = "List of branches to create"
  type        = list(string)
  default     = ["dev"]
}
