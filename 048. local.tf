provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "my-server-1" {
  ami = "ami-0753e0e42b20e96e3"
  associate_public_ip_address = "true"
  instance_type = "t2.nano"
  key_name = "steven_ssh"
  vpc_security_group_ids = [ "${aws_security_group.external_access.id}" ]
  user_data = file("bootstrap.sh")
  tags = {
    "Name" = "Web Server 1"
  }
}

resource "aws_security_group" "external_access" {
  name = "my_sg"
  description = "Allow OpenSSH and Apache"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "173.10.59.105/32" ]
    description = "Home Office IP"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "173.10.59.105/32" ]
    description = "Home Office IP"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}