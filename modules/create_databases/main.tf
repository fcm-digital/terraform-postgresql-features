
resource "postgresql_database" "db" {
  for_each = { for instance_db in var.instance_databases_list : instance_db.name => instance_db }

  name              = each.key
  owner             = each.value.owner
  template          = lookup(each.value, "template", "template0") #DEFAULT GCP template0
  connection_limit  = -1
  allow_connections = true
}