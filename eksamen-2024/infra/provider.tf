terraform {
  required_version = ">= 1.9"

  # Konfigurer backend for å lagre Terraform state i S3-bucketen "pgr301-2024-terraform-state"
  backend "s3" {
    bucket = "pgr301-2024-terraform-state"  # Navn på den eksisterende S3-bucketen
    key    = "36/terraform.tfstate" # Sti innenfor bucketen for å lagre state-filen
    region = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
