# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/example_app"
  retention_in_days = 30

  tags = {
    Name  = "example-log_group-cloudwatch_log_group"
    Project = var.project
    Owner = var.owner
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "example-log_stream-cloudwatch_log_stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}
