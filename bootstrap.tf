variable "enable_gitops_bridge_bootstrap" {
  description = "Enable GitOps Bridge Bootstrap"
  type        = bool
  default     = false
}

variable "addons" {
  description = "Kubernetes addons"
  type        = any
  default = {
    enable_cert_manager                          = false
    enable_aws_efs_csi_driver                    = false
    enable_aws_fsx_csi_driver                    = false
    enable_aws_cloudwatch_metrics                = false
    enable_aws_privateca_issuer                  = false
    enable_cluster_autoscaler                    = false
    enable_external_dns                          = false
    enable_external_secrets                      = false
    enable_aws_load_balancer_controller          = false
    enable_aws_for_fluentbit                     = false
    enable_aws_node_termination_handler          = false
    enable_karpenter                             = false
    enable_velero                                = false
    enable_aws_gateway_api_controller            = false
    enable_aws_ebs_csi_resources                 = false # generate gp2 and gp3 storage classes for ebs-csi
    enable_aws_secrets_store_csi_driver_provider = false
    enable_argo_rollouts                         = false
    enable_argo_workflows                        = false
    enable_gpu_operator                          = false
    enable_kube_prometheus_stack                 = false
    enable_metrics_server                        = false
    enable_prometheus_adapter                    = false
    enable_secrets_store_csi_driver              = false
    enable_vpa                                   = false
    enable_foo                                   = false # you can add any addon here, make sure to update the gitops repo with the corresponding application set
  }
}
# Addons Git
variable "gitops_addons_org" {
  description = "Git repository org/user contains for addons"
  type        = string
  default     = "https://github.com/d3vb0ox"
}
variable "gitops_addons_repo" {
  description = "Git repository contains for addons"
  type        = string
  default     = "terraform-aws-eks"
}
variable "gitops_addons_revision" {
  description = "Git repository revision/branch/ref for addons"
  type        = string
  default     = "main"
}
variable "gitops_addons_basepath" {
  description = "Git repository base path for addons"
  type        = string
  default     = ""
}
variable "gitops_addons_path" {
  description = "Git repository path for addons"
  type        = string
  default     = "addons/appsets"
}


