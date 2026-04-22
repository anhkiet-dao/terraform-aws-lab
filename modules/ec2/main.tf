# 1. Tìm kiếm AMI mới nhất của Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 2. Tạo Instance ở Public Subnet (Web Server)
resource "aws_instance" "public" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_id 
  vpc_security_group_ids = [var.public_sg]      

  key_name = "my-key"

  tags = {
    Name = "Public-Instance"
  }
}

# 3. Tạo Instance ở Private Subnet (Database/Internal Server)
resource "aws_instance" "private" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg]

  key_name = "my-key-new" 

  tags = {
    Name = "Private-Instance"
  }
}