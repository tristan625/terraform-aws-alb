# Shree Ganeshayah Namah

variable "alb_name" {
  type        = string
  description = "Name of the Alb being created"
}

variable "alb_subnets" {
  type        = list(string)
  description = "Public subnets to place this alb in"
}

variable "alb_sgs" {
  type        = list(string)
  description = "Security Group(s) to apply to this alb"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the certificate as available in aws certificate manager"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "app_port" {
  type        = number
  description = "Port of the application in other words the port on which the application is running/listening"
}

variable "instances_to_attach" {
  type        = list(string)
  default     = []
  description = "Instances to attach to the target group"
}

variable "tg_name" {
  type = string
  default = "v2-tg"
  description = "Target Group Name, this needs to unique in AWS"
}