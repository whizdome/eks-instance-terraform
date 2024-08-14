# EKS Cluster Setup and Management with Terraform

This README provides instructions for setting up an Amazon EKS (Elastic Kubernetes Service) cluster using Terraform, and managing it with kubectl. It includes essential commands for provisioning infrastructure, configuring kubectl, applying services, and checking the status of your cluster resources.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- Terraform (version 0.12+)
- AWS CLI
- kubectl
- An AWS account with appropriate permissions

## Provisioning EKS Cluster with Terraform

1. Clone this repository:
   ```bash
   git clone https://github.com/whizdome/eks-instance-terraform.git
   cd eks-instance-terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the Terraform plan:
   ```bash
   terraform plan
   ```

4. Apply the Terraform configuration to create the EKS cluster:
   ```bash
   terraform apply
   ```
   When prompted, type 'yes' to confirm.

5. After the apply completes successfully, Terraform will output the necessary information to configure kubectl.

## Configuring kubectl for your EKS Cluster

To configure kubectl to communicate with your newly created EKS cluster, run:

```bash
aws eks --region us-west-2 update-kubeconfig --name my-eks
```

Replace `us-west-2` with your desired AWS region and `my-eks` with the name of your EKS cluster as defined in your Terraform configuration.

## Starting the EKS Cluster

If your EKS cluster is not already running after the Terraform apply, you can start it using the AWS Management Console or AWS CLI:

Using AWS CLI:
```bash
aws eks update-cluster-config --name my-eks --region us-west-2 --resources-vpc-config endpointPublicAccess=true,endpointPrivateAccess=true
```

Replace `my-eks` with your cluster name and `us-west-2` with your region.

## Applying Services

To apply a service configuration to your cluster:

```bash
kubectl apply -f service.yaml
```

Ensure that your `service.yaml` file is in the current directory or provide the full path to the file.

## Checking Cluster Resources

### View Pods

To list all pods in the `whizdome` namespace:

```bash
kubectl get pods --namespace whizdome
```

### View Nodes

To list all nodes in the `whizdome` namespace:

```bash
kubectl get nodes --namespace whizdome
```

### View Services

To list all services in the `whizdome` namespace:

```bash
kubectl get svc -n whizdome
```

## Troubleshooting

If you encounter issues, consider the following:

1. Ensure your AWS CLI is configured with the correct credentials.
2. Verify that you have the necessary permissions in your AWS account.
3. Check that your EKS cluster is running and accessible.
4. Confirm that the `whizdome` namespace exists in your cluster.
5. If Terraform fails, check the error messages and AWS Console for more information.

## Cleaning Up

To avoid incurring unnecessary costs, remember to destroy your infrastructure when you're done:

```bash
terraform destroy
```

## Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

For more detailed information or advanced configurations, refer to the official Terraform, Amazon EKS, and Kubernetes documentation.
