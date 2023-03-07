
resource "postgresql_grant" "roles" {
  for_each = { for role_database in local.roles_databases_list : role_database.role => role_database }

  role        = each.key
  database    = each.value.database
  schema      = lookup(each.value, "schema", "public") #Default scheme
  object_type = "database"
  privileges  = ["CREATE"]
}