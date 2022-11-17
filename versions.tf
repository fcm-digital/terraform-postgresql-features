terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.17.1"
    }
  }
}

provider "postgresql" {
  scheme    = "gcppostgres"
  host      = var.sqlinstance.connection_name
  username  = var.sqlinstance.username
  port      = var.sqlinstance.port
  password  = var.sqlinstance.password
  superuser = false
}