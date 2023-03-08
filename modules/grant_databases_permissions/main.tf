
locals {
  default_permissions = {
    noone      = []
    readonly   = ["SELECT"],
    db_creator = ["CREATE"],
    owner      = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE",
                  "REFERENCES", "TRIGGER", "CREATE", "CONNECT",
                  "TEMPORARY", "EXECUTE", "USAGE"]
  }
  roles_definition = [
    for db_permissions in var.database_permissions_list: 
    {
      index       = "${db_permissions.database}-${db_permissions.role}"
      database    = db_permissions.database
      role        = db_permissions.role
      object_type = db_permissions.object_type
      privileges  = lookup(local.default_permissions, db_permissions.permission, ["SELECT"])
    }
  ]
}

# postgresql_grant apply privileges only on existing objects, because this is how GRANT works in Postgres.
resource "postgresql_grant" "tables" {
  for_each = {
    for role_definition in local.roles_definition : role_definition.index => role_definition
    if role_definition.object_type == "table"
  }

  database    = each.value.database
  role        = each.value.role
  schema      = lookup(each.value, "schema", "public") #Default scheme
  object_type = each.value.object_type
  privileges  = each.value.privileges
}

resource "postgresql_grant" "databases" {
  for_each = {
    for role_definition in local.roles_definition : role_definition.index => role_definition
    if role_definition.object_type == "database"
  }

  database    = each.value.database
  role        = each.value.role
  object_type = each.value.object_type
  privileges  = each.value.privileges
}

# default privileges allows to define privileges that will be applied on newly created objects.
# resource "postgresql_default_privileges" "tables" {
#   for_each = { for role_definition in local.roles_definition : role_definition.index => role_definition }

#   database    = each.value.database
#   role        = each.value.role
#   schema      = lookup(each.value, "schema", "public") #Default scheme
#   owner       = lookup(each.value, "owner", replace(each.value.database, "_", "-"))
#   object_type = "table"
#   privileges  = each.value.privileges
# }