terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "backend_deployment" {
  metadata {
    name = "counter-backend-deployment"
    namespace = "default"
  }
  
  spec {
    replicas = 1
    
    selector {
      match_labels = {
        app = "counter-backend"
      }
    }
    
    template {
      metadata {
        labels = {
          app = "counter-backend"
        }
      }
      
      spec {
        container {
          name  = "fastapi-container"
          image = "vasilijed/counter-backend:latest"
          image_pull_policy = "Always"
          
          port {
            container_port = 8000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend_service" {
  metadata {
    name = "backend-service"
    namespace = "default"
  }
  
  spec {
    selector = {
      app = "counter-backend"
    }
    
    port {
      port        = 8000
      target_port = 8000
    }
    
    type = "ClusterIP"
  }
}


############################ ZA MASTER NAMESPACE ############################

# DODAJ OVO ISPOD POSTOJEĆEG KODA:

# ZA MASTER NAMESPACE
resource "kubernetes_deployment" "backend_deployment_master" {
  metadata {
    name = "counter-backend-deployment"
    namespace = "master"
  }
  
  spec {
    replicas = 1
    
    selector {
      match_labels = {
        app = "counter-backend"
      }
    }
    
    template {
      metadata {
        labels = {
          app = "counter-backend"
        }
      }
      
      spec {
        container {
          name  = "fastapi-container"
          image = "vasilijed/counter-backend:latest"
          image_pull_policy = "Always"
          
          port {
            container_port = 8000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend_service_master" {
  metadata {
    name = "backend-service"
    namespace = "master"
  }
  
  spec {
    selector = {
      app = "counter-backend"
    }
    
    port {
      port        = 8000
      target_port = 8000
    }
    
    type = "ClusterIP"
  }
}