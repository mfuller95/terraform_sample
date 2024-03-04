Basic Network Module
===========

A terraform module to provide a <resource name> in AWS/AZURE/ETC,ETC.

This should be used an a generic template to be included in every terraform module.

Module Input Variables
----------------------

- `name` - The name of the VPC
- `vpc_cidr_block` - The CIDR block for the VPC
- `num_of_azs` - The number of subnets to deply for each layer
- `extra_public_nacl_inbound_ports` - Addtional ports to allow inbound through the NACL for the public subnets
- `extra_public_nacl_outbound_ports` - Addtional ports to allow outbound through the NACL
- `extra_private_nacl_inbound_ports` - Addtional ports to allow inbound through the NACL for the private subnets
- `extra_private_nacl_outbound_ports` - Addtional ports to allow outbound through the NACL
- `extra_data_nacl_inbound_ports` - Addtional ports to allow inbound through the NACL for the data subnets
- `extra_data_nacl_outbound_ports` - Addtional ports to allow outbount through the NACL
- `vpc_endpoint_services` - Short names of the AWS services to create vpc endpoints for

vpc_endpoint_services
Usage
-----

```hcl
module "demo" {
  source = "./modules/network"

  name = "whatever variable you would like to pass"
  vpc_cidr_block = "10.0.0.0/22"
  num_of_azs     = 3


}
```

module "demo_vpce" {
  source = "./modules/network"

  name           = "whatever variable you would like to pass"
  vpc_cidr_block = "10.0.0.0/22"
  num_of_azs     = 3

  extra_public_nacl_outbound_ports  = [8080]
  extra_private_nacl_inbound_ports  = [8080]
  extra_private_nacl_outbound_ports = [3309]

  vpc_endpoint_services = ["ec2", "s3"]
}


Outputs
=======

Authors
=======

mfuller95@gmail.com
