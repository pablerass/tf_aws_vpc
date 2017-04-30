resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags = "${merge(var.tags, map("Name", var.name), map("Module", var.module))}"
}

resource "aws_internet_gateway" "main" {
  count = "${length(var.public_subnets_cidr_blocks) == 0 ? 0 : 1}"

  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_eip" "private_nat" {
  count = "${length(var.private_subnets_cidr_blocks)}"

  vpc    = true
}

resource "aws_nat_gateway" "private" {
  count = "${length(var.private_subnets_cidr_blocks)}"

  allocation_id = "${element(aws_eip.private_nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.private.*.id, count.index)}"
}
