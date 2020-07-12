data "http" "myip" {
  url = "http://ifconfig.me"
}

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

  vpc_security_group_ids = [aws_security_group.inbound_from_alb.id, aws_security_group.admin.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ctfd"
    }
  }

  user_data = filebase64("${path.module}/../../packer/setup.sh") #FIXME use better path management
}


resource "aws_security_group" "inbound_from_alb" {
  name        = "inbound_from_alb"
  description = "Allow inbound traffic from the ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "inbound from alb"
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    self            = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "inbound_from_alb"
  }
}


resource "aws_security_group" "admin" {
  name        = "inbound_for_admin"
  description = "Allow inbound ssh for admin"
  vpc_id      = var.vpc_id

  ingress {
    description = "inbound from alb"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "inbound_for_admin"
  }
}

