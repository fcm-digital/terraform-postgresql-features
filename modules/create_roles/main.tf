
resource "random_password" "user-password" {
  for_each = { for role in var.roles_list : role.name => role }

  keepers = {
    name = each.key
  }

  length  = var.password_length
  special = var.password_special
}

resource "postgresql_role" "role" {
  for_each = { for role in var.roles_list : role.name => role }

  name            = each.key
  superuser       = lookup(each.value, "superuser", false)
  create_database = lookup(each.value, "create_database", false)
  create_role     = lookup(each.value, "create_role", false)
  replication     = lookup(each.value, "replication", false)

  login            = lookup(each.value, "login", true)
  password         = lookup(each.value, "password", random_password.user-password[each.key].result)
  connection_limit = lookup(each.value, "connection_limit", -1)
  roles            = lookup(each.value, "roles", [])

  depends_on = [random_password.user-password]
}

resource "onepassword_item" "database_item" {
  for_each = { for role in var.roles_list : role.name => role if var.onepassword.enabled }
  vault    = var.onepassword.vault_uuid

  title    = "${var.onepassword.title}-${each.key}"
  category = "database"
  type     = "postgresql"
  
  username = each.key
  password = lookup(each.value, "password", random_password.user-password[each.key].result)
  tags     = sort(lookup(var.onepassword, "tags", ["CloudSQL", "PostgreSQL", "Terraform"]))
  depends_on = [onepassword_item.database_item]
}