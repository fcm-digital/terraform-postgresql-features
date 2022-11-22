
locals {
  default_permissions {
    noone    = []
    readonly = ["SELECT"]
    owner    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE",
                "REFERENCES", "TRIGGER", "CREATE", "CONNECT",
                "TEMPORARY", "EXECUTE", "USAGE"]
  }
  roles_definition = [
    for db_permissions in var.database_permissions_list: 
    {
      index      = "${each.value.database}-${each.value.role}"
      database   = each.value.database
      role       = each.value.role
      privileges = lookup(local.default_permissions, each.value.permission, ["SELECT"])
    }
  ]
}

resource "postgresql_grant" "databases" {
  for_each = { for permissions in local.default_permissions : permissions.index => permissions }

  database    = each.value.database
  role        = each.value.role
  object_type = "database"
  privileges  = each.value.privileges
}