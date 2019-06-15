provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "/Users/alex.fernandes/.aws/credentials"
  profile                 = "default"
}

resource "aws_key_pair" "main" {
  public_key = "${file("${var.ssh_public_key_file}")}"
}

resource "aws_instance" "master" {
  count           = 1
  ami             = "${data.aws_ami.centos7.id}"
  instance_type   = "t2.xlarge"
  subnet_id       = "${aws_subnet.main.id}"
  security_groups = ["${aws_security_group.main.id}"]
  key_name        = "${aws_key_pair.main.key_name}"

  root_block_device {
    volume_size = 13
  }

  tags {
    Name    = "${var.name} Master"
    Creator = "alex.fernandes"
  }

  volume_tags {
    Name    = "${var.name} Master"
    Creator = "alex.fernandes"
  }
}

resource "aws_instance" "worker" {
  count           = 1
  ami             = "${data.aws_ami.centos7.id}"
  instance_type   = "t2.xlarge"
  subnet_id       = "${aws_subnet.main.id}"
  security_groups = ["${aws_security_group.main.id}"]
  key_name        = "${aws_key_pair.main.key_name}"

  root_block_device {
    volume_size = 13
  }

  tags {
    Name    = "${var.name} Worker ${format("%02v", count.index)}"
    Creator = "alex.fernandes"
  }

  volume_tags {
    Name    = "${var.name} Worker ${format("%02v", count.index)}"
    Creator = "alex.fernandes"
  }
}
