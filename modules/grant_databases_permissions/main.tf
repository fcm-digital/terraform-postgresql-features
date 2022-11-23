
locals {
  default_permissions = {
    noone    = []
    readonly = ["SELECT", "CONNECT"]
    owner    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE",
                "REFERENCES", "TRIGGER", "CREATE", "CONNECT",
                "TEMPORARY", "EXECUTE", "USAGE"]
  }
  roles_definition = [
    for db_permissions in var.database_permissions_list: 
    {
      index      = "${db_permissions.database}-${db_permissions.role}"
      database   = db_permissions.database
      role       = db_permissions.role
      privileges = lookup(local.default_permissions, db_permissions.permission, ["SELECT"])
    }
  ]
}

resource "postgresql_grant" "databases" {
  for_each = { for role_definition in local.roles_definition : role_definition.index => role_definition }

  database    = each.value.database
  role        = each.value.role
  object_type = "database"
  privileges  = each.value.privileges
}