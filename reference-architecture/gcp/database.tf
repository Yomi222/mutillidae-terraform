# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#activation_policy

locals {
	// These default values should work without changes
	mysql-project			= "${google_compute_network.gcp_vpc_network.project}"
	mysql-region			= "${var.region}"
	mysql-zone			= "${var.zone}"
	mysql-network-name		= "${google_compute_network.gcp_vpc_network.name}"
	mysql-network-self-link		= "${google_compute_network.gcp_vpc_network.self_link}"
	
	//Make sure these are set for this machine
	mysql-database-name		= "mutillidae"
	mysql-database-instance-name	= "${var.mutillidae-application-name}-database-instance"
	mysql-version			= "MYSQL_8_0"
	mysql-tier			= "db-f1-micro"
	mysql-activation-policy		= "ALWAYS"
	mysql-availability-type		= "ZONAL"
	mysql-disk-autoresize		= "true"
	mysql-disk-type			= "PD_HDD"
	mysql-pricing-plan		= "PER_USE"
	mysql-labels 			= "${merge(
							tomap({ 
								"purpose"	= "database",
								"asset-type"	= "database",
								"brand"		= "mysql"
							}),
							var.default-labels)
						}"
}

data "google_secret_manager_secret_version" "database_username" {
	project		= "${local.mysql-project}"
	secret 		= "${var.database-username-secret}"
	version		= "1"
}

data "google_secret_manager_secret_version" "database_password" {
	project		= "${local.mysql-project}"
	secret 		= "${var.database-password-secret}"
	version		= "1"
}

resource "google_sql_user" "mysql-account" {
	instance	= "${google_sql_database_instance.mysql.name}"
	name		= "${data.google_secret_manager_secret_version.database_username.secret_data}"
	password	= "${data.google_secret_manager_secret_version.database_password.secret_data}"
}

resource "google_sql_database_instance" "mysql" {
	project			= "${local.mysql-project}"
	name			= "${local.mysql-database-instance-name}-${random_pet.random_suffix.id}"
	region 			= "${local.mysql-region}"
	database_version	= "${local.mysql-version}"
	deletion_protection	= "false"
	depends_on       	= [google_service_networking_connection.private_vpc_connection]

	settings {
		tier 			= "${local.mysql-tier}"
		activation_policy	= "${local.mysql-activation-policy}"
		availability_type	= "${local.mysql-availability-type}"
		disk_autoresize		= "${local.mysql-disk-autoresize}"
		disk_type		= "${local.mysql-disk-type}"
		pricing_plan		= "${local.mysql-pricing-plan}"
		user_labels		= "${local.mysql-labels}"
		
		ip_configuration {
			private_network	= "${local.mysql-network-self-link}"
			ipv4_enabled	= "false"
			require_ssl	= "false"
		}
		
		location_preference {
			zone	= "${local.mysql-zone}"
		}	
	}
}

output "mysql-connection-name" {
	value 		= "${google_sql_database_instance.mysql.connection_name}"
	description	= "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy"
}

output "mysql-ipaddress-type" {
	value 		= "${google_sql_database_instance.mysql.ip_address.0.type}"
	description	= "The type of this IP address"
}

output "mysql-ip-address" {
	value 		= "${google_sql_database_instance.mysql.ip_address.0.ip_address}"
	description	= "The IPv4 address assigned"
}

output "mysql-public-ip-address" {
	value 		= "${google_sql_database_instance.mysql.public_ip_address}"
	description	= "The first public (PRIMARY) IPv4 address assigned"
}

output "mysql-private-ip-address" {
	value 		= "${google_sql_database_instance.mysql.private_ip_address}"
	description	= "The first private (PRIVATE) IPv4 address assigned"
}

