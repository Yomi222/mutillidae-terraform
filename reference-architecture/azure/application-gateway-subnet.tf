resource "azurerm_subnet" "application-gateway-subnet" {
	name			= "${var.project-name}-application-gateway-subnet"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	virtual_network_name	= "${azurerm_virtual_network.virtual-network.name}"

	private_endpoint_network_policies_enabled	= true
	private_link_service_network_policies_enabled	= true
	address_prefixes				= ["${var.application-gateway-subnet-range}"]
}

output "application-gateway-subnet-address-prefixes" {
	value 		= "${jsonencode(azurerm_subnet.application-gateway-subnet.address_prefixes)}"
	description	= "The address prefixes for the subnet"
}

