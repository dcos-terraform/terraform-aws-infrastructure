output "bootstrap.instance" {
  description = "Bootstrap instance ID"
  value       = "${module.dcos-bootstrap-instance.instance}"
}

output "bootstrap.public_ip" {
  description = "Bootstrap instance public ip"
  value       = "${module.dcos-bootstrap-instance.public_ip}"
}

output "bootstrap.private_ip" {
  description = "Bootstrap instance private ip"
  value       = "${module.dcos-bootstrap-instance.private_ip}"
}

output "bootstrap.os_user" {
  description = "Bootstrap instance OS default user"
  value       = "${module.dcos-bootstrap-instance.os_user}"
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

//Private Agent
output "public_agents.instances" {
  description = "Public Agent instances IDs"
  value       = ["${module.dcos-publicagent-instances.instances}"]
}

output "public_agents.public_ips" {
  description = "Private Agent public IPs"
  value       = ["${module.dcos-publicagent-instances.public_ips}"]
}

output "public_agents.private_ips" {
  description = "Private Agent instances private IPs"
  value       = ["${module.dcos-publicagent-instances.private_ips}"]
}

output "public_agents.os_user" {
  description = "Private Agent instances private OS default user"
  value       = "${module.dcos-publicagent-instances.os_user}"
}

output "elb.public_agents_dns_name" {
  description = "DNS Name of the public agent load balancer."
  value       = "${module.dcos-elb.public_agents_dns_name}"
}

output "elb.masters_dns_name" {
  description = "This is the load balancer address to access the DC/OS UI"
  value       = "${module.dcos-elb.masters_dns_name}"
}

output "elb.masters_internal_dns_name" {
  description = "This is the load balancer address to access the DC/OS UI"
  value       = "${module.dcos-elb.masters_internal_dns_name}"
}
