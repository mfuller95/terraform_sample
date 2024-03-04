resource "aws_network_acl_rule" "this" {
  
  for_each = toset(var.ports)

  network_acl_id = var.network_acl_id
  rule_number    = (index(var.ports, each.value) * 10 + var.rule_number_start)
  egress         = var.egress
  protocol       = var.protocol
  rule_action    = var.rule_action
  cidr_block     = var.cidr_block
  from_port      = each.value
  to_port        = each.value
}