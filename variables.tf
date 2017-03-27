variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  default = []
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  default = []
}

variable "letters" {
  description = "Letter list for AZ calculation"
  default = ["a", "b", "c"]
}

variable "module" {
  description = "Terraform module"
  default     = "tf_aws_vpc"
}

variable "tags" {
  description = "Resource tags"
  default     = {}
}
