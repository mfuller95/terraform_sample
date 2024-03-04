NACL Rule Module
===========

This terraform modules provides the basics for setting up a new VPC. It includes
- AWS VPC
- A 3 tiered subnet setup (Public, Private and Data) with the ability to deploy to multiple AZs
- Route tables
- NACL that allows 80 & 443 through each tier by default with the ability to add more ports as needed
- The ability to deploy VPC endpoints as needed

Module Input Variables
----------------------

- `network_acl_id` - The network acl id to add tules to
- `rule_number_start` - The rule number to start with
- `egress` - Is this rule for the outbound traffic
- `protocol` - The protocal
- `rule_action` - Allow or Deny traffic
- `cidr_block` - The cidr block for the rule
- `ports` - The ports we want to creat rules for

Usage
-----

```hcl
module "demo" {
  source = "./modules/nacl_rule"

  network_acl_id    = "some_nacl_id"
  rule_number_start = "1000"
  egress            = false
  rule_action       = "allow"
  cidr_block        = "10.0.0.0/24"
  ports             = [80, 443]
}
```


Outputs
=======

Authors
=======

mfuller95@gmail.com
