# demo instance
resource "azurerm_virtual_machine" "demo-instance" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.demo.name
  network_interface_ids = [azurerm_network_interface.demo-instance.id]
  vm_size               = "Standard_A1_v2"

  # this is a demo instance, so we can delete all data on termination
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.prefix
    admin_username = var.vmuser
    #admin_password = "..."
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      #key_data = file("id_rsa_tfazurevm.pub")
      #path     = "/home/demo/.ssh/authorized_keys"
      
      key_data = file("azurevmkey.pub")
      path     = "/home/${var.vmuser}/.ssh/authorized_keys"
    }
  }
}

resource "azurerm_network_interface" "demo-instance" {
  name                      = "${var.prefix}-network-interface"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.demo.name

  ip_configuration {
    name                          = "instance1"
    subnet_id                     = azurerm_subnet.demo-internal-1.id #azurerm_subnet.demo-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.demo-instance.id
  }
}

resource "azurerm_network_interface_security_group_association" "allow-ssh" {
  network_interface_id      = azurerm_network_interface.demo-instance.id
  network_security_group_id = azurerm_network_security_group.allow-ssh.id
}

resource "azurerm_public_ip" "demo-instance" {
    name                         = "${var.prefix}-public-ip"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.demo.name
    allocation_method            = "Dynamic"
}