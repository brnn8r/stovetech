resource "aws_launch_template" "default_launch_template" {
    name = "default-launch-template"
    iam_instance_profile = {        
        arn = "${aws_iam_instance_profile.ec2_instance_profile.arn}"
    }
    image_id = "ami-02fd0b06f06d93dfc"
    instance_initiated_shutdown_behavior = "terminate"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.web_dmz_security_group.id}"]
    user_data = "${base64encode("sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm")}"

}


resource "aws_autoscaling_group" "default_autoscaling_group" {
  availability_zones = ["ap-southeast-2a", "ap-southeast-2c"]
  desired_capacity   = 0
  max_size           = 6
  min_size           = 0

    mixed_instances_policy = {
      launch_template = {
        launch_template_specification = {
            launch_template_id = "${aws_launch_template.default_launch_template.id}"
            version = "$$Latest"
        }

          override = {
            instance_type = "t2.micro"
          }

          override = {
            instance_type = "t3.micro"
          }

          override = {
            instance_type = "t3.small"
          }

          override = {
            instance_type = "t2.small"
          }
      }      
                              
      instances_distribution = {
        on_demand_base_capacity = 1
        on_demand_percentage_above_base_capacity = 100
        spot_instance_pools = 4
      }

      
      
    }
    
  lifecycle = {
      create_before_destroy = true
      ignore_changes = ["desired_capacity"]
  }

}