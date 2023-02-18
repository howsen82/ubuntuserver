provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "my-server-1" {
  ami = "ami-0753e0e42b20e96e3" # Refer https://cloud-images.ubuntu.com/locator/ec2/
  associate_public_ip_address = true
  instance_type = "t2.nano"
  key_name = "steven_ssh"
  vpc_security_group_ids = [ "sg-9c6394e5" ]
  tags = {
    "Name" = "Web Server 1"
  }
}