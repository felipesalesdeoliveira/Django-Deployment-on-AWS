data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs  = slice(data.aws_availability_zones.available.names, 0, 2)
  name = "${var.project_name}-${var.environment}"
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "network" {
  source = "../../modules/network"

  name                 = local.name
  cidr_block           = var.vpc_cidr
  azs                  = local.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  single_nat_gateway   = var.single_nat_gateway
  tags                 = local.tags
}

module "ecr" {
  source = "../../modules/ecr"

  name             = var.ecr_repository_name
  keep_last_images = var.ecr_keep_last_images
  tags             = local.tags
}

resource "aws_secretsmanager_secret" "django" {
  name        = "${local.name}/django"
  description = "Django application secrets"
  tags        = local.tags
}

resource "aws_secretsmanager_secret_version" "django" {
  secret_id = aws_secretsmanager_secret.django.id
  secret_string = jsonencode({
    DJANGO_SECRET_KEY = var.django_secret_key
    DATABASE_URL      = var.database_url
    REDIS_URL         = var.redis_url
  })
}

module "ecs" {
  source = "../../modules/ecs"

  name               = local.name
  aws_region         = var.aws_region
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids

  container_image = var.container_image != "" ? var.container_image : "${module.ecr.repository_url}:latest"
  container_port  = var.container_port
  cpu             = var.task_cpu
  memory          = var.task_memory

  desired_count = var.service_desired_count
  min_capacity  = var.service_min_capacity
  max_capacity  = var.service_max_capacity

  health_check_path = var.health_check_path
  alb_ingress_cidrs = var.alb_ingress_cidrs
  certificate_arn   = var.certificate_arn

  environment_variables = {
    DJANGO_DEBUG         = var.django_debug
    DJANGO_ALLOWED_HOSTS = var.django_allowed_hosts
  }

  secret_arns = {
    DJANGO_SECRET_KEY = "${aws_secretsmanager_secret.django.arn}:DJANGO_SECRET_KEY::"
    DATABASE_URL      = "${aws_secretsmanager_secret.django.arn}:DATABASE_URL::"
    REDIS_URL         = "${aws_secretsmanager_secret.django.arn}:REDIS_URL::"
  }

  tags = local.tags
}
