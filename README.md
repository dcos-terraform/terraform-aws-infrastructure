AWS DC/OS Master Instances
============
This module creates typical DS/OS infrastructure in AWS.

EXAMPLE
-------

```hcl
module "dcos-master-instances" {
  source  = "terraform-dcos/masters/aws"
  version = "~> 0.1.0"

  cluster_name = "production"
  ssh_public_key = "ssh-rsa ..."

  num_masters = "3"
  num_private_agents = "2"
  num_public_agents = "1"
}
```

Known Issues
------------

*Not subscribed to a marketplace AMI.*

```
* module.dcos-infrastructure.module.dcos-privateagent-instances.module.dcos-private-agent-instances.aws_instance.instance[0]: 1 error(s) occurred:
* aws_instance.instance.0: Error launching source instance: OptInRequired: In order to use this AWS Marketplace product you need to accept terms and subscribe. To do so please visit https://aws.amazon.com/marketplace/pp?sku=ryg425ue2hwnsok9ccfastg4
      status code: 401, request id: 421d7970-d19a-4178-9ee2-95995afe05da
* module.dcos-infrastructure.module.dcos-privateagent-instances.module.dcos-private-agent-instances.aws_instance.instance[1]: 1 error(s) occurred:
```

Klick the stated link while being logged into the AWS Console ( Webinterface ) then click "subscribe" on the following page and follow the instructions.



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_ips | List of CIDR admin IPs | list | - | yes |
| availability_zones | Availability zones to be used | list | `<list>` | no |
| aws_ami | AMI that will be used for the instances instead of Mesosphere provided AMIs | string | `` | no |
| aws_key_name | Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string | string | `` | no |
| bootstrap_associate_public_ip_address | [BOOTSTRAP] Associate a public ip address with there instances | string | `true` | no |
| bootstrap_aws_ami | [BOOTSTRAP] AMI to be used | string | `` | no |
| bootstrap_iam_instance_profile | [BOOTSTRAP] Instance profile to be used for these instances | string | `` | no |
| bootstrap_instance_type | [BOOTSTRAP] Instance type | string | `t2.medium` | no |
| bootstrap_os | [BOOTSTRAP] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `` | no |
| bootstrap_root_volume_size | [BOOTSTRAP] Root volume size in GB | string | `80` | no |
| bootstrap_root_volume_type | [BOOTSTRAP] Root volume type | string | `standard` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| dcos_instance_os | Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `centos_7.4` | no |
| masters_associate_public_ip_address | [MASTERS] Associate a public ip address with there instances | string | `true` | no |
| masters_aws_ami | [MASTERS] AMI to be used | string | `` | no |
| masters_iam_instance_profile | [MASTERS] Instance profile to be used for these instances | string | `` | no |
| masters_instance_type | [MASTERS] Instance type | string | `m4.xlarge` | no |
| masters_os | [MASTERS] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `` | no |
| masters_root_volume_size | [MASTERS] Root volume size in GB | string | `120` | no |
| num_masters | Specify the amount of masters. For redundancy you should have at least 3 | string | `3` | no |
| num_private_agents | Specify the amount of private agents. These agents will provide your main resources | string | `2` | no |
| num_public_agents | Specify the amount of public agents. These agents will host marathon-lb and edgelb | string | `1` | no |
| private_agents_associate_public_ip_address | [PRIVATE AGENTS] Associate a public ip address with there instances | string | `true` | no |
| private_agents_aws_ami | [PRIVATE AGENTS] AMI to be used | string | `` | no |
| private_agents_iam_instance_profile | [PRIVATE AGENTS] Instance profile to be used for these instances | string | `` | no |
| private_agents_instance_type | [PRIVATE AGENTS] Instance type | string | `m4.xlarge` | no |
| private_agents_os | [PRIVATE AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `` | no |
| private_agents_root_volume_size | [PRIVATE AGENTS] Root volume size in GB | string | `120` | no |
| private_agents_root_volume_type | [PRIVATE AGENTS] Root volume type | string | `gp2` | no |
| public_agents_additional_ports | List of additional ports allowed for public access on public agents (80 and 443 open by default) | string | `<list>` | no |
| public_agents_associate_public_ip_address | [PUBLIC AGENTS] Associate a public ip address with there instances | string | `true` | no |
| public_agents_aws_ami | [PUBLIC AGENTS] AMI to be used | string | `` | no |
| public_agents_iam_instance_profile | [PUBLIC AGENTS] Instance profile to be used for these instances | string | `` | no |
| public_agents_instance_type | [PUBLIC AGENTS] Instance type | string | `m4.xlarge` | no |
| public_agents_os | [PUBLIC AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `` | no |
| public_agents_root_volume_size | [PUBLIC AGENTS] Root volume size | string | `120` | no |
| public_agents_root_volume_type | [PUBLIC AGENTS] Specify the root volume type. | string | `gp2` | no |
| ssh_public_key | SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent. | string | `` | no |
| ssh_public_key_file | Path to SSH public key. This is mandatory but can be set to an empty string if you want to use ssh_public_key with the key as string. | string | - | yes |
| subnet_range | Private IP space to be used in CIDR format | string | `172.12.0.0/16` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| bootstrap.instance | Bootstrap instance ID |
| bootstrap.os_user | Bootstrap instance OS default user |
| bootstrap.prereq-id | Returns the ID of the prereq script for bootstrap (if user_data or ami are not used) |
| bootstrap.private_ip | Private IP of the bootstrap instance |
| bootstrap.public_ip | Public IP of the bootstrap instance |
| elb.masters_dns_name | This is the load balancer to access the DC/OS UI |
| elb.masters_internal_dns_name | This is the load balancer to access the masters internally in the cluster |
| elb.public_agents_dns_name | This is the load balancer to reach the public agents |
| masters.instances | Master instances IDs |
| masters.os_user | Master instances private OS default user |
| masters.prereq-id | Returns the ID of the prereq script for masters (if user_data or ami are not used) |
| masters.private_ips | Master instances private IPs |
| masters.public_ips | Master instances public IPs |
| private_agents.instances | Private Agent instances IDs |
| private_agents.os_user | Private Agent instances private OS default user |
| private_agents.prereq-id | Returns the ID of the prereq script for private agents (if user_data or ami are not used) |
| private_agents.private_ips | Private Agent instances private IPs |
| private_agents.public_ips | Private Agent public IPs |
| public_agents.instances | Private Agent |
| public_agents.os_user | Private Agent instances private OS default user |
| public_agents.prereq-id | Returns the ID of the prereq script for public agents (if user_data or ami are not used) |
| public_agents.private_ips | Public Agent instances private IPs |
| public_agents.public_ips | Public Agent public IPs |

