locals {
  standard_ports = tolist([80, 443])
  public_outbound_ports = distinct(concat(var.extra_public_nacl_outbound_ports, local.standard_ports))
  private_outbound_ports = distinct(concat(var.extra_private_nacl_outbound_ports, local.standard_ports))
  data_outbound_ports = distinct(concat(var.extra_data_nacl_outbound_ports, local.standard_ports))
}

# Public Subnets
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public[*].id
}

module "inbound_public_nacl_allow_rules" {
  source = "./modules/nacl_rule"
  count  = var.num_of_azs

  network_acl_id    = aws_network_acl.public.id
  rule_number_start = (local.subnet_type_multiplier["public"] * 1000 + 200 * count.index)
  egress            = false
  rule_action       = "allow"
  cidr_block        = aws_subnet.public[count.index].cidr_block
  ports             = var.extra_public_nacl_inbound_ports
}

module "inbound_public_nacl_deny_rule" {
  source = "./modules/nacl_rule"

  network_acl_id    = aws_network_acl.public.id
  rule_number_start = 32000
  egress            = false
  rule_action       = "deny"
  cidr_block        = "0.0.0.0/0"
  ports             = [0]
}

module "outbound_public_nacl_allow_rules" {
  source = "./modules/nacl_rule"
  count  = var.num_of_azs

  network_acl_id    = aws_network_acl.public.id
  rule_number_start = (local.subnet_type_multiplier["public"] * 1000 + 200 * count.index)
  egress            = true
  rule_action       = "allow"
  cidr_block        = aws_subnet.public[count.index].cidr_block
  ports             = local.public_outbound_ports
}

module "outbound_public_nacl_deny_rule" {
  source = "./modules/nacl_rule"

  network_acl_id    = aws_network_acl.public.id
  rule_number_start = 32000
  egress            = true
  rule_action       = "deny"
  cidr_block        = "0.0.0.0/0"
  ports             = [0]
}

# Private Subnets
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id
}

module "inbound_private_nacl_allow_rules" {
  source = "./modules/nacl_rule"
  count  = var.num_of_azs

  network_acl_id    = aws_network_acl.private.id
  rule_number_start = (local.subnet_type_multiplier["private"] * 1000 + 200 * count.index)
  egress            = false
  rule_action       = "allow"
  cidr_block        = aws_subnet.private[count.index].cidr_block
  ports             = var.extra_private_nacl_inbound_ports
}

module "inbound_private_nacl_deny_rule" {
  source = "./modules/nacl_rule"

  network_acl_id    = aws_network_acl.private.id
  rule_number_start = 32000
  egress            = false
  rule_action       = "deny"
  cidr_block        = "0.0.0.0/0"
  ports             = [0]
}

module "outbound_private_nacl_allow_rules" {
  source = "./modules/nacl_rule"
  count  = var.num_of_azs

  network_acl_id    = aws_network_acl.private.id
  rule_number_start = (local.subnet_type_multiplier["private"] * 1000 + 200 * count.index)
  egress            = true
  rule_action       = "allow"
  cidr_block        = aws_subnet.private[count.index].cidr_block
  ports             = local.private_outbound_ports
}

module "outbound_private_nacl_deny_rule" {
  source = "./modules/nacl_rule"

  network_acl_id    = aws_network_acl.private.id
  rule_number_start = 32000
  egress            = true
  rule_action       = "deny"
  cidr_block        = "0.0.0.0/0"
  ports             = [0]
}

# Data Subnets
resource "aws_network_acl" "data" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.data[*].id
}

module "inbound_data_nacl_allow_rules" {
  source = "./modules/nacl_rule"
  count  = var.num_of_azs

  network_acl_id    = aws_network_acl.data.id
  rule_number_start = (local.subnet_type_multiplier["data"] * 1000 + 200 * count.index)
  egress            = false
  rule_action       = "allow"
  cidr_block        = aws_subnet.data[count.index].cidr_block
  ports             = var.extra_data_nacl_inbound_ports
}

module "inbound_data_nacl_deny_rule" {
  source = "./modules/nacl_rule"

  network_acl_id    = aws_network_acl.data.id
  rule_number_start = 32000
  egress            = false
  rule_action       = "deny"
  cidr_block        = "0.0.0.0/0"
  ports             = [0]
}

module "outbound_data_nacl_allow_rules" {
  source = "./modules/nacl_rule"
  count  = var.num_of_azs

  network_acl_id    = aws_network_acl.data.id
  rule_number_start = (local.subnet_type_multiplier["data"] * 1000 + 200 * count.index)
  egress            = true
  rule_action       = "allow"
  cidr_block        = aws_subnet.data[count.index].cidr_block
  ports             = local.data_outbound_ports
}

module "outbound_data_nacl_deny_rule" {
  source = "./modules/nacl_rule"

  network_acl_id    = aws_network_acl.data.id
  rule_number_start = 32000
  egress            = true
  rule_action       = "deny"
  cidr_block        = "0.0.0.0/0"
  ports             = [0]
}