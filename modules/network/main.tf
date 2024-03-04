locals {
  az_mapping = {
    1 = "a",
    2 = "b",
    3 = "c"
  }
  subnet_type_multiplier = {
    "public"  = 1,
    "private" = 2,
    "data"    = 3 
  }

  subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id, aws_subnet.data[*].id)

  route_table_ids = tolist([aws_network_acl.public.id, aws_network_acl.private.id, aws_network_acl.data.id])

  vpce_gateways = tolist(["dynamodb", "s3"])
}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  count = var.num_of_azs

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, local.subnet_type_multiplier["public"] * 10 + count.index)
}

resource "aws_subnet" "private" {
  count = var.num_of_azs

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, local.subnet_type_multiplier["private"] * 10 + count.index)
}

resource "aws_subnet" "data" {
  count = var.num_of_azs

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, local.subnet_type_multiplier["data"] * 10 + count.index)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "public" {
  count = var.num_of_azs

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private" {
  count = var.num_of_azs

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "data" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "data" {
  count = var.num_of_azs

  subnet_id      = aws_subnet.data[count.index].id
  route_table_id = aws_route_table.data.id
}

module "gateway_endpoints" {
  source = "./modules/vpce"
  for_each = {for i in var.vpc_endpoint_services : i => {service_name = i} if contains(local.vpce_gateways, i)}

  vpc_id          = aws_vpc.main.id
  region          = data.aws_region.current.name
  service         = each.value.service_name
  endpoint_type   = "Gateway"
  route_table_ids = local.route_table_ids
}

# 
module "interface_endpoints" {
  source = "./modules/vpce"
  for_each = {for i in var.vpc_endpoint_services : i => {service_name = i} if !(contains(local.vpce_gateways, i))}

  vpc_id        = aws_vpc.main.id
  region        = data.aws_region.current.name
  service       = each.value.service_name
  endpoint_type = "Interface"
  subnet_ids    = aws_subnet.public[*].id
}