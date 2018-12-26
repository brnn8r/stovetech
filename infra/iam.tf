resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name  = "ec2-instance-profile"
  role = "${aws_iam_role.ec2_instance_role.name}"
}

resource "aws_iam_role" "ec2_instance_role" {
    name = "ec2-instance-role-policy"    
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_policy" "s3_read_write_policy" {
  name        = "s3-read-write-policy"
  path        = "/stovetech/"
  description = "read-write access to stovetech s3 buckets"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket","s3:ListBuckets"],
      "Resource": ["arn:aws:s3:::*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3_read_write_role_policy_attachment" {
    role = "${aws_iam_role.ec2_instance_role.name}"
    policy_arn = "${aws_iam_policy.s3_read_write_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_role_policy_attachment" {
    role = "${aws_iam_role.ec2_instance_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}