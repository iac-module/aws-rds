terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.39.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}
