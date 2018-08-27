AWS DC/OS Master Instances
============
This module creates typical DS/OS infrastructure in AWS.

EXAMPLE
-------

```hcl
module "dcos-master-instances" {
  source  = "terraform-dcos/masters/aws"
  version = "~> 0.1"

  cluster_name = "production"
  ssh_public_key = "ssh-rsa ..."

  num_masters = "3"
  num_private_agents = "2"
  num_public_agents = "1"
}
```


## Inputs

| Name               | Description                                                                                                                                |  Type  |     Default     | Required |
|:-------------------|:-------------------------------------------------------------------------------------------------------------------------------------------|:------:|:---------------:|:--------:|
| admin_ips          | List of CIDR admin IPs                                                                                                                     | string |    `<list>`     |    no    |
| availability_zones | Availability zones to be used                                                                                                              |  list  |    `<list>`     |    no    |
| aws_ami            | AMI that will be used for the instances instead of the Mesosphere provided AMIs                                                            | string |       ``        |    no    |
| aws_key_name       | EC2 SSH key to use. We assume its already loaded in your SSH agent. Set ssh_public_key to none                                             | string |       ``        |    no    |
| aws_user_data      | If you're using a special AMI you might want to add userdata                                                                               | string |       ``        |    no    |
| cluster_name       | Name of the DC/OS cluster                                                                                                                  | string | `dcos-example`  |    no    |
| dcos_instance_os   | Operating system to use. Instead of using your own AMI you could use a provided OS.                                                        | string |  `centos_7.4`   |    no    |
| num_masters        | Number of masters. For redundancy you should have at least 3                                                                               | string |       `3`       |    no    |
| num_private_agents | Number of private agents. These agents will provide your main resources                                                                    | string |       `2`       |    no    |
| num_public_agents  | Number of public agents. These agents will host marathon-lb and edgelb                                                                     | string |       `1`       |    no    |
| ssh_public_key     | SSH public key in authorized keys format (e.g. "ssh-rsa ..") to be used with the instances. Make sure you added this key to your ssh-agent | string |        -        |   yes    |
| subnet_range       | Subnet used to spawn DC/OS in                                                                                                              | string | `172.12.0.0/16` |    no    |
| tags               | Custom tags added to the resources created by this module                                                                                  |  map   |     `<map>`     |    no    |

## Outputs

| Name                          | Description                                              |
|:------------------------------|:---------------------------------------------------------|
| bootstrap.instance            | Bootstrap instance ID                                    |
| bootstrap.os_user             | Bootstrap instance OS default user                       |
| bootstrap.private_ip          | Bootstrap instance private ip                            |
| bootstrap.public_ip           | Bootstrap instance public ip                             |
| elb.masters_dns_name          | This is the load balancer address to access the DC/OS UI |
| elb.masters_internal_dns_name | This is the load balancer address to access the DC/OS UI |
| elb.public_agents_dns_name    | DNS Name of the public agent load balancer.              |
| masters.instances             | Master instances IDs                                     |
| masters.os_user               | Master instances private OS default user                 |
| masters.private_ips           | Master instances private IPs                             |
| masters.public_ips            | Master instances public IPs                              |
| private_agents.instances      | Private Agent instances IDs                              |
| private_agents.os_user        | Private Agent instances private OS default user          |
| private_agents.private_ips    | Private Agent instances private IPs                      |
| private_agents.public_ips     | Private Agent public IPs                                 |
| public_agents.instances       | Private Agent                                            |
| public_agents.os_user         | Private Agent instances private OS default user          |
| public_agents.private_ips     | Private Agent instances private IPs                      |
| public_agents.public_ips      | Private Agent public IPs                                 |
