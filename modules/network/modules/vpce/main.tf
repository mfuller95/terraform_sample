resource "aws_vpc_endpoint" "this" {
  
  service_name       = "com.amazonaws.${var.region}.${var.service}"
  subnet_ids         = var.subnet_ids
  vpc_endpoint_type  = var.endpoint_type
  vpc_id             = var.vpc_id
  
}