# Shree Ganeshayah Namah

resource "aws_alb" "alb" {
  drop_invalid_header_fields = true
  enable_http2               = true
  internal                   = false
  load_balancer_type         = "application"
  name                       = var.alb_name
  subnets                    = var.alb_subnets
  security_groups            = var.alb_sgs
}

resource "aws_alb_target_group" "alb_tg" {
  name                          = var.tg_name
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "instance"
  protocol                      = "HTTP"
  port                          = var.app_port
  vpc_id                        = var.vpc_id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.id
  certificate_arn   = var.certificate_arn
  protocol          = "HTTPS"
  port              = 443
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    forward {
      target_group {
        arn = aws_alb_target_group.alb_tg.arn
      }
    }
    type = "forward"
  }
}

resource "aws_alb_target_group_attachment" "v2_app_tg" {
  for_each         = toset(var.instances_to_attach)
  target_group_arn = aws_alb_target_group.alb_tg.arn
  target_id        = each.value
}
