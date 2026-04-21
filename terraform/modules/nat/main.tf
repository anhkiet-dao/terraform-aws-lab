variable "public_subnet" {}

resource "aws_eip" "eip" {}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.public_subnet
}

output "nat_id" {
  value = aws_nat_gateway.nat.id
}