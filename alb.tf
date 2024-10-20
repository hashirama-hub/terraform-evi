# ---------------------------------------------------------------------------------------------------------------------
# ALB
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_alb" "EVI_alb" {
    name = "EVI-Application-LoadBalancer"
    subnets = [aws_subnet.evi_prod_public_1a.id, aws_subnet.evi_prod_public_1b.id]
    security_groups = [aws_security_group.EVI_sg_alb.id]  
}

# ---------------------------------------------------------------------------------------------------------------------
# ALB LISTENER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_alb_listener" "EVI_alb_listener" {
    
    load_balancer_arn = aws_alb.EVI_alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.EVI_alb_target_group.arn
    }
  
}

# ---------------------------------------------------------------------------------------------------------------------
# ALB TARGET GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_alb_target_group" "EVI_alb_target_group" {
    name = "EVI-Target-Group"
    port = 8080
    protocol = "HTTP"
    vpc_id = aws_vpc.evi-prod.id
    target_type = "ip"

  
}