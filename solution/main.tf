terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=3.45.0"
        }
    }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  features {}
} 

resource "azurerm_resource_group" "AKS-Cloud" {
  name = "AKS-Cloud"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "AKSCluster1" {
  name = "AKSCluster1"
  location = var.location
  resource_group_name = azurerm_resource_group.AKS-Cloud.name
  dns_prefix = "testdns1"

  default_node_pool {
    name = "default"
    node_count = 3
    vm_size = "Standard_D2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
}
