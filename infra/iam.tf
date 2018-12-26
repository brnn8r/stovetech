resource "aws_iam_instance_profile" "s3_read_write_profile" {
  name  = "s3-read-write-profile"
  role = "${aws_iam_role.s3_read_write_role.name}"
}

resource "aws_iam_role" "s3_read_write_role" {
    name = "s3-read-write-role"    
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
      "Action": ["s3:ListBucket"],
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
    role = "${aws_iam_role.s3_read_write_role.name}"
    policy_arn = "${aws_iam_policy.s3_read_write_policy.arn}"
}