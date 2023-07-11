resource "aws_codedeploy_app" "vprofile_app" {
  name    = "vprofile-new-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "prod_deployment_group" {
  app_name            = aws_codedeploy_app.vprofile_app.name
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  deployment_group_name = "prod-deployment-group"
  service_role_arn    = aws_iam_role.vprofile-app-role.arn
  
  deployment_style {
    deployment_type = "IN_PLACE"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  autoscaling_groups = [aws_autoscaling_group.vprofile.name]
  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.vprofile.name
    }
  }
}
