terraform {
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
