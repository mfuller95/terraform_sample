variable "name" {
  description = "The name of the VPC"
  type         = string
}

variable "vpc_cidr_block" {
  description = "The CIDE Block for the VPC"
  type        = string

  validation {
    condition     = substr(var.vpc_cidr_block, -3, -1) == "/16"
    error_message = "Cidr block subnet mask must be /16."
  }
}

variable "num_of_azs" {
  description = "The number of availabilty zones we want to enable."
  type        = number

  validation {
    condition     = var.num_of_azs >= 1 && var.num_of_azs <= 3
    error_message = "The number of AZs must be between 1 and 3."
  }
}

variable "extra_public_nacl_inbound_ports" {
  description = "A list of extra inbounds ports to allow in the public NACL."
  type        = list(number)
  default     = []
}

variable "extra_public_nacl_outbound_ports" {
  description = "A list of extra outbount ports to allow in the public NACL."
  type        = list(number)
  default     = []
}

variable "extra_private_nacl_inbound_ports" {
  description = "A list of extra inbounds ports to allow in the private NACL."
  type        = list(number)
  default     = []
}

variable "extra_private_nacl_outbound_ports" {
  description = "A list of extra outbound ports to allow in the private NACL."
  type        = list(number)
  default     = []
}

variable "extra_data_nacl_inbound_ports" {
  description = "A list of extra inbounds ports to allow in the data NACL."
  type        = list(number)
  default     = []
}

variable "extra_data_nacl_outbound_ports" {
  description = "A list of extra outbounds ports to allow in the data NACL."
  type        = list(number)
  default     = []
}

variable "vpc_endpoint_services" {
  description = "A list of AWS services to create VPC endpoints for."
  type        = list(string)
  default     = []
}