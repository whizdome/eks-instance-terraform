# Define a custom Kubernetes namespace
resource "kubernetes_namespace" "custom_lb_controller" {
  metadata {
    name = "custom-namespace"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Define the Kubernetes service account in the custom namespace
resource "kubernetes_service_account" "lb_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = kubernetes_namespace.custom_lb_controller.metadata[0].name
    labels = {
      app = "load-balancer-controller"
    }
  }

  automount_service_account_token = true

  lifecycle {
    prevent_destroy = false
  }
}
