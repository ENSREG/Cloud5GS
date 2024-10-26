# Deploy AKS by using Terraform

## Terraform

Terrform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

To describe the target infrastructure, Terraform uses a high-level configuration language called HashiCorp Configuration Language (HCL). HCL is a declarative language that can be used to describe the desired state of the infrastructure.

For example, the following code snippet is a simple Terraform configuration file that creates a single Azure Kubernetes Service (AKS) cluster:

```hcl
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D3_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}
```

All of the variables in the above code snippet are defined in the `variables.tf` file. The `variables.tf` file is used to define the input variables for the Terraform configuration.

After defining the Terraform configuration, you can run the `terraform init`, `terraform plan`, and `terraform apply` commands to create the AKS cluster.

```sh
terraform init -upgrade
terraform plan -out main.tfplan # this command will generate the blueprint of the infrastructure
terraform apply main.tfplan
```


To see the output of the Terraform configuration, you can use the `terraform output` command. For example, to get the name of the resource group, you can run the following command:
```sh
resource_group_name=$(terraform output -raw resource_group_name)
```

After that, you can use the azure cli to inspect the created resources:
```sh
az aks list \
  --resource-group $resource_group_name \
  --query "[].{\"K8s cluster name\":name}" \
  --output table
```

### Work with the kubectl

You can use the `terraform output` command to get the kubeconfig file and use it to interact with the AKS cluster.

```sh
echo "$(terraform output kube_config)" > ./azurek8s
export KUBECONFIG=./azurek8s
kubectl get nodes
```

### Clean up

To clean up the resources created by Terraform, you can run the `terraform destroy` command.
```sh
terraform destroy
```

## References
- [Microsoft learn](https://learn.microsoft.com/zh-tw/azure/aks/learn/quick-kubernetes-deploy-terraform?pivots=development-environment-azure-cli)