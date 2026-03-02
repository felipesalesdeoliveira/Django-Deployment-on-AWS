variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "ecr_repository_name" {
  type = string
}

variable "ecr_keep_last_images" {
  type    = number
  default = 20
}

variable "container_image" {
  description = "Full image URI for ECS task. Leave blank to use placeholder tag in project ECR repo."
  type        = string
  default     = ""
}

variable "container_port" {
  type    = number
  default = 8000
}

variable "task_cpu" {
  type    = number
  default = 512
}

variable "task_memory" {
  type    = number
  default = 1024
}

variable "service_desired_count" {
  type    = number
  default = 2
}

variable "service_min_capacity" {
  type    = number
  default = 2
}

variable "service_max_capacity" {
  type    = number
  default = 6
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "alb_ingress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "certificate_arn" {
  type    = string
  default = null
}

variable "django_allowed_hosts" {
  type    = string
  default = "*"
}

variable "django_debug" {
  type    = string
  default = "False"
}

variable "django_secret_key" {
  type      = string
  sensitive = true
}

variable "database_url" {
  type    = string
  default = ""
}

variable "redis_url" {
  type    = string
  default = ""
}
