# Define the Kubernetes namespace
resource "kubernetes_namespace" "kube_system" {
  metadata {
    name = "kube-system"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Define the Helm provider configuration
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
resource "helm_release" "aws_lb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.4.5"  # Replace with the specific version you want to use
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.eks.name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.lb_controller.metadata[0].name
  }

  depends_on = [
    aws_iam_role.lb_controller,
    aws_iam_role_policy_attachment.lb_controller_policy,
    kubernetes_service_account.lb_controller,
  ]
}
