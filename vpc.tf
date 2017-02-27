resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.vpc_name}"
    Module = "${var.module}"
  }
}

/* Gateways */
resource "aws_internet_gateway" "default" {
  vpc_id = "{aws_vpc.default.id}"
}

resource "aws_eip" "private_a_nat" {
  vpc = true
}

resource "aws_nat_gateway" "private_a" {
  allocation_id = "${aws_eip.private_a_nat.id}"
  subnet_id = "${aws_subnet.private_a.id}"

  depends_on = ["aws_internet_gateway.default"]
}

/* Subnets */
resource "aws_subnet" "public_a" {
  tags {
    Name = "public-1"
    Module = "${var.module}"
  }
}

resource "aws_route_table" "public_a" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "public-a"
    Module = "${var.module}"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.public_a.id}"
}

resource "aws_subnet" "private_a" {
  tags {
    Name = "private-a"
    Module = "${var.module}"
  }
}

resource "aws_route_table" "private_a" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gatewau.private_a.id}"
  }

  tags {
    Name = "private-a"
    Module = "${var.module}"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id = "${aws_subnet.public_a .id}"
  route_table_id = "${aws_route_table.public_a.id}"
}
