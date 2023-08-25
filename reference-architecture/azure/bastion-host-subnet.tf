
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "bastion-host-subnet" {
	name			= "${var.project-name}-bastion-host-subnet"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	virtual_network_name	= "${azurerm_virtual_network.virtual-network.name}"
	
	private_endpoint_network_policies_enabled	= true
	private_link_service_network_policies_enabled	= true
	address_prefixes				= ["${var.bastion-host-subnet-range}"]
}

output "bastion-host-subnet-address-prefixes" {
	value 		= "${jsonencode(azurerm_subnet.bastion-host-subnet.address_prefixes)}"
	description	= "The address prefixes for the subnet"
}

