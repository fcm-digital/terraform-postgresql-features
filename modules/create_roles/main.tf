locals {
  roles = { for role in var.roles_list : role.name => role }
}

resource "random_password" "user-password" {
  for_each = local.roles

  keepers = {
    name = each.key
  }

  length  = var.password_length
  special = var.password_special
}

resource "postgresql_role" "role" {
  for_each = local.roles

  name            = each.key
  superuser       = lookup(each.value, "superuser", false)
  create_database = lookup(each.value, "create_database", false)
  create_role     = lookup(each.value, "create_role", false)

  login            = lookup(each.value, "login", true)
  password         = lookup(each.value, "password", random_password.user-password[each.key].result)
  connection_limit = lookup(each.value, "connection_limit", -1)
  roles            = lookup(each.value, "roles", [])

  depends_on = [random_password.user-password]
}
