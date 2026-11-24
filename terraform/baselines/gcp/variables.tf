variable "gcp_project" { type = string }
variable "github_repo" {
  type        = string
  description = "OWNER/REPO that the WIF provider will trust."
}
