 terraform {
    cloud {
    organization = "Emmanuel"

    workspaces {
      name = "terra-house-1"
    }
  }
  required_providers {
  
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }

  }

}