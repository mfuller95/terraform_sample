variable "network_acl_id" {
  type = string
  description = ""
}

variable "rule_number_start" {
  type = number
  description = "value"
}

variable "egress" {
  type = bool
  description = "value"
}

variable "protocol" {
  type = string
  description = "value"
  default = "tcp"

  validation {
    condition     = contains(["tcp", "udp"], var.protocol)
    error_message = "rule_action must be either tcp or udp."
  }
}

variable "rule_action" {
  type = string
  description = "value"

  validation {
    condition     = contains(["allow", "deny"], var.rule_action)
    error_message = "rule_action must be either allow or deny."
  }
}

variable "cidr_block" {
  type = string
  description = "value"
}

variable "ports" {
  type = list(string)
  description = "value"
}

