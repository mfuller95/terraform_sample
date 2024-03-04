variable "service" {
  description = "The name of the AWS to create a VPC endpoint for"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy VPC endpoint into"
  type        = string
}

variable "region" {
  description = "The region to deploy the VPC endpoint into"
  type        = string
}

variable "endpoint_type" {
  description = "The type of VPC endpoint to deploy"
  type        = string

  validation {
    condition     =  contains(["Gateway", "GatewayLoadBalancer", "Interface"], var.endpoint_type)
    error_message = "The endpoint type must be one of 'Gateway', 'GatewayLoadBalancer' or 'Interface'."
  }
}

variable "subnet_ids" {
  description = "value"
  type        = list(string)
  default     = []
}

variable "route_table_ids" {
  description = "value"
  type        = list(string)
  default     = []
}