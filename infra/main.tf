provider "aws" {
    region = "ap-southeast-2"
}

data "aws_ami" "amazon_linux_2" {
    most_recent = true

    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn-ami-hvm-2018*"]
    }
}


resource "aws_instance" "example" {
  ami = "${data.aws_ami.amazon_linux_2.id}"
  instance_type = "t2.micro"
  user_data = "sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm"
}

