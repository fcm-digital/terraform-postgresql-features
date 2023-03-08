
variable "database_permissions_list" {
  description = "All Role Permissions for Databases."
  type        = list(object({
    database    = string
    role        = string
    permission  = string
    object_type = string
  }))
  default     = []
}