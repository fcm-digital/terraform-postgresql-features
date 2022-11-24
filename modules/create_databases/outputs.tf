
output "databases_created"{
    value = values(postgresql_database.db)[*].name
}