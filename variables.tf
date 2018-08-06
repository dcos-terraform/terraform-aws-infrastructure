variable "dcos_instance_os" {
  description = "The operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "centos_7.4"
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "dcos-example"
}

variable "availability_zones" {
  type        = "list"
  description = "Specify the availability zones to be used"
  default     = []
}

variable "subnet_range" {
  description = "The subnet used to spawn dcos in"
  default     = "172.12.0.0/16"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "admin_ips" {
  description = "List of CIDR admin IPs"
  default     = []
}

variable "aws_key_name" {
  description = "Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key to none"
  default     = ""
}

variable "ssh_public_key" {
  description = <<EOF
Specify a SSH public key in authorized keys format (e.g. "ssh-rsa ..") to be used with the instances. Make sure you added this key to your ssh-agent
EOF
}

variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
  default     = 3
}

variable "num_private_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
  default     = 2
}

variable "num_public_agents" {
  description = "Specify the amount of public agents. These agents will host marathon-lb and edgelb"
  default     = 1
}

variable "aws_ami" {
  description = "Specify an AMI which will be used for the instances instead of the Mesosphere provided AMIs"
  default     = ""
}

variable "aws_user_data" {
  description = "If you're using a special AMI you might want to add userdata"
  default     = ""
}
