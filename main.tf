# Modulo de explicacion 1.0


# Declaración de la version, de esta forma garantizamos que nuestro codigo
# se desplegado en una versión de Terraform igual o mayor a la de nuestra
# configuración
terraform {
    # Version de Terraform
    required_version = ">= 1.0"
    
    # Proveedores agregados
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "2.67.0"
        }
  }
}

provider "azurerm" {
   features {}
  }

locals {
  location =  "West US"
  bname = "test" 
  name_dev={
    name01="uno"
    name02="dos"
    name01="tres"
  }
  min_number = 3
  req_number = 2

}

resource "azurerm_resource_group" "deleteme" {
  count = 3
  name = "deleteme-resource-group${count.index}"
  location = "${local.location}"
  tags = {
    "environment"="development"
  }
}

resource "azurerm_resource_group" "killme" {
  for_each = local.name_dev
  name = "kill-${each.value}"
  depends_on = [ azurerm_resource_group.deleteme ]
  location = local.location
  tags = { dependency = "azurerm_resource_group.deleteme" }
}

resource "azurerm_resource_group" "downme" {
  depends_on = [ azurerm_resource_group.deleteme, azurerm_resource_group.killme ]
  count = local.req_number > local.min_number ? local.req_number : local.min_number
  name = "downme-resource-group-${count.index}"
  location = local.location
  tags = { dependency = "azurerm_resource_group.deleteme" }
}

# Resource  group of the proyect

resource "azurerm_resource_group" "Master" {
  name = "${var.project_name}_master_${var.project_code}"
  location =  local.location
}

resource "azurerm_resource_group" "Slave" {
  name = "${var.project_name}_slave_${var.project_code}"
  location =  local.location
}

locals {
  cities=["tijuana","tecate","rosarito"]
  mayus=[for i in local.cities: upper(i)]
}

locals {
  departments=["Admin", "Sales", "Support"]
}

output "upper_cities" {
  value = local.mayus
}

output "domains" {
  
  value = [for i in local.cities: [for j in local.departments:"${j}.${i}"]]
}




