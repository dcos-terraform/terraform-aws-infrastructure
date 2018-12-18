/**
 * AWS DC/OS Master Instances
 * ============
 * This module creates typical DS/OS infrastructure in AWS.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-master-instances" {
 *   source  = "terraform-dcos/masters/aws"
 *   version = "~> 0.1"
 *
 *   cluster_name = "production"
 *   ssh_public_key = "ssh-rsa ..."
 *
 *   num_masters = "3"
 *   num_private_agents = "2"
 *   num_public_agents = "1"
 * }
 *```
 *
 * Known Issues
 * ------------
 *
 * *Not subscribed to a marketplace AMI.*
 *
 *```
 * * module.dcos-infrastructure.module.dcos-privateagent-instances.module.dcos-private-agent-instances.aws_instance.instance[0]: 1 error(s) occurred:
 * * aws_instance.instance.0: Error launching source instance: OptInRequired: In order to use this AWS Marketplace product you need to accept terms and subscribe. To do so please visit https://aws.amazon.com/marketplace/pp?sku=ryg425ue2hwnsok9ccfastg4
 *       status code: 401, request id: 421d7970-d19a-4178-9ee2-95995afe05da
 * * module.dcos-infrastructure.module.dcos-privateagent-instances.module.dcos-private-agent-instances.aws_instance.instance[1]: 1 error(s) occurred:
 *```
 *
 * Klick the stated link while being logged into the AWS Console ( Webinterface ) then click "subscribe" on the following page and follow the instructions.
 *
 */

provider "aws" {}

// if availability zones is not set request the available in this region
data "aws_availability_zones" "available" {}

locals {
  ssh_public_key_file = "${var.ssh_public_key_file == "" ? format("%s/main.tf", path.module) : var.ssh_public_key_file}"
  ssh_key_content     = "${var.ssh_public_key_file == "" ? var.ssh_public_key : file(local.ssh_public_key_file)}"
}

// create a ssh-key entry if ssh_public_key is set
resource "aws_key_pair" "deployer" {
  count      = "${local.ssh_key_content == "" ? 0 : 1}"
  key_name   = "${var.cluster_name}-deployer-key"
  public_key = "${local.ssh_key_content}"
}

// Create a VPC and subnets
module "dcos-vpc" {
  source  = "dcos-terraform/vpc/aws"
  version = "~> 0.1"

  # version = "0.0.1"
  providers = {
    aws = "aws"
  }

  subnet_range       = "${var.subnet_range}"
  cluster_name       = "${var.cluster_name}"
  availability_zones = ["${coalescelist(var.availability_zones, data.aws_availability_zones.available.names)}"]
}

// Firewall. Create policies for instances and load balancers
module "dcos-security-groups" {
  source = "dcos-terraform/security-groups/aws"

  # version = "0.0.1"
  providers = {
    aws = "aws"
  }

  vpc_id                         = "${module.dcos-vpc.vpc_id}"
  subnet_range                   = "${var.subnet_range}"
  cluster_name                   = "${var.cluster_name}"
  admin_ips                      = ["${var.admin_ips}"]
  public_agents_additional_ports = ["${var.public_agents_additional_ports}"]
}

// Permissions creates instances profiles so you could use Rexray and Kubernetes with AWS support
module "dcos-iam" {
  source  = "dcos-terraform/iam/aws"
  version = "~> 0.1"

  providers = {
    aws = "aws"
  }

  cluster_name = "${var.cluster_name}"
}

module "dcos-bootstrap-instance" {
  source  = "github.com/dcos-terraform/terraform-aws-bootstrap?ref=conditional-bootstrap"
  #version = "~> 0.1"

  providers = {
    aws = "aws"
  }

  cluster_name = "${var.cluster_name}"

  aws_subnet_ids         = ["${module.dcos-vpc.subnet_ids}"]
  aws_security_group_ids = ["${list(module.dcos-security-groups.internal, module.dcos-security-groups.admin)}"]
  aws_key_name           = "${local.ssh_key_content == "" ? var.aws_key_name : element(coalescelist(aws_key_pair.deployer.*.key_name, list("")), 0)}"

  num_bootstrap = "${var.num_bootstrap}"

  dcos_instance_os                = "${coalesce(var.bootstrap_os,var.dcos_instance_os)}"
  aws_ami                         = "${var.aws_ami}"
  aws_root_volume_size            = "${var.bootstrap_root_volume_size}"
  aws_root_volume_type            = "${var.bootstrap_root_volume_type}"
  aws_iam_instance_profile        = "${var.bootstrap_iam_instance_profile}"
  aws_instance_type               = "${var.bootstrap_instance_type}"
  aws_associate_public_ip_address = "${var.bootstrap_associate_public_ip_address}"

  tags = "${var.tags}"
}

