

# Installation Instructions for the Google Cloud lab environment

## Dependencies for the Google Cloud lab environment

1. ### An operating system to install the needed software

	a. If VirtualBox is not installed, [**install VirtualBox**](https://www.youtube.com/watch?v=61GhP8DsQMw).
	b. If you would like to use an Ubuntu virtual machine, [**install Ubuntu on VirtualBox**](https://www.youtube.com/watch?v=Cazzls2sZVk) or other hypervisor. 
	c. Ubuntu runs better on VirtualBox if [**the Guest Additions are installed**](https://www.youtube.com/watch?v=AuJGvJoMrgQ). If the Guest Additions are not installed, [**install the Guest Additions**](https://www.youtube.com/watch?v=AuJGvJoMrgQ).

2. ### This project
	This project can be cloned from GitHub using the ***git*** command line tool. If git is not installed, [***install git***](https://www.youtube.com/watch?v=TBlmCo6hIwc). You may want to install the project in a folder that is easy to locate. For example, you may create a folder named ***projects***, then install the project within. This example is run from the users "***home***" directory. If the user was ***jdoe***, the folder created below would be ***/home/jdoe/projects/*** and the project would be cloned within this folder.
	
	**`mkdir projects`**
	
	**`cd projects`**
	
	**`git clone https://github.com/webpwnized/mutillidae-terraform.git`**

3. ### The *Terrform* client software

	[**This video**](https://www.youtube.com/watch?v=LM3RLgNu7tU) shows [**how to install Terraform on Ubuntu Linux**](https://www.youtube.com/watch?v=LM3RLgNu7tU). Otherwise, follow the instructions for your distribution at the [**Hashicorp "Install Terraform" Developer Documentation**](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

4. ### The Google Cloud (GPC) *gcloud* client software

	[**This video**](https://www.youtube.com/watch?v=04GONi_U6zU) shows [**how to install the gcloud CLI on Ubuntu Linux**](https://www.youtube.com/watch?v=04GONi_U6zU). Otherwise, follow [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux)

5. ### A Google Cloud Platform (GPC) project

	This video shows [**how to Create a Project in Google Cloud Platform (GPC)**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)")

6. ### A Google Cloud (GCP) Service Account for Terraform

	This video shows [**how to Create a Service Account for Terraform**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform")

## Optional Pre-Installation Instructions

1. If ***VirtualBox*** is not installed, [**install VirtualBox**](https://www.youtube.com/watch?v=61GhP8DsQMw).
2. If you would like to use an Ubuntu virtual machine, [**install Ubuntu on VirtualBox**](https://www.youtube.com/watch?v=Cazzls2sZVk) or other hypervisor. 
3. Ubuntu runs better on VirtualBox if [**the Guest Additions are installed**](https://www.youtube.com/watch?v=AuJGvJoMrgQ). If the Guest Additions are not installed, [**install the Guest Additions**](https://www.youtube.com/watch?v=AuJGvJoMrgQ).

## Installation Instructions the Google Cloud lab environment

1. If git is not installed, [**install git**](https://www.youtube.com/watch?v=TBlmCo6hIwc).

2. Clone this project. This project can be cloned from GitHub using the **git** command line tool.
	
	**`git clone https://github.com/webpwnized/mutillidae-terraform.git`**

3. The lab files are located in this project within the ***mutillidae-terraform/lab-environment/gcp*** directory. Change into the lab directory.

	**`cd mutillidae-terraform/lab-environment/gcp`**

4. The remaining commands are run from the lab directory. You will not leave this directory for the rest of the installation or when running the labs.

5. The variables used by ***Terraform*** are inside the file ***variables.tf.CHANGEME***. Copy this file to a new file named ***variables.tf***. You will configure your variables in ***variables.tf***.

	**`cp ../../reference-architecture/gcp/variables.tf.CHANGEME variables.tf`**

6. Create an SSH key pair. You will use the SSH public key to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. [**Create and SSH key pair**](https://www.youtube.com/watch?v=eUwOlc9HfZs "Linux Basics: How to Create SSH Key").

7. Put the full path to the public key in the ***variables.tf*** file. Do not use the relative path. Terraform does not use relative paths. 

8. Configure the remaining variables in the ***variables.tf*** file at the root of this project. See instructions below in section ***How to configure variables.tf***.

9. Install, initialize, and authenticate the Google ***gcloud*** client software following [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux "the instructions for your distribution")

11. [**Install the *terraform* client software**](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

12. [**Create a Google Cloud project**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud (GPC)") in Google Cloud (GCP). Configure the project name in the ***variables.tf*** file. Note that Google will require a ***Google Billing Account*** to create a ***Google Cloud Project***. If you have an existing ***Google Billing Account***, you can point the ***Google Cloud Project*** to the existing ***Google Billing Account***. Otherwise, you will create a ***Google Billing Account*** as a part of opening a ***Google Cloud Account***.

13. [**Create a service account**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the Google Cloud Platform (GCP) project. The service account will need the following permissions.

* Editor Role
* Secret Manager Secret Accessor
* Service Networking  Admin

9. [**Create a service account key**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") for the service account

10. Place the service account key in a file. [**Configure the service account key location**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the ***variables.tf*** file.

11. Verify the following Google Cloud Platform (GCP) API are enabled for the Project. Enable the following API if not already enabled.

* Compute Engine API
* Cloud Resource Manager API
* Service Networking API
* Cloud SQL Admin API
* Identity and Access Management (IAM) API

12. Deploy the lab. See instructions below in section ***How to deploy the lab***.

### How to configure variables.tf

The lab does not use all of the variables in the variables.tf file. The lab only uses the following variables.

 1. ***terraform-credentials-file*** - The GCP service account that Terraform will use to authenticate to the project. [**Create a service account key**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") for the service account. Place the service account key in a file. [**Configure the service account key location**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the ***variables.tf*** file.

 2. ***project*** - The GCP project in which the assets will be built. [**Create a project**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)") in Google Cloud Platform (GCP). 

 3. Configure the **Project ID** in the ***variables.tf*** file.

4. ***ssh-username*** - The Linux username you will use to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. Configure the Linux user name in the ***variables.tf*** file.

5. ***ssh-public-key-file*** - The SSH public key you will use to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. [**Create and SSH key pair**](https://www.youtube.com/watch?v=eUwOlc9HfZs "Linux Basics: How to Create SSH Key"). Put the full path to the ***public key*** (not the private key) in the ***variables.tf*** file.

6. ***default-labels*** - Put your name in the "owner" field in the ***variables.tf*** file.

7. ***admin-office-ip-address-range*** - Your IP address. Terraform will set up firewall rules allowing access from this range. Put your IP address or IP address range into this value.

8. Using the above as examples, continue configuring the remaining variables.

## How to deploy the lab

All of the project dependencies and the lab environment must be installed before trying to build the lab. 

 - The lab files are located in this project within the ***mutillidae-terraform/lab-environment/gcp*** directory. 
 - The directory contains a script that will build the lab environment. Ensure the command is run from within the lab folder.

	**`cd mutillidae-terraform/lab-environment/gcp`**

 - Run the following script to build the lab environment.

	**`./build-gcp-lab-environment.sh`**
