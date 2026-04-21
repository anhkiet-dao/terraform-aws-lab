output "vpc_id" {
  description = "ID của VPC vừa tạo"
  value       = module.vpc.vpc_id
}

output "public_instance_ip" {
  description = "IP để bạn SSH vào máy Public"
  value       = module.ec2.public_instance_ip
}

output "private_instance_ip" {
  description = "IP nội bộ của máy Private"
  value       = module.ec2.private_instance_ip
}