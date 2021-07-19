terraform {
  backend "s3" {
    bucket = "class24landmarkteck1"
    key    = "prod/tfstate/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "us-west-1"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
   name = "terraform-lock"
   hash_key = "LockID"
   read_capacity = 3
   write_capacity = 3

   attribute {
      name = "LockID"
      type = "S"
   }
}
provider "aws" {
   region = "us-east-2"  
}

provider "aws" {
  alias = "west"
  region = "us-west-1"
}
module "ec2module" {
    source = "../Modules/ec2"
    ami_id = "ami-006a915cc6aeb0880"
    providers = {
      aws = aws.west 
     }
    tagname = "classtag"
  
}

module "vpcmodule" {
  source = "../Modules/vpc"
  cidr_block = "192.168.0.0/16"
  providers = {
      aws = aws.west 
     }
  vpcname   =  "classic"
}