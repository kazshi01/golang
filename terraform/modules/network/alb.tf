resource "aws_lb" "alb" {
  name               = "${var.name}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.storage.public_subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = var.environment
  }
}

# HTTPSリスナー（ポート443）
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06" # 任意でSSLポリシーを指定
  certificate_arn   = aws_acm_certificate.tokyo_cert.arn    # ACMなどから取得した証明書のARN

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_target_ip.arn
  }
}

# HTTPSへのリダイレクト（ポート80）
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
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

resource "aws_lb_target_group" "blue_target_ip" {
  name        = "${var.name}-bule-target-ip"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.storage.vpc_id

  health_check {
    enabled             = true
    interval            = 180
    path                = "/health"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "green_target_ip" {
  name        = "${var.name}-green-target-ip"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.storage.vpc_id

  health_check {
    enabled             = true
    interval            = 180
    path                = "/health"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
  }
}
