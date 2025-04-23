# Deploy free5GC on Azure Kubernetes Service
Build 5G Core Network (free5GC) on Azure platform from scratch.

![](./assets/mvp.tif)

## Project goal

This project try to leverages the free5GC and Azure to build the scalable, observable, and stable cloud-native 5GC service.
- `infra`: collects the terraform script to build the AKS stack.
- `helm`: collects all of kubernetes deployment scripts.
- `src`: collects all of dependencies.
- `docs`: technical documents.

## Requirements

1. Terraform

Use the following command to install terraform on your system:
```
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
sudo apt-get update && sudo apt-get install terraform
```

2. Azure CLI

Use the following command to install Azure CLI on your system:
```
$ curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

3. Kubectl

Use the following command to install kubectl on your system:
```
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

## Deploy the AKS cluster

To initialize the terraform script, you need to set up the Azure credentials. You can do this by running the following command:
```
$ az login
```
This will open a web browser and prompt you to log in to your Azure account. After logging in, you can select the subscription ID you want to use for the deployment. the output will look like this:
```
[Tenant and subscription selection]

No     Subscription name              Subscription ID                       Tenant
-----  -----------------------------  ------------------------------------  --------
[1] *  Azure subscription 1           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXX
[2]    MVP                            XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXX

The default is marked with an *; the default tenant is '預設目錄' and subscription is 'Azure subscription 1' (fb011f5a-45ff-42ac-a723-2cef16315eb0).

Select a subscription and tenant (Type a number or Enter for no changes):  
1
```


After selecting the subscription, you can initialize the terraform script by running the following command:
```
$ cd infra
$ terraform init -upgrade
```

Then you can run the following command to create a deployment plan for the AKS cluster:
```
$ terraform plan -out main.tfplan
```

> If you encounter the error like this during the `terraform plan` step, please refer to the [optional] section below.

If the plan looks good, you can apply the plan by running the following command:
```
$ terraform apply main.tfplan
```

This will create the AKS cluster and all the necessary resources in your Azure subscription.

After the deployment is complete, you can check the status of the AKS cluster by running the following command:
```
$ resource_group_name=$(terraform output -raw resource_group_name)
$ az aks list \
  --resource-group $resource_group_name \
  --query "[].{\"K8s cluster name\":name}" \
  --output table
----------------------
cluster-pleasing-drake
```

### [Optional] Register the resource provider
If you encounter the error like this during the `terraform plan` step:
```
╷
│ Error: Encountered an error whilst ensuring Resource Providers are registered.
│ 
│ Terraform automatically attempts to register the Azure Resource Providers it supports, to
│ ensure it is able to provision resources.
│ 
│ If you don't have permission to register Resource Providers you may wish to disable this
│ functionality by adding the following to the Provider block:
│ 
│ provider "azurerm" {
│   "resource_provider_registrations = "none"
│ }
│ 
│ Please note that if you opt out of Resource Provider Registration and Terraform tries
│ to provision a resource from a Resource Provider which is unregistered, then the errors
│ may appear misleading - for example:
│ 
│ > API version 2019-XX-XX was not found for Microsoft.Foo
│ 
│ Could suggest that the Resource Provider "Microsoft.Foo" requires registration, but
│ this could also indicate that this Azure Region doesn't support this API version.
│ 
│ More information on the "resource_provider_registrations" property can be found here:
│ https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#resource_provider_registrations
│ 
│ Encountered the following errors:
```
This error indicates that the resource provider is not registered in your Azure subscription. You can register the resource provider by running the following command:
```
$ az provider list --query "[?registrationState!='Registered'].{Provider:namespace, State:registrationState}" -o table # check the registration state
$ az provider register --namespace Microsoft.AzureTerraform
```

## Set up the kubectl

After the AKS cluster is created, you can set up the kubectl command-line tool to manage the cluster. You can do this by running the following command:
```
$ echo "$(terraform output kube_config)" > ~/azurek8s
$ export KUBECONFIG=./azurek8s
```

After setting up the kubectl, you can check the status of the AKS cluster by running the following command:
```
$ kubectl get nodes
NAME                                STATUS   ROLES    AGE     VERSION
aks-agentpool-39294390-vmss000000   Ready    <none>   9m13s   v1.31.7
aks-agentpool-39294390-vmss000001   Ready    <none>   8m16s   v1.31.7
aks-agentpool-39294390-vmss000002   Ready    <none>   9m23s   v1.31.7
```

## Deploy the free5GC

## Destroy the AKS cluster

If you want to destroy the AKS cluster and all the resources created by terraform, you can run the following command:
```
$ cd infra
$ terraform destroy
```
This will destroy the AKS cluster and all the resources created by terraform.