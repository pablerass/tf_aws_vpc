variable "name" {
}

variable "cidr_block" {
}

variable "public_subnets_cidr_blocks" {
  description = "Public subnet CIDRs"
  default = []
}

variable "private_subnets_cidr_blocks" {
  description = "Private subnet CIDRs"
  default = []
}
