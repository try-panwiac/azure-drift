provider "random" {
}

resource "random_string" "sa_name_affix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "trekgroup" {
  name     = "trekgroup-resources"
  location = "West US"
  tags = {
    git_commit           = "c381e2960e962e356ce12fc1b49073979f0cb5c1"
    git_file             = "storage.tf"
    git_last_modified_at = "2022-09-23 06:14:49"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "ffb48742-a6b3-47ec-850a-a98fe3bb62da"
  }
}

resource "azurerm_storage_account" "storagebay" {
  name                     = "storagebay${random_string.sa_name_affix.result}"
  resource_group_name      = azurerm_resource_group.trekgroup.name
  location                 = azurerm_resource_group.trekgroup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    git_commit           = "c381e2960e962e356ce12fc1b49073979f0cb5c1"
    git_file             = "storage.tf"
    git_last_modified_at = "2022-09-23 06:14:49"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "057d971b-557f-4f7c-80cd-36852844e6d3"
  }
}
