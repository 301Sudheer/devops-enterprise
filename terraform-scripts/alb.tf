resource "aws_lb" "vprofile" {
  name               = "vprofile-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_subnets[1].id, aws_subnet.public_subnets[0].id]
}
# Create a target group
resource "aws_lb_target_group" "vprofile" {
  name        = "vprofile-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vprofileapp_vpc.id  
  target_type = "instance"
  health_check {
    path                = "/"  
    protocol            = "HTTP"
    matcher             = "200-299"  
    interval            = 30  
    timeout             = 10 
    healthy_threshold   = 3 
    unhealthy_threshold = 2  
  }
}
# Create a listener
resource "aws_lb_listener" "vprofile" {
  load_balancer_arn = aws_lb.vprofile.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vprofile.arn
  }
}
# Register instances with the target group
resource "aws_lb_target_group_attachment" "vprofile" {
  target_group_arn = aws_lb_target_group.vprofile.arn
  target_id        = aws_instance.vprofileapp_instance.id  
  port             = 8080
}