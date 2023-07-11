# Create an Auto Scaling Group
resource "aws_autoscaling_group" "vprofile" {
  name                 = "vprofile-asg"
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.public_subnets[1].id,aws_subnet.public_subnets[0].id]
  target_group_arns    = [aws_lb_target_group.vprofile.arn]
  launch_template {
    id      = aws_launch_template.vprofile.id
    version = "$Latest"
  }
   tag {
    key                 = "Name"
    value               = "VProfileApp_Prod"
    propagate_at_launch = true
  }

}
# Create a Launch Template
resource "aws_launch_template" "vprofile" {
  name        = "vprofile-launch-template"
  description = "Launch Template for Auto Scaling Group"
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.public_sg.id]
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "VprofileApp_Prod"
    }
  }
  image_id        =  "ami-01b00b6482ae2109f"  # Replace with your desired AMI ID
  instance_type   = "t2.micro"  # Replace with your desired instance type
}