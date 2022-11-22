
variable "roles_granted_list" {
  description = "All Granted Roles for a Specific Role."
  type        = list(object({
    role       = string
    grant_role = string
  }))
  default     = []
}