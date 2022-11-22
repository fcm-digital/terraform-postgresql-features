
locals {
  roles_granted_definition = [
    for role_granted in var.roles_granted_list: 
    {
      index      = "${role_granted.role}-${role_granted.grant_role}"
      role       = role_granted.role
      grant_role = role_granted.grant_role
    }
  ]
}

resource "postgresql_grant_role" "roles" {
  for_each = { for role_granted in local.roles_granted_definition : role_granted.index => role_granted }

  role              = each.value.role
  grant_role        = each.value.role_granted
}