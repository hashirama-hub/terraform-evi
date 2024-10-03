resource "aws_alb" "EVI_alb" {
    name = "EVI Application LoadBalancer"
    subnets = [aws_subnet.evi_prod_public_1a, aws_subnet.evi_prod_public_1b]
    security_groups = [aws_security_group.EVI_sg_alb.id]
    internal = false
    ip_address_type = ipv4
    
  
}

resource "aws_alb_listener" "EVI_alb_listener" {
    load_balancer_arn = aws_alb.EVI_alb.arn]
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = 
    }
  
}

resource "aws_alb_target_group" "EVI_alb_target_group" {
  
}