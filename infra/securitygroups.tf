resource "aws_security_group" "web_dmz_security_group" {
    name = "web-dmz"
    description = "web site dmz security group"
}

resource "aws_security_group_rule" "allow_ssh_in" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.web_dmz_security_group.id}"
}

resource "aws_security_group_rule" "allow_http_in" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.web_dmz_security_group.id}"
}

resource "aws_security_group_rule" "allow_https_in" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.web_dmz_security_group.id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.web_dmz_security_group.id}"
}