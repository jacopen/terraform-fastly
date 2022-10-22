terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kusama"

    workspaces {
      name = "terraform-fastly"
    }
  }
  required_providers {
    fastly = {
      source = "fastly/fastly"
      version = "~> 2.4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36.0"
    }
  }
}

provider "fastly" {

}

provider "aws" {
  region = "ap-northeast-1"
}
