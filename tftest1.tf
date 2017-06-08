provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.ami, "${var.region}-${var.platform}")}"
  instance_type = "t2.micro"
  key_name = "notary01"
  count=2
  availability_zone = "${element(split(",", lookup(var.zones, var.region)), count.index )}"
  subnet_id = "${element(aws_subnet.private-subnet.*.id, count.index)}"

#  provisioner "local-exec" {
#    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
#  }

  tags {
    Name = "${var.tagName}-${count.index}"
    role = "app"
  }
  depends_on = [ "aws_subnet.private-subnet" ]

}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.1.id}"
  depends_on = [ "aws_instance.example" ]
}

resource "aws_vpc" "main" {
    cidr_block           = "${var.vpc_cidr_block}"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "role" = "env1"
	"Name" = "main"
    }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main_gw"
  }
}




resource "aws_subnet" "private-subnet" {
  vpc_id            = "${aws_vpc.main.id}"
  count             = 2
  cidr_block        = "${cidrsubnet(var.vpc_cidr_block, 4, count.index)}"
  availability_zone = "${element(split(",", lookup(var.zones, var.region)), count.index )}"
  map_public_ip_on_launch = false

	tags {
        "Name" = "private-${element(split(",", lookup(var.zones, var.region)), count.index)}-sn"
    }

}



output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

output "example" {
  value = "${aws_instance.example.*.id}"
}
