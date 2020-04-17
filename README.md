AWS DC/OS Master Instances
============
This module creates typical DS/OS infrastructure in AWS.

EXAMPLE
-------

```hcl
module "dcos-infrastructure" {
  source  = "dcos-terraform/infrastructure/aws"
  version = "~> 0.2.0"

  cluster_name = "production"
  ssh_public_key = "ssh-rsa ..."

  num_masters = "3"
  num_private_agents = "2"
  num_public_agents = "1"
}

output "bootstrap-public-ip" {
  value = "${module.dcos-infrastructure.bootstrap.public_ip}"
}

output "masters-public-ips" {
  value = "${module.dcos-infrastructure.masters.public_ips}"
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
| admin\_ips | List of CIDR admin IPs | list | n/a | yes |
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| ssh\_public\_key\_file | Path to SSH public key. This is mandatory but can be set to an empty string if you want to use ssh_public_key with the key as string. | string | n/a | yes |
| accepted\_internal\_networks | Subnet ranges for all internal networks | list | `<list>` | no |
| availability\_zones | List of availability_zones to be used as the same format that are required by the platform/cloud providers. i.e `['RegionZone']` | list | `<list>` | no |
| aws\_ami | AMI that will be used for the instances instead of the Mesosphere chosen default images. Custom AMIs must fulfill the Mesosphere DC/OS system-requirements: See https://docs.mesosphere.com/1.12/installing/production/system-requirements/ | string | `""` | no |
| aws\_create\_s3\_bucket | Create S3 bucket with unique name for exhibitor. | string | `"false"` | no |
| aws\_key\_name | Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string | string | `""` | no |
| bootstrap\_associate\_public\_ip\_address | [BOOTSTRAP] Associate a public ip address with there instances | string | `"true"` | no |
| bootstrap\_aws\_ami | [BOOTSTRAP] AMI to be used | string | `""` | no |
| bootstrap\_hostname\_format | [BOOTSTRAP] Format the hostname inputs are index+1, region, cluster_name | string | `"%[3]s-bootstrap%[1]d-%[2]s"` | no |
| bootstrap\_iam\_instance\_profile | [BOOTSTRAP] Instance profile to be used for these instances | string | `""` | no |
| bootstrap\_instance\_type | [BOOTSTRAP] Instance type | string | `"t2.medium"` | no |
| bootstrap\_os | [BOOTSTRAP] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `""` | no |
| bootstrap\_root\_volume\_size | [BOOTSTRAP] Root volume size in GB | string | `"80"` | no |
| bootstrap\_root\_volume\_type | [BOOTSTRAP] Root volume type | string | `"standard"` | no |
| dcos\_instance\_os | Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `"centos_7.4"` | no |
| lb\_disable\_masters | Do not spawn master load balancer (admin access + internal access) | string | `"false"` | no |
| lb\_disable\_public\_agents | Do not spawn public agent load balancers. ( Needs to be true when num_public_agents is 0 ) | string | `"false"` | no |
| masters\_acm\_cert\_arn | ACM certifacte to be used for the masters load balancer | string | `""` | no |
| masters\_associate\_public\_ip\_address | [MASTERS] Associate a public ip address with there instances | string | `"true"` | no |
| masters\_aws\_ami | [MASTERS] AMI to be used | string | `""` | no |
| masters\_hostname\_format | [MASTERS] Format the hostname inputs are index+1, region, cluster_name | string | `"%[3]s-master%[1]d-%[2]s"` | no |
| masters\_iam\_instance\_profile | [MASTERS] Instance profile to be used for these instances | string | `""` | no |
| masters\_instance\_type | [MASTERS] Instance type | string | `"m4.xlarge"` | no |
| masters\_internal\_acm\_cert\_arn | ACM certifacte to be used for the internal masters load balancer | string | `""` | no |
| masters\_os | [MASTERS] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `""` | no |
| masters\_root\_volume\_size | [MASTERS] Root volume size in GB | string | `"120"` | no |
| masters\_user\_data | [MASTERS] User data to be used on these instances (cloud-init) | string | `""` | no |
| name\_prefix | Name Prefix | string | `""` | no |
| num\_bootstrap | Specify the amount of bootstrap. You should have at most 1 | string | `"1"` | no |
| num\_masters | Specify the amount of masters. For redundancy you should have at least 3 | string | `"3"` | no |
| num\_private\_agents | Specify the amount of private agents. These agents will provide your main resources | string | `"2"` | no |
| num\_public\_agents | Specify the amount of public agents. These agents will host marathon-lb and edgelb | string | `"1"` | no |
| private\_agents\_associate\_public\_ip\_address | [PRIVATE AGENTS] Associate a public ip address with there instances | string | `"true"` | no |
| private\_agents\_aws\_ami | [PRIVATE AGENTS] AMI to be used | string | `""` | no |
| private\_agents\_extra\_volumes | [PRIVATE AGENTS] Extra volumes for each private agent | list | `<list>` | no |
| private\_agents\_hostname\_format | [PRIVATE AGENTS] Format the hostname inputs are index+1, region, cluster_name | string | `"%[3]s-privateagent%[1]d-%[2]s"` | no |
| private\_agents\_iam\_instance\_profile | [PRIVATE AGENTS] Instance profile to be used for these instances | string | `""` | no |
| private\_agents\_instance\_type | [PRIVATE AGENTS] Instance type | string | `"m4.xlarge"` | no |
| private\_agents\_os | [PRIVATE AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `""` | no |
| private\_agents\_root\_volume\_size | [PRIVATE AGENTS] Root volume size in GB | string | `"120"` | no |
| private\_agents\_root\_volume\_type | [PRIVATE AGENTS] Root volume type | string | `"gp2"` | no |
| private\_agents\_user\_data | [PRIVATE AGENTS] User data to be used on these instances (cloud-init) | string | `""` | no |
| public\_agents\_access\_ips | List of ips allowed access to public agents. admin_ips are joined to this list | list | `<list>` | no |
| public\_agents\_acm\_cert\_arn | ACM certifacte to be used for the public agents load balancer | string | `""` | no |
| public\_agents\_additional\_ports | List of additional ports allowed for public access on public agents (80 and 443 open by default) | list | `<list>` | no |
| public\_agents\_associate\_public\_ip\_address | [PUBLIC AGENTS] Associate a public ip address with there instances | string | `"true"` | no |
| public\_agents\_aws\_ami | [PUBLIC AGENTS] AMI to be used | string | `""` | no |
| public\_agents\_extra\_volumes | [PUBLIC AGENTS] Extra volumes for each public agent | list | `<list>` | no |
| public\_agents\_hostname\_format | [PUBLIC AGENTS] Format the hostname inputs are index+1, region, cluster_name | string | `"%[3]s-publicagent%[1]d-%[2]s"` | no |
| public\_agents\_iam\_instance\_profile | [PUBLIC AGENTS] Instance profile to be used for these instances | string | `""` | no |
| public\_agents\_instance\_type | [PUBLIC AGENTS] Instance type | string | `"m4.xlarge"` | no |
| public\_agents\_os | [PUBLIC AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `""` | no |
| public\_agents\_root\_volume\_size | [PUBLIC AGENTS] Root volume size | string | `"120"` | no |
| public\_agents\_root\_volume\_type | [PUBLIC AGENTS] Specify the root volume type. | string | `"gp2"` | no |
| public\_agents\_user\_data | [PUBLIC AGENTS] User data to be used on these instances (cloud-init) | string | `""` | no |
| ssh\_public\_key | SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent. | string | `""` | no |
| subnet\_range | Private IP space to be used in CIDR format | string | `"172.16.0.0/16"` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_key\_name | Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string |
| aws\_s3\_bucket\_name | Name of the created S3 bucket |
| bootstrap.instance | Bootstrap instance ID |
| bootstrap.os\_user | Bootstrap instance OS default user |
| bootstrap.private\_ip | Private IP of the bootstrap instance |
| bootstrap.public\_ip | Public IP of the bootstrap instance |
| iam.agent\_profile | Name of the agent profile |
| iam.master\_profile | Name of the master profile |
| lb.masters\_dns\_name | This is the load balancer to access the DC/OS UI |
| lb.masters\_internal\_dns\_name | This is the load balancer to access the masters internally in the cluster |
| lb.public\_agents\_dns\_name | This is the load balancer to reach the public agents |
| masters.aws\_iam\_instance\_profile | Masters instance profile name |
| masters.instances | Master instances IDs |
| masters.os\_user | Master instances private OS default user |
| masters.private\_ips | Master instances private IPs |
| masters.public\_ips | Master instances public IPs |
| private\_agents.aws\_iam\_instance\_profile | Private Agent instance profile name |
| private\_agents.instances | Private Agent instances IDs |
| private\_agents.os\_user | Private Agent instances private OS default user |
| private\_agents.private\_ips | Private Agent instances private IPs |
| private\_agents.public\_ips | Private Agent public IPs |
| public\_agents.aws\_iam\_instance\_profile | Public Agent instance profile name |
| public\_agents.instances | Public Agent instances IDs |
| public\_agents.os\_user | Public Agent instances private OS default user |
| public\_agents.private\_ips | Public Agent instances private IPs |
| public\_agents.public\_ips | Public Agent public IPs |
| security\_groups.admin | This is the id of the admin security_group that the cluster is in |
| security\_groups.internal | This is the id of the internal security_group that the cluster is in |
| vpc.cidr\_block | This is the cidr_block of the VPC the cluster is in |
| vpc.id | This is the id of the VPC the cluster is in |
| vpc.main\_route\_table\_id | This is the id of the VPC's main routing table the cluster is in |
| vpc.subnet\_ids | This is the list of subnet_ids the cluster is in |

