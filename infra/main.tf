provider "aws" {
    region = "ap-southeast-2"
}

# data "aws_ami" "amazon_linux_2" {
#     most_recent = true

#     owners = ["amazon"]

#     filter {
#         name = "name"
#         values = ["amzn-ami-hvm-2018*"]
#     }
# }


resource "aws_instance" "test_instance" {
  ami = "ami-02fd0b06f06d93dfc"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_instance_profile.name}"
  security_groups = ["${aws_security_group.web_dmz_security_group.name}"]
  key_name = "StovesEc2KeyPair"
  user_data = "sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm"

  tags {
      Company = "StoveTech"
  }
}

