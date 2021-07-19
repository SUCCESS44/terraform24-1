provider "aws" {
   region = "us-east-2"  
}

module "ec2module" {
    source = "../Modules/ec2"
    tagname = "class24"
    ami_id = "ami-00399ec92321828f5"
  
}

module "vpcmodule" {
  source = "../Modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpcname   =  "classic"
}