# Azure Virtual Machine and Virtual Network Deployment

This Terraform project is used to deploy a virtual machine and its corresponding virtual network on Azure.

## Prerequisites

1\. Install Terraform (v1.0.0 or higher)

2\. Install Azure CLI

3\. Log in to Azure account: `az login`

4\. Ensure SSH key pair exists at `~/.ssh/id_rsa_azure.pub`

If you don't have an SSH key pair, generate one using the following command:
```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_azure
```

## Usage

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Preview changes:
   ```
   terraform plan
   ```

3. Apply changes:
   ```
   terraform apply
   ```

4. To delete all resources:
   ```
   terraform destroy
   ```

## Customization

You can customize the configuration by editing the `variables.tf` file or by using the `-var` parameter when executing terraform commands:

```
terraform apply -var="vm_name=my-custom-vm" -var="vm_size=Standard_DS2_v2"
```

## Outputs

After deployment, you can view the outputs using the following command:

```
terraform output
```

Main outputs include:
- Virtual machine public IP
- Virtual machine private IP
- Resource group name
- Virtual network name
