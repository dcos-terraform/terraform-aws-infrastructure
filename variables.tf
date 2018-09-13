variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "centos_7.4"
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "dcos-example"
}

variable "availability_zones" {
  type        = "list"
  description = "Availability zones to be used"
  default     = []
}

variable "subnet_range" {
  description = "Subnet used to spawn DC/OS in"
  default     = "172.12.0.0/16"
}

variable "tags" {
  description = "Custom tags added to the resources created by this module"
  type        = "map"
  default     = {}
}

variable "admin_ips" {
  description = "List of CIDR admin IPs"
  default     = []
}

variable "aws_key_name" {
  description = "EC2 SSH key to use. We assume its already loaded in your SSH agent. Set ssh_public_key to none"
  default     = ""
}

variable "ssh_public_key" {
  description = <<EOF
SSH public key in authorized keys format (e.g. "ssh-rsa ..") to be used with the instances. Make sure you added this key to your ssh-agent
EOF
  default     = ""
}

variable "ssh_public_key_file" {
  description = <<EOF
path to SSH public key. This is mandatory but can be set to `""` if you want to use `ssh_public_key` with the key as string
EOF
}

variable "num_masters" {
  description = "Number of masters. For redundancy you should have at least 3"
  default     = 3
}

variable "num_private_agents" {
  description = "Number of private agents. These agents will provide your main resources"
  default     = 2
}

variable "num_public_agents" {
  description = "Number of public agents. These agents will host marathon-lb and edgelb"
  default     = 1
}

variable "aws_ami" {
  description = "AMI that will be used for the instances instead of the Mesosphere provided AMIs"
  default     = ""
}

variable "bootstrap_aws_ami" {
  description = "[BOOTSTRAP] AMI to be used"
  default     = ""
}

variable "bootstrap_os" {
  description = "[BOOTSTRAP] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "bootstrap_root_volume_size" {
  description = "[BOOTSTRAP] Root volume size"
  default     = "80"
}

variable "bootstrap_root_volume_type" {
  description = "[BOOTSTRAP] Specify the root volume type."
  default     = "standard"
}

variable "bootstrap_instance_type" {
  description = "[BOOTSTRAP] Instance type"
  default     = "t2.medium"
}

variable "bootstrap_associate_public_ip_address" {
  description = "[BOOTSTRAP] Associate a public ip address with there instances"
  default     = true
}

variable "masters_aws_ami" {
  description = "[MASTERS] AMI to be used"
  default     = ""
}

variable "masters_os" {
  description = "[MASTERS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "masters_root_volume_size" {
  description = "[MASTERS] Root volume size"
  default     = "120"
}

variable "masters_instance_type" {
  description = "[MASTERS] Instance type"
  default     = "m4.xlarge"
}

variable "masters_associate_public_ip_address" {
  description = "[MASTERS] Associate a public ip address with there instances"
  default     = true
}

variable "private_agents_aws_ami" {
  description = "[PRIVATE AGENTS] AMI to be used"
  default     = ""
}

variable "private_agents_os" {
  description = "[PRIVATE AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "private_agents_root_volume_size" {
  description = "[PRIVATE AGENTS] Root volume size"
  default     = "120"
}

variable "private_agents_root_volume_type" {
  description = "[PRIVATE AGENTS] Specify the root volume type."
  default     = "gp2"
}

variable "private_agents_instance_type" {
  description = "[PRIVATE AGENTS] Instance type"
  default     = "m4.xlarge"
}

variable "private_agents_associate_public_ip_address" {
  description = "[PRIVATE AGENTS] Associate a public ip address with there instances"
  default     = true
}

variable "public_agents_aws_ami" {
  description = "[PUBLIC AGENTS] AMI to be used"
  default     = ""
}

variable "public_agents_os" {
  description = "[PUBLIC AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "public_agents_root_volume_size" {
  description = "[PUBLIC AGENTS] Root volume size"
  default     = "120"
}

variable "public_agents_root_volume_type" {
  description = "[PUBLIC AGENTS] Specify the root volume type."
  default     = "gp2"
}

variable "public_agents_instance_type" {
  description = "[PUBLIC AGENTS] Instance type"
  default     = "m4.xlarge"
}

variable "public_agents_associate_public_ip_address" {
  description = "[PUBLIC AGENTS] Associate a public ip address with there instances"
  default     = true
}
