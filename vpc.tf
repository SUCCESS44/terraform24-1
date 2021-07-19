provider "aws" {
  region     = "ca-central-1"
}
#vpc.tf 
resource "aws_vpc" "vpc24" {
    cidr_block = "10.10.0.0/20"
    tags = {
        Name = "myvpc24"
        Environment = "dev"
   }
}
#ec2.tf
resource "aws_instance" "appserver1" {
    ami = "xxxx"
    instance_type = "t2.micro"
    key_name      ="key"
    tags = {
        Name = "dbserver"
        Environment = "dev"
    }
}    
resource "aws_s3_bucket" "mys3" {
  bucket = "class24b"
  acl    = "private"

  tags = {
    Name        = "class24xyz"
    Environment = "Dev"
  }
}

        
