output "roles_created" {
  value = values(postgresql_role.role)[*].name
}

output "roles_password" {
  value     = values(random_password.user-password)[*].result
  sensitive = true
}
