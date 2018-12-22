output "amazon_linux_2_version" {
  value = "${data.aws_ami.amazon_linux_2.id}"
}
