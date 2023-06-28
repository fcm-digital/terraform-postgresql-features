terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.17.1"
    }
    onepassword = {
      source = "1Password/onepassword"
      version = "~> 1.1.2"
    }
  }
}