module "dcos-master-instances" {
  source  = "dcos-terraform/masters/aws"
  version = "~> 0.1"

  providers = {
    aws = "aws"
  }

  cluster_name = "${var.cluster_name}"

  aws_subnet_ids         = ["${module.dcos-vpc.subnet_ids}"]
  aws_security_group_ids = ["${list(module.dcos-security-groups.internal, module.dcos-security-groups.admin)}"]
  aws_key_name           = "${local.ssh_key_content == "" ? var.aws_key_name : element(coalescelist(aws_key_pair.deployer.*.key_name, list("")), 0)}"

  num_masters = "${var.num_masters}"

  dcos_instance_os                = "${coalesce(var.masters_os,var.dcos_instance_os)}"
  aws_ami                         = "${var.aws_ami}"
  aws_root_volume_size            = "${var.masters_root_volume_size}"
  aws_iam_instance_profile        = "${coalesce(var.masters_iam_instance_profile, module.dcos-iam.aws_master_profile)}"
  aws_instance_type               = "${var.masters_instance_type}"
  aws_associate_public_ip_address = "${var.masters_associate_public_ip_address}"

  tags = "${var.tags}"
}

module "dcos-privateagent-instances" {
  source  = "dcos-terraform/private-agents/aws"
  version = "~> 0.1"

  providers = {
    aws = "aws"
  }

  cluster_name = "${var.cluster_name}"

  aws_subnet_ids         = ["${module.dcos-vpc.subnet_ids}"]
  aws_security_group_ids = ["${list(module.dcos-security-groups.internal, module.dcos-security-groups.admin)}"]
  aws_key_name           = "${local.ssh_key_content == "" ? var.aws_key_name : element(coalescelist(aws_key_pair.deployer.*.key_name, list("")), 0)}"

  num_private_agents = "${var.num_private_agents}"

  dcos_instance_os                = "${coalesce(var.private_agents_os,var.dcos_instance_os)}"
  aws_ami                         = "${var.aws_ami}"
  aws_root_volume_size            = "${var.private_agents_root_volume_size}"
  aws_root_volume_type            = "${var.private_agents_root_volume_type}"
  aws_iam_instance_profile        = "${coalesce(var.private_agents_iam_instance_profile, module.dcos-iam.aws_agent_profile)}"
  aws_instance_type               = "${var.private_agents_instance_type}"
  aws_associate_public_ip_address = "${var.private_agents_associate_public_ip_address}"

  tags = "${var.tags}"
}

// DC/OS tested OSes provides sample AMIs and user-data
module "dcos-publicagent-instances" {
  source  = "dcos-terraform/public-agents/aws"
  version = "~> 0.1"

  providers = {
    aws = "aws"
  }

  cluster_name = "${var.cluster_name}"

  aws_subnet_ids         = ["${module.dcos-vpc.subnet_ids}"]
  aws_security_group_ids = ["${list(module.dcos-security-groups.internal, module.dcos-security-groups.admin, module.dcos-security-groups.public_agents)}"]
  tags                   = "${var.tags}"
  aws_key_name           = "${local.ssh_key_content == "" ? var.aws_key_name : element(coalescelist(aws_key_pair.deployer.*.key_name, list("")), 0)}"

  num_public_agents = "${var.num_public_agents}"

  dcos_instance_os                = "${coalesce(var.public_agents_os,var.dcos_instance_os)}"
  aws_ami                         = "${var.aws_ami}"
  aws_root_volume_size            = "${var.public_agents_root_volume_size}"
  aws_root_volume_type            = "${var.public_agents_root_volume_type}"
  aws_iam_instance_profile        = "${coalesce(var.public_agents_iam_instance_profile, module.dcos-iam.aws_agent_profile)}"
  aws_instance_type               = "${var.public_agents_instance_type}"
  aws_associate_public_ip_address = "${var.public_agents_associate_public_ip_address}"

  tags = "${var.tags}"
}

// Load balancers is providing two load balancers. One for accessing the DC/OS masters and a secondone balancing over public agents.
module "dcos-elb" {
  source  = "dcos-terraform/elb-dcos/aws"
  version = "~> 0.1"

  providers = {
    aws = "aws"
  }

  cluster_name = "${var.cluster_name}"
  subnet_ids   = ["${module.dcos-vpc.subnet_ids}"]

  security_groups_masters          = ["${list(module.dcos-security-groups.admin,module.dcos-security-groups.internal)}"]
  security_groups_masters_internal = ["${list(module.dcos-security-groups.internal)}"]
  security_groups_public_agents    = ["${list(module.dcos-security-groups.internal, module.dcos-security-groups.admin, module.dcos-security-groups.public_agents)}"]
  master_instances                 = ["${module.dcos-master-instances.instances}"]
  public_agent_instances           = ["${module.dcos-publicagent-instances.instances}"]

  tags = "${var.tags}"
}
