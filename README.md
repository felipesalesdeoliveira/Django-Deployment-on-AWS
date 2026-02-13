# 🚀 Django Deployment on AWS  
## Complete ECS & ECR DevOps Pipeline

![AWS](arquitetura_project-04.png)

---

## 📌 Sobre o Projeto

Este projeto demonstra o deploy completo de uma aplicação Django em ambiente de produção utilizando Amazon ECS e Amazon ECR.

A solução cobre todo o pipeline DevOps: containerização, versionamento de imagens, publicação em registry seguro, orquestração com containers, auto scaling, load balancing, observabilidade e hardening de segurança.

O objetivo é apresentar uma arquitetura moderna, escalável e preparada para produção em cloud.

---

# 🎯 Objetivo Técnico

Implementar uma pipeline de deploy containerizada com:

- Docker para empacotamento da aplicação
- Amazon ECR para armazenamento seguro das imagens
- Amazon ECS (Fargate) para orquestração serverless
- Application Load Balancer para distribuição de tráfego
- Auto Scaling baseado em métricas
- Monitoramento via CloudWatch
- Segurança com IAM, Security Groups e Secrets Management

---

# 🏗️ Arquitetura da Solução

Aplicação Django containerizada →  
Imagem armazenada no ECR →  
Deploy via ECS Fargate →  
Exposta por Application Load Balancer →  
Escalável automaticamente →  
Monitorada via CloudWatch

Arquitetura preparada para:

✔ Alta disponibilidade  
✔ Escalabilidade horizontal  
✔ Segurança em múltiplas camadas  
✔ Observabilidade  
✔ Otimização de custos  

---

# 🐍 Aplicação Web – Django

Django é um framework web Python robusto, orientado à segurança e produtividade.

## Considerações para Produção

- Uso de settings separados (development vs production)
- Desativação de DEBUG
- Armazenamento de estáticos via S3 + CloudFront
- Banco de dados gerenciado (RDS PostgreSQL)
- Uso de Redis/ElastiCache para cache
- Secrets armazenados no AWS Secrets Manager

---

# 🐳 Containerização com Docker

![Docker](https://imgur.com/raGErLx.png)

## Estratégia de Container

- Multi-stage builds
- Base image oficial Python slim
- Execução com usuário não-root
- Layer caching otimizado
- Minimização de dependências desnecessárias

## Benefícios

✔ Portabilidade  
✔ Consistência entre ambientes  
✔ Facilidade de rollback  
✔ Escalabilidade horizontal  
✔ Isolamento de runtime  

---

# 📦 Amazon ECR – Container Registry

Amazon ECR é utilizado como registry privado para armazenar imagens Docker com:

- Image scanning habilitado
- IAM integration
- Lifecycle policies
- Versionamento de imagens

## Fluxo

1. Build da imagem localmente  
2. Autenticação via AWS CLI  
3. Tag da imagem com URI do ECR  
4. Push para o registry  
5. Deploy via ECS  

Lifecycle policies garantem limpeza automática de imagens antigas.

---

# 🚀 Amazon ECS – Orquestração

Deploy realizado utilizando ECS Fargate (serverless containers).

## Componentes Criados

### 🔹 ECS Cluster
Ambiente lógico onde as tasks são executadas.

### 🔹 Task Definition
Define:

- CPU e memória
- Container image (ECR)
- Port mappings
- Variáveis de ambiente
- Configuração de logs
- Health checks

### 🔹 Service
Mantém número desejado de containers rodando continuamente.

### 🔹 Application Load Balancer
- Distribui tráfego
- Realiza health checks
- Integra com Auto Scaling

---

# 🔄 Auto Scaling

Configuração baseada em:

- CPU Utilization
- Memory Utilization
- Target tracking policies

Capacidade mínima e máxima configuradas para garantir elasticidade sob carga variável.

---

# 🔐 Segurança Implementada

## Container Security
- Execução como usuário não-root
- Scan automático de vulnerabilidades no ECR
- Resource limits configurados

## Infraestrutura
- IAM Roles com princípio de menor privilégio
- Security Groups restritivos
- Deploy em VPC isolada
- Comunicação interna privada

## Django Hardening
```python
SECURE_SSL_REDIRECT = True
SECURE_HSTS_SECONDS = 31536000
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
X_FRAME_OPTIONS = "DENY"
```

---

# 📊 Monitoramento & Observabilidade

## CloudWatch Logs
- Logs centralizados por container
- Stream prefix por task
- Integração automática via awslogs driver

## Métricas Monitoradas

- CPU
- Memória
- Request latency
- Health check failures
- Container restarts

---

# 💰 Otimização de Custos

✔ Uso de Fargate para evitar gerenciamento de EC2  
✔ Auto Scaling para evitar overprovisioning  
✔ Lifecycle policies no ECR  
✔ Containers otimizados e leves  
✔ Possibilidade de Fargate Spot para workloads não críticos  

---

# 🛠️ Troubleshooting Estratégico

Problemas comuns analisados via:

- CloudWatch Logs
- Describe-tasks
- ECS Exec
- Verificação de Security Groups
- Revisão de resource limits

---

# 🔄 Alternativas Arquiteturais

## Elastic Beanstalk
Deploy simplificado, menor controle.

## EKS (Kubernetes)
Maior complexidade, ideal para microservices.

## App Runner
Opção simplificada para containers sem necessidade de cluster.

---

# 📈 Resultados Técnicos

✔ Pipeline DevOps completo  
✔ Deploy containerizado e versionado  
✔ Orquestração serverless  
✔ Alta disponibilidade  
✔ Monitoramento centralizado  
✔ Segurança em múltiplas camadas  
✔ Arquitetura pronta para produção  

---

# 📚 Aprendizados Aplicados

- Containerização profissional
- Registry management com políticas de retenção
- Orquestração com ECS
- Deploy escalável em cloud
- Segurança em aplicações web
- Observabilidade distribuída
- Design de arquitetura cloud-native

---

# ✅ Checklist Pós-Deploy

- [ ] SSL configurado
- [ ] DEBUG desativado
- [ ] Logs verificados
- [ ] Auto Scaling validado
- [ ] Backups configurados
- [ ] Secrets protegidos
- [ ] Resource limits revisados

---

# ⭐ Se este projeto foi útil

Considere:

- Dar uma estrela ⭐
- Compartilhar com sua rede
- Adaptar para seu portfólio
- Expandir para arquitetura multi-region

---

> Arquitetura moderna, escalável e segura para aplicações Django em ambiente AWS.
