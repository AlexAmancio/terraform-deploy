resource "azurerm_container_registry" "acr" {
  name                = "${var.env}acr"
  resource_group_name = var.rg_name
  location            = var.region_zone
  sku                 = "Standard"
  admin_enabled       = false
}

# AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.naming_convention}-aks"
  location            = var.region_zone
  resource_group_name = var.rg_name
  dns_prefix          = "${azurerm_kubernetes_cluster.aks.name}-dsdsdns"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "nodepool1"
    node_count = 1
    vm_size    = "Standard_B4ms"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  # Permite que AKS use el ACR
  depends_on = [azurerm_container_registry.acr]
}


