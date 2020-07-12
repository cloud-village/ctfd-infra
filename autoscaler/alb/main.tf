resource "aws_lb" "ctfd_alb" {
  name               = "ctfd-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = var.alb_logs_bucket_name
    prefix  = "ctfd-alb"
    enabled = true
  }
}

resource "aws_lb_target_group" "ctfd_target_group" {
  name     = "ctfd-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "https_forward" {
  load_balancer_arn = aws_lb.ctfd_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ctfd_target_group
  }
}

resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.ctfd_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
