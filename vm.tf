variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
  tags = {
    git_commit           = "c5db2b0bb66db2078e2faa900f0fd762b839adba"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 04:36:43"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "caa147ab-67bb-4133-bcf5-62e9a5d2db10"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags = {
    git_commit           = "c5db2b0bb66db2078e2faa900f0fd762b839adba"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 04:36:43"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "271dfad8-7ae3-4f33-9cd7-15b35a09f8f6"
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    git_commit           = "c5db2b0bb66db2078e2faa900f0fd762b839adba"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 04:36:43"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "7d704815-bb07-4885-984f-eefe50410cb2"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

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
    environment          = "staging"
    git_commit           = "c5db2b0bb66db2078e2faa900f0fd762b839adba"
    git_file             = "vm.tf"
    git_last_modified_at = "2022-09-23 04:36:43"
    git_last_modified_by = "93744932+try-panwiac@users.noreply.github.com"
    git_modifiers        = "93744932+try-panwiac"
    git_org              = "try-panwiac"
    git_repo             = "azure-drift"
    yor_trace            = "7538645e-4bbe-4755-b26e-381395b0f3aa"
  }
}
