resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = ["subnet-05d39aaa8cb110d57","subnet-079c819ba73cb67dc","subnet-0c3d3d4aecd24cd35","subnet-0d98cc5c4d00954a2"]

  enable_deletion_protection = false



  tags = {
    Environment = "production"
  }
}

