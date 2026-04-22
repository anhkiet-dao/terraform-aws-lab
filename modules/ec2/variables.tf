variable "public_subnet_id" {
  description = "ID của public subnet để đặt instance"
  type        = string
}

variable "private_subnet_id" {
  description = "ID của private subnet để đặt instance"
  type        = string
}

variable "public_sg" {
  description = "Security Group ID cho public instance"
  type        = string
}

variable "private_sg" {
  description = "Security Group ID cho private instance"
  type        = string
}