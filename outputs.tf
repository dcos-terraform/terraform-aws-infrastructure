output "bootstrap.instance" {
  description = "Bootstrap instance ID"
  value       = "${module.dcos-bootstrap-instance.instance}"
}

output "bootstrap.public_ip" {
  description = "Public IP of the bootstrap instance"
  value       = "${module.dcos-bootstrap-instance.public_ip}"
}

output "bootstrap.private_ip" {
  description = "Private IP of the bootstrap instance"
  value       = "${module.dcos-bootstrap-instance.private_ip}"
}

output "bootstrap.os_user" {
  description = "Bootstrap instance OS default user"
  value       = "${module.dcos-bootstrap-instance.os_user}"
}

output "bootstrap.prereq-id" {
  description = "Returns the ID of the prereq script for bootstrap (if user_data or ami are not used)"
  value       = "${module.dcos-bootstrap-instance.prereq-id}"
}

output "masters.instances" {
  description = "Master instances IDs"
  value       = ["${module.dcos-master-instances.instances}"]
}

output "masters.public_ips" {
  description = "Master instances public IPs"
  value       = ["${module.dcos-master-instances.public_ips}"]
}

output "masters.private_ips" {
  description = "Master instances private IPs"
  value       = ["${module.dcos-master-instances.private_ips}"]
}

output "masters.os_user" {
  description = "Master instances private OS default user"
  value       = "${module.dcos-master-instances.os_user}"
}

output "masters.prereq-id" {
  description = "Returns the ID of the prereq script for masters (if user_data or ami are not used)"
  value       = "${module.dcos-master-instances.prereq-id}"
}

output "private_agents.instances" {
  description = "Private Agent instances IDs"
  value       = ["${module.dcos-privateagent-instances.instances}"]
}

output "private_agents.public_ips" {
  description = "Private Agent public IPs"
  value       = ["${module.dcos-privateagent-instances.public_ips}"]
}

output "private_agents.private_ips" {
  description = "Private Agent instances private IPs"
  value       = ["${module.dcos-privateagent-instances.private_ips}"]
}

output "private_agents.os_user" {
  description = "Private Agent instances private OS default user"
  value       = "${module.dcos-privateagent-instances.os_user}"
}

output "private_agents.prereq-id" {
  description = "Returns the ID of the prereq script for private agents (if user_data or ami are not used)"
  value       = "${module.dcos-privateagent-instances.prereq-id}"
}

//Private Agent
output "public_agents.instances" {
  description = "Public Agent instances IDs"
  value       = ["${module.dcos-publicagent-instances.instances}"]
}

output "public_agents.public_ips" {
  description = "Public Agent public IPs"
  value       = ["${module.dcos-publicagent-instances.public_ips}"]
}

output "public_agents.private_ips" {
  description = "Public Agent instances private IPs"
  value       = ["${module.dcos-publicagent-instances.private_ips}"]
}

output "public_agents.os_user" {
  description = "Private Agent instances private OS default user"
  value       = "${module.dcos-publicagent-instances.os_user}"
}

output "public_agents.prereq-id" {
  description = "Returns the ID of the prereq script for public agents (if user_data or ami are not used)"
  value       = "${module.dcos-publicagent-instances.prereq-id}"
}

output "iam.agent_profile" {
  value       = "${module.dcos-iam.aws_agent_profile}"
  description = "Name of the agent profile"
}

output "lb.public_agents_dns_name" {
  description = "This is the load balancer to reach the public agents"
  value       = "${module.dcos-lb.public_agents_dns_name}"
}

output "lb.masters_dns_name" {
  description = "This is the load balancer to access the DC/OS UI"
  value       = "${module.dcos-lb.masters_dns_name}"
}

output "lb.masters_internal_dns_name" {
  description = "This is the load balancer to access the masters internally in the cluster"
  value       = "${module.dcos-lb.masters_internal_dns_name}"
}

output "security_groups.internal" {
  description = "This is the id of the internal security_group that the cluster is in"
  value       = "${module.dcos-security-groups.internal}"
}

output "security_groups.admin" {
  description = "This is the id of the admin security_group that the cluster is in"
  value       = "${module.dcos-security-groups.admin}"
}

output "vpc.id" {
  description = "This is the id of the VPC the cluster is in"
  value       = "${module.dcos-vpc.vpc_id}"
}

output "vpc.cidr_block" {
  description = "This is the cidr_block of the VPC the cluster is in"
  value       = "${module.dcos-vpc.cidr_block}"
}

output "vpc.main_route_table_id" {
  description = "This is the id of the VPC's main routing table the cluster is in"
  value       = "${module.dcos-vpc.aws_main_route_table_id}"
}

output "vpc.subnet_ids" {
  description = "This is the list of subnet_ids the cluster is in"
  value       = ["${module.dcos-vpc.subnet_ids}"]
}

output "aws_key_name" {
  description = "Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string"
  value       = "${local.aws_key_name}"
}
