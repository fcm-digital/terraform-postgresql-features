
output "roles_created"{
    value = values(postgresql_role.role)[*].name
}