locals {
  name        = var.cluster_name
  environment = "prod"
  region      = data.aws_region.current.name

  cluster_version = var.cluster_version


  gitops_addons_url      = "${var.gitops_addons_org}/${var.gitops_addons_repo}"
  gitops_addons_basepath = var.gitops_addons_basepath
  gitops_addons_path     = var.gitops_addons_path
  gitops_addons_revision = var.gitops_addons_revision

  aws_addons = {
    enable_cert_manager                          = try(var.addons.enable_cert_manager, false)
    enable_aws_efs_csi_driver                    = try(var.addons.enable_aws_efs_csi_driver, false)
    enable_aws_fsx_csi_driver                    = try(var.addons.enable_aws_fsx_csi_driver, false)
    enable_aws_cloudwatch_metrics                = try(var.addons.enable_aws_cloudwatch_metrics, false)
    enable_aws_privateca_issuer                  = try(var.addons.enable_aws_privateca_issuer, false)
    enable_cluster_autoscaler                    = try(var.addons.enable_cluster_autoscaler, false)
    enable_external_dns                          = try(var.addons.enable_external_dns, false)
    enable_external_secrets                      = try(var.addons.enable_external_secrets, false)
    enable_aws_load_balancer_controller          = try(var.addons.enable_aws_load_balancer_controller, false)
    enable_fargate_fluentbit                     = try(var.addons.enable_fargate_fluentbit, false)
    enable_aws_for_fluentbit                     = try(var.addons.enable_aws_for_fluentbit, false)
    enable_aws_node_termination_handler          = try(var.addons.enable_aws_node_termination_handler, false)
    enable_karpenter                             = try(var.addons.enable_karpenter, false)
    enable_velero                                = try(var.addons.enable_velero, false)
    enable_aws_gateway_api_controller            = try(var.addons.enable_aws_gateway_api_controller, false)
    enable_aws_ebs_csi_resources                 = try(var.addons.enable_aws_ebs_csi_resources, false)
    enable_aws_secrets_store_csi_driver_provider = try(var.addons.enable_aws_secrets_store_csi_driver_provider, false)
    enable_ack_apigatewayv2                      = try(var.addons.enable_ack_apigatewayv2, false)
    enable_ack_dynamodb                          = try(var.addons.enable_ack_dynamodb, false)
    enable_ack_s3                                = try(var.addons.enable_ack_s3, false)
    enable_ack_rds                               = try(var.addons.enable_ack_rds, false)
    enable_ack_prometheusservice                 = try(var.addons.enable_ack_prometheusservice, false)
    enable_ack_emrcontainers                     = try(var.addons.enable_ack_emrcontainers, false)
    enable_ack_sfn                               = try(var.addons.enable_ack_sfn, false)
    enable_ack_eventbridge                       = try(var.addons.enable_ack_eventbridge, false)
    enable_aws_argocd_ingress                    = try(var.addons.enable_aws_argocd_ingress, false)
  }
  oss_addons = {
    enable_argocd                          = try(var.addons.enable_argocd, false)
    enable_argo_rollouts                   = try(var.addons.enable_argo_rollouts, false)
    enable_argo_events                     = try(var.addons.enable_argo_events, false)
    enable_argo_workflows                  = try(var.addons.enable_argo_workflows, false)
    enable_cluster_proportional_autoscaler = try(var.addons.enable_cluster_proportional_autoscaler, false)
    enable_gatekeeper                      = try(var.addons.enable_gatekeeper, false)
    enable_gpu_operator                    = try(var.addons.enable_gpu_operator, false)
    enable_ingress_nginx                   = try(var.addons.enable_ingress_nginx, false)
    enable_keda                            = try(var.addons.enable_keda, false)
    enable_kyverno                         = try(var.addons.enable_kyverno, false)
    enable_kube_prometheus_stack           = try(var.addons.enable_kube_prometheus_stack, false)
    enable_metrics_server                  = try(var.addons.enable_metrics_server, false)
    enable_prometheus_adapter              = try(var.addons.enable_prometheus_adapter, false)
    enable_secrets_store_csi_driver        = try(var.addons.enable_secrets_store_csi_driver, false)
    enable_vpa                             = try(var.addons.enable_vpa, false)
  }
  addons = merge(
    local.aws_addons,
    local.oss_addons,
    { kubernetes_version = local.cluster_version },
    { aws_cluster_name = module.eks.cluster_name }
  )

  addons_metadata = merge(
    module.eks_blueprints_addons.gitops_metadata,
    {
      aws_cluster_name = module.eks.cluster_name
      aws_region       = local.region
      aws_account_id   = data.aws_caller_identity.current.account_id
      aws_vpc_id       = var.vpc_id
    },
    {
      # Required for external dns addon
      external_dns_domain_filters = "example.com"
    },
    {
      addons_repo_url      = local.gitops_addons_url
      addons_repo_basepath = local.gitops_addons_basepath
      addons_repo_path     = local.gitops_addons_path
      addons_repo_revision = local.gitops_addons_revision
    },
    {
      cert_manager_chart_version = try(var.cert_manager_helm_config.chart_version, null)
    }
  )
  #     try(local.aws_addons.enable_velero, false) ? {
  #       velero_backup_s3_bucket_prefix = try(local.velero_backup_s3_bucket_prefix, "")
  #     velero_backup_s3_bucket_name = try(local.velero_backup_s3_bucket_name, "") } : {} # Required when enabling addon velero
  #   )

  argocd_apps = {
    addons = file("${path.module}/bootstrap/addons.yaml")
    #     workloads = file("${path.module}/bootstrap/workloads.yaml")
  }

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/gitops-bridge-dev/gitops-bridge"
  }

  #   velero_backup_s3_bucket        = try(split(":", module.velero_backup_s3_bucket.s3_bucket_arn), [])
  #   velero_backup_s3_bucket_name   = try(local.velero_backup_s3_bucket[5], "")
  #   velero_backup_s3_bucket_prefix = "backups"
}


################################################################################
# GitOps Bridge: Bootstrap
################################################################################
module "gitops_bridge_bootstrap" {
  count  = var.enable_gitops_bridge_bootstrap ? 1 : 0
  source = "gitops-bridge-dev/gitops-bridge/helm"

  cluster = {
    cluster_name = module.eks.cluster_name
    environment  = local.environment
    metadata     = local.addons_metadata
    addons       = local.addons
  }
  argocd = {
    chart_version = "7.6.10"
    values = [
      <<-EOT
    global:
      nodeSelector:
        ${jsonencode(var.critical_addons_node_selector)}
      tolerations:
        ${jsonencode(var.critical_addons_node_tolerations)}
    EOT
    ]
  }
  apps = local.argocd_apps
}


################################################################################
# EKS Blueprints Addons
################################################################################
variable "cert_manager_helm_config" {
  default = {}
}
module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  # Using GitOps Bridge
  create_kubernetes_resources = false

  # EKS Blueprints Addons

  ## Cert Manager
  enable_cert_manager = local.aws_addons.enable_cert_manager
  cert_manager        = var.cert_manager_helm_config

  tags = local.tags
}
