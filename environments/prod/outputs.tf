output "ecr_repository_url" { value = module.ecr.repository_url }
output "ecs_cluster_name" { value = module.ecs.cluster_name }
output "ecs_service_name" { value = module.ecs.service_name }
output "alb_dns_name" { value = module.ecs.alb_dns_name }
output "django_secret_arn" { value = aws_secretsmanager_secret.django.arn }
