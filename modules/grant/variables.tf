
variable "roles_databases_list" {
  description = "All Roles that will take specific permissions for the Database."
  type        = list(object({
    role     = string
    database = string 
  }))
  default     = []
}