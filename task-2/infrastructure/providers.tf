terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.32.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.3"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.1.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

provider "tls" {

}

provider "local" {

}

provider "http" {

}

provider "null" {

}
