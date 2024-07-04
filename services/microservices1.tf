resource "kubernetes_deployment" "microservice1" {
  metadata {
    name = "microservice1"
    labels = {
      app = "microservice1"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "microservice1"
      }
    }

    template {
      metadata {
        labels = {
          app = "microservice1"
        }
      }

      spec {
        container {
          image = "myrepo/microservice1:latest"
          name  = "microservice1"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "microservice1" {
  metadata {
    name = "microservice1"
  }

  spec {
    selector = {
      app = "microservice1"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}