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
      version = "~> 0.38.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "fastly" {

}

provider "aws" {
  region = "ap-northeast-1"
}
