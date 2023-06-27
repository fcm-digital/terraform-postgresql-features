
variable "roles_list" {
  description = "All Roles definition."
  # type        = list(object({
  #   name             = string
  #   superuser        = optional(bool)
  #   create_database  = optional(bool)
  #   create_role      = optional(bool)

  #   login            = optional(bool)
  #   password         = optional(string)
  #   connection_limit = optional(number)
  #   roles            = optional(list(string))
  # }))
  type    = list(any)
  default = []
}

variable "password_length" {
  type    = number
  default = 16
}

variable "password_special" {
  type    = bool
  default = false
}

variable "onepassword" {
  description = "A map with the necessary data to upload the role/pwd to 1password."
  # type        = object({
  #   enabled    = bool
  #   vault_uuid = string
  #   title      = string
  #   tags       = optional(list(string))
  # }))
  type        = map(any)
  default     = {}
}