
variable "instance_databases_list" {
  description = "All SQL Instance Databases."
  type        = list(object({
    name  = string
    owner = string
  }))
  default     = []
}