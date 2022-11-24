
variable "roles_list" {
  description = "All Roles definition."
  type        = list(object({
    name             = string
    superuser        = optional(bool)
    create_database  = optional(bool)
    create_role      = optional(bool)

    login            = optional(bool)
    password         = optional(string)
    connection_limit = optional(number)
    roles            = optional(List(string))
  }))
  default     = []
  sensitive   = true
}