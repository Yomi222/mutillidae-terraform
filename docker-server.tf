
locals {
	docker-host-project		= "${google_compute_network.gcp_vpc_network.project}"
	docker-host-region		= "${var.region}"
	docker-host-zone		= "${var.zone}"
	docker-host-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	docker-host-subnetwork-name	= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.name}"
	docker-host-ssh-username	= "${var.gcp-ssh-username}"
	docker-host-ssh-public-key-file	= "${var.gcp-ssh-public-key-file}"
	
	//Make sure these are set for this machine
	docker-host-vm-name		= "docker-host-vm-t"
	docker-host-network-ip		= "10.0.0.5"
	docker-host-disk-size-gb	= 25 //GB
	docker-host-description		= "A docker server to run containers on the ${local.docker-host-subnetwork-name} subnet"

}

resource "google_compute_instance" "gcp_instance_docker_host" {
	project				= "${local.docker-host-project}"
	zone				= "${local.docker-host-zone}"
	name				= "${local.docker-host-vm-name}"
	description			= "${local.docker-host-description}"
	machine_type			= "e2-small"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = ["docker-host","web-server"]
	labels = {
		"purpose"	= "application-server"
		"owner"		= "jeremy-druin"
		"asset-type"	= "virtual-machine"
	}
	boot_disk {
		auto_delete	= true
		device_name	= "${local.docker-host-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.docker-host-disk-size-gb
			type	= "pd-standard"
			image	= "debian-cloud/debian-11"
		}
	}
	network_interface {
		network 		= "${local.docker-host-network-name}"
		subnetwork 		= "${local.docker-host-subnetwork-name}"
		subnetwork_project 	= "${local.docker-host-project}"
		network_ip		= "${local.docker-host-network-ip}"
		stack_type		= "IPV4_ONLY"
	}
	shielded_instance_config {
		enable_secure_boot		= true
		enable_vtpm			= true
		enable_integrity_monitoring	= true
	}
	metadata = {
		ssh-keys = "${local.docker-host-ssh-username}:${file(local.docker-host-ssh-public-key-file)}"
		startup-script	= "#! /bin/bash\n# Google runs these commands as root user\napt update\napt upgrade -y"
 	}
} // end resource "google_compute_instance" "gcp_instance_docker_host"


