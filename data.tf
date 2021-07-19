provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "class2vpc" {
  filter {
      name = "tag:Name"
      values = ["prod"]
  }
}

output "myvpc" {
  value = data.aws_vpc.class2vpc.id
}

resource "aws_subnet" "class2sub" {
  cidr_block = "10.0.1.0/24"
  vpc_id = data.aws_vpc.class2vpc.id
}

data "aws_ami" "myami" {
  most_recent = true
  owners = ["amazon"]

  filter {
      name    = "name"
      values   = ["amzn2-ami-hvm-*-gp2"]
  }
}

output "myamis" {
  value = data.aws_ami.myami.id
}

resource "aws_instance" "class2ec2" {
  for_each = {
    prod = "t2.medium"
    dev = "t2.micro" 
  }
  ami = data.aws_ami.myami.id
  instance_type = each.value
  subnet_id = aws_subnet.class2sub.id

  tags = {
    Name = "class2 ${each.key}"
  }
}