provider "aws" {
  region = "ap-southeast-1"
}

# VPC
module "vpc" {
  source = "./modules/vpc"
}

# Subnet
module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
}

# Internet Gateway
module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

# NAT Gateway
module "nat" {
  source        = "./modules/nat"
  public_subnet = module.subnet.public_subnet_id
}

# Route Tables
module "route" {
  source              = "./modules/route"
  vpc_id              = module.vpc.vpc_id
  igw_id              = module.igw.igw_id
  nat_id              = module.nat.nat_id
  public_subnet_id    = module.subnet.public_subnet_id
  private_subnet_id   = module.subnet.private_subnet_id
}

# Security Groups
module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

# EC2
module "ec2" {
  source            = "./modules/ec2"
  public_subnet_id  = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
  public_sg         = module.sg.public_sg
  private_sg        = module.sg.private_sg
}