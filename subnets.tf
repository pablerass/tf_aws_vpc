resource "aws_subnet" "public" {
  count = "${length(var.public_subnets_cidr_blocks)}"

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.public_subnets_cidr_blocks, count.index)}"
  availability_zone = "${data.aws_region.current.name}${element(var.letters, count.index)}"

  tags = "${merge(var.tags, map("Name", format("public-%s", count.index + 1)), map("Module", var.module))}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags = "${merge(var.tags, map("Name", format("public-%s", count.index + 1)), map("Module", var.module))}"
}

resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets_cidr_blocks)}"

  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_subnet" "private" {
  count = "${length(var.private_subnets_cidr_blocks)}"

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.private_subnets_cidr_blocks, count.index)}"
  availability_zone = "${data.aws_region.current.name}${element(var.letters, count.index)}"

  tags = "${merge(var.tags, map("Name", format("private-%s", count.index + 1)), map("Module", var.module))}"
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.private.id}"
  }

  tags = "${merge(var.tags, map("Name", format("private-%s", count.index + 1)), map("Module", var.module))}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnets_cidr_blocks)}"

  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
