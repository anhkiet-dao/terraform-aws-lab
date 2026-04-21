provider "aws" {
  region = "ap-southeast-1"
}

# 1. Khởi tạo mạng cơ bản
module "vpc" {
  source = "./modules/vpc"
}

# 2. Phân chia Subnet (Cần vpc_id)
module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
}

# 3. Kết nối Internet (Cần vpc_id)
module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

# 4. NAT Gateway (Cần Public Subnet và nên đợi IGW sẵn sàng)
module "nat" {
  source        = "./modules/nat"
  public_subnet = module.subnet.public_subnet_id
  
  depends_on = [module.igw] 
}

# 5. Security Groups (Cần vpc_id)
module "security_groups" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

# 6. Định tuyến (Route Tables)
module "route_table" {
  source            = "./modules/route_table"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.igw.igw_id
  nat_id            = module.nat.nat_id
  public_subnet_id  = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
}

# 7. Triển khai Máy ảo (Sử dụng Subnet và Security Group)
module "ec2" {
  source            = "./modules/ec2"
  public_subnet_id  = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
  public_sg         = module.security_groups.public_sg
  private_sg        = module.security_groups.private_sg
}