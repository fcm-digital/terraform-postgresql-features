
resource "postgresql_database" "db" {
  for_each = { for instance_db in var.instance_databases_list : instance_db.name => instance_db }

  name              = each.key
  owner             = each.value.owner
  template          = "template1" #DEFAULT GCP template
  connection_limit  = -1
  allow_connections = true
}