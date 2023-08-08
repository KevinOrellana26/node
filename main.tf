variable "namespace" {
  default = "aplicaciones-comunes"
  type    = string
}



/////////////////// Provider
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.21.1"
    }
  }
}

provider "kubernetes" {
}

provider "aws" {
}

//////////////////// Namespace
# resource "kubernetes_namespace" "default" {
#   metadata {
#     name = var.namespace
#   }
# }

//////////////////// Deployment
resource "kubernetes_deployment" "node_deploy" {
  # depends_on = [
  #   kubernetes_namespace.default
  # ]
  metadata {
    name      = "node"
    namespace = var.namespace
  }
  spec {
    selector {
      match_labels = {
        app = "node"
      }
    }
    replicas = 1
    template {
      metadata {
        labels = {
          app = "node"
        }
      }
      spec {
        container {
          name  = "node"
          image = "kevinorellana/node:v1"
          port {
            container_port = 8888
          }
          image_pull_policy = "Always"
        }
      }
    }
  }
}

//////////////////// Service
resource "kubernetes_manifest" "node_service" {
  # depends_on = [
  #   kubernetes_namespace.default,
  # ]
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/node-service.tpl.yaml",
    {
      "namespace" = var.namespace
    }
  ))
}

//////////////////// Ingress
resource "kubernetes_manifest" "node_ingress" {
  # depends_on = [
  #   kubernetes_namespace.default,
  # ]
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/node-ingress.tpl.yaml",
    {
      "namespace" = var.namespace
    }
  ))
}