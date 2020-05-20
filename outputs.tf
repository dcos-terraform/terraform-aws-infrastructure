output "bootstrap_instance" {
  description = "Bootstrap instance ID"
  value       = module.dcos-bootstrap-instance.instance
}

output "bootstrap_public_ip" {
  description = "Public IP of the bootstrap instance"
  value       = module.dcos-bootstrap-instance.public_ip
}

output "bootstrap_private_ip" {
  description = "Private IP of the bootstrap instance"
  value       = module.dcos-bootstrap-instance.private_ip
}

output "bootstrap_os_user" {
  description = "Bootstrap instance OS default user"
  value       = module.dcos-bootstrap-instance.os_user
}

output "masters_instances" {
  description = "Master instances IDs"
  value       = [module.dcos-master-instances.instances]
}

output "masters_public_ips" {
  description = "Master instances public IPs"
  value       = [module.dcos-master-instances.public_ips]
}

output "masters_private_ips" {
  description = "Master instances private IPs"
  value       = [module.dcos-master-instances.private_ips]
}

output "masters_os_user" {
  description = "Master instances private OS default user"
  value       = module.dcos-master-instances.os_user
}

output "masters_aws_iam_instance_profile" {
  description = "Masters instance profile name"
  value = coalesce(
    var.masters_iam_instance_profile,
    module.dcos-iam.aws_master_profile,
  )
}

output "private_agents_instances" {
  description = "Private Agent instances IDs"
  value       = [module.dcos-privateagent-instances.instances]
}

output "private_agents_public_ips" {
  description = "Private Agent public IPs"
  value       = [module.dcos-privateagent-instances.public_ips]
}

output "private_agents_private_ips" {
  description = "Private Agent instances private IPs"
  value       = [module.dcos-privateagent-instances.private_ips]
}

output "private_agents_os_user" {
  description = "Private Agent instances private OS default user"
  value       = module.dcos-privateagent-instances.os_user
}

output "private_agents_aws_iam_instance_profile" {
  description = "Private Agent instance profile name"
  value = coalesce(
    var.private_agents_iam_instance_profile,
    module.dcos-iam.aws_agent_profile,
  )
}

//Private Agent
output "public_agents_instances" {
  description = "Public Agent instances IDs"
  value       = [module.dcos-publicagent-instances.instances]
}

output "public_agents_public_ips" {
  description = "Public Agent public IPs"
  value       = [module.dcos-publicagent-instances.public_ips]
}

output "public_agents_private_ips" {
  description = "Public Agent instances private IPs"
  value       = [module.dcos-publicagent-instances.private_ips]
}

output "public_agents_os_user" {
  description = "Public Agent instances private OS default user"
  value       = module.dcos-publicagent-instances.os_user
}

output "public_agents_aws_iam_instance_profile" {
  description = "Public Agent instance profile name"
  value = coalesce(
    var.public_agents_iam_instance_profile,
    module.dcos-iam.aws_agent_profile,
  )
}

output "iam_agent_profile" {
  value       = module.dcos-iam.aws_agent_profile
  description = "Name of the agent profile"
}

output "iam_master_profile" {
  value       = module.dcos-iam.aws_master_profile
  description = "Name of the master profile"
}

output "lb_public_agents_dns_name" {
  description = "This is the load balancer to reach the public agents"
  value       = module.dcos-lb.public_agents_dns_name
}

output "lb_masters_dns_name" {
  description = "This is the load balancer to access the DC/OS UI"
  value       = module.dcos-lb.masters_dns_name
}

output "lb_masters_internal_dns_name" {
  description = "This is the load balancer to access the masters internally in the cluster"
  value       = module.dcos-lb.masters_internal_dns_name
}

output "security_groups_internal" {
  description = "This is the id of the internal security_group that the cluster is in"
  value       = module.dcos-security-groups.internal
}

output "security_groups_admin" {
  description = "This is the id of the admin security_group that the cluster is in"
  value       = module.dcos-security-groups.admin
}

output "vpc_id" {
  description = "This is the id of the VPC the cluster is in"
  value       = module.dcos-vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "This is the cidr_block of the VPC the cluster is in"
  value       = module.dcos-vpc.cidr_block
}

output "vpc_main_route_table_id" {
  description = "This is the id of the VPC's main routing table the cluster is in"
  value       = module.dcos-vpc.aws_main_route_table_id
}

output "vpc_subnet_ids" {
  description = "This is the list of subnet_ids the cluster is in"
  value       = [module.dcos-vpc.subnet_ids]
}

output "aws_key_name" {
  description = "Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string"
  value       = local.aws_key_name
}

output "aws_s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = join(",", aws_s3_bucket.external_exhibitor.*.id)
}

