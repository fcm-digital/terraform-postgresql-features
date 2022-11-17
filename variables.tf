
variable "sqlinstance" {
  description = "SQL Instance Connection data."
  type        = map({
    connection_name = string
    username        = string
    port            = string
    password        = string
  })
  sensitive   = true
}

variable "instance_databases_list" {
  description = "All SQL Instance Databases."
  type        = list(object({
    name  = string
    owner = string
  }))
  default     = []
}