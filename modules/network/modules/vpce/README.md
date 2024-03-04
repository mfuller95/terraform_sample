Basic Network Module
===========

This terraform modules provides the basics for setting up a new VPC. It includes
- AWS VPC
- A 3 tiered subnet setup (Public, Private and Data) with the ability to deploy to multiple AZs
- Route tables
- NACL that allows 80 & 443 through each tier by default with the ability to add more ports as needed
- The ability to deploy VPC endpoints as needed

Module Input Variables
----------------------

- `service` - The name of the AWS service to provide a VPC endpoint for
- `vpc_id` - The id of the VPC to deploy the endpoint into
- `region` - The AWS region to deploy into
- `endpoint_type` - The type of the VPC endpoint to deploy
- `subnet_ids` - The IDs of the subnet to deploy into
- `route_table_ids` - The IDs of the route tables

Usage
-----

```hcl
module "demo_gateway" {
  source = "./modules/vpce"

  service         = "s3"
  vpc_id          = "some_vpc_id"
  region          = "us-east-1"
  endpoint_type   = "Gateway" 
  route_table_ids = ["some_route_table_id"]
}
```

```hcl
module "demo_interface" {
  source = "./modules/vpce"

  service       = "ec2"
  vpc_id        = "some_vpc_id"
  region        = "us-east-1"
  endpoint_type = "Interface" 
  subnet_ids    = ["some_subnet_ids"]
}
```


Outputs
=======

Authors
=======

mfuller95@gmail.com
