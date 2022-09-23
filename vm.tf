provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
  tags = {
    git_commit           = "5e27e7d0a73139c83c16e88b4f4aca0eee81319c"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 05:10:11"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "28e06169-b93a-4bac-a600-741050f66bec"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  tags = {
    git_commit           = "5e27e7d0a73139c83c16e88b4f4aca0eee81319c"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 05:10:11"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "09b3e5bc-1f6f-4957-bac4-830fe441b9d7"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "${var.prefix}-nic"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.example.id}"
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    git_commit           = "5e27e7d0a73139c83c16e88b4f4aca0eee81319c"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 05:10:11"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "a4c3d766-6241-4a90-a54f-549741e3890d"
  }
}

resource "azurerm_virtual_machine" "example" {
  name                  = "${var.prefix}-vm"
  location              = "${azurerm_resource_group.example.location}"
  resource_group_name   = "${azurerm_resource_group.example.name}"
  network_interface_ids = ["${azurerm_network_interface.example.id}"]
  vm_size               = "Standard_B1ls"

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  # This means the Data Disk Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    git_commit           = "01d58c7d8eb66d1ff644bb95dcaf495f7e0d2ba0"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 05:26:17"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "213aba02-abfb-4981-829b-f591a67f0ad4"
  }
}

variable "prefix" {
  description = "The Prefix used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which the resources in this example should exist"
}
