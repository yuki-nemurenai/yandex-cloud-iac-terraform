# Yandex Cloud Infrastructure CI/CD based on Gitlab and Terraform
## Overview of Infrastructure Elements:
- Managed Service for Kubernetes (regional cluster)
- Managed Service for Redis (has not been sharded yet...)
- Yandex Managed Service for PostgreSQL (High-Availability (HA) PostgreSQL Cluster)
- VPC Network and subnets
- VPC Rules
- Helm post-deploy tasks: install NGINX Ingress Controller and Cert Manager to existing k8s cluster
## Gitlab CI/CD variables: 
| Variables               | Description                                            |
|-------------------------|--------------------------------------------------------|
| K8S_CLUSTER_NAME        |variable for accessing the k8s cluster in the pipeline  |
| TF_VAR_folder_id        |sensetive Yandex Cloud Folder ID value                  |
| TF_VAR_psql_db_password |sensetive PostgreSQL password value                     |
| TF_VAR_redis_password   |sensetive Redis password value                          |
| TOKEN                   |GitLab Personal Access Token (to use Gitlab state file) |
| USERNAME                |GitLab Username (to use Gitlab state file)              |
| YC_CLOUD_ID             |Yandex CLoud credenatials (yc config get cloud-id)      |
| YC_FOLDER_ID            |Yandex CLoud credenatials (yc config get folder-id)     |
| YC_TOKEN                |Yandex CLoud credenatials (yc config get token)         |
