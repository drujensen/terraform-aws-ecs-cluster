resource "aws_ecs_cluster" "main" {
  name = "example-main-ecs_cluster"

  tags = {
    Name  = "example-main-ecs_cluster"
    Project = var.project
    Owner = var.owner
  }
}

data "template_file" "example_app" {
  template = file("./templates/ecs/example_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "example-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.example_app.rendered

  tags = {
    Name  = "example-app-ecs_task_definition"
    Project = var.project
    Owner = var.owner
  }
}

resource "aws_ecs_service" "main" {
  name            = "example-main-ecs_service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "example_app"
    container_port   = var.app_port
  }

  tags = {
    Name  = "example-main-ecs_service"
    Project = var.project
    Owner = var.owner
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
