module "network" {
  source = "./modules/network"

  name                              = "sample_vpc"
  vpc_cidr_block                    = "10.0.0.0/16"
  num_of_azs                        = 2
  extra_public_nacl_outbound_ports  = [8080]
  extra_private_nacl_inbound_ports  = [8080]
  extra_private_nacl_outbound_ports = [3309]

  vpc_endpoint_services = ["ec2", "s3"]
}