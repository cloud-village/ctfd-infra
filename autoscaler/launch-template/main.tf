resource "aws_launch_template" "ctfd" {
  name = "ctfd-template"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  credit_specification {
    cpu_credits = "standard"
  }

  ebs_optimized = true


  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  image_id = var.image_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t3.micro"

  key_name = var.key_name

  monitoring {
    enabled = true
  }

  placement {
    availability_zone = var.availability_zone
  }

  vpc_security_group_ids = [var.vpc_security_group_ids]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ctfd"
    }
  }

  user_data = filebase64("${path.module}/../../packer/setup.sh") #FIXME use better path management
}

