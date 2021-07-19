resource "aws_vpc" "landmark1" {
  cidr_block = var.cidr_block

  tags = {
      Name = var.vpcname
  }
}
