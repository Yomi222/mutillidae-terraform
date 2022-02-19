resource "azurerm_subnet" "application-server-subnet" {
	name			= "${var.project-name}-application-server-subnet"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	virtual_network_name	= "${azurerm_virtual_network.virtual-network.name}"
	
	enforce_private_link_endpoint_network_policies	= true
	enforce_private_link_service_network_policies	= true
	address_prefixes				= ["10.0.2.0/28"]
}

output "application-server-subnet-id" {
	value		= "${azurerm_subnet.application-server-subnet.id}"
	description	= "The name of the subnet"
}

output "application-server-subnet-address-prefixes" {
	value 		= "${jsonencode(azurerm_subnet.application-server-subnet.address_prefixes)}"
	description	= "The address prefixes for the subnet"
}

