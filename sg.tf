resource "aws_security_group" "allow_http" {
  name        = "alb_http"
  description = "Allow http traffic to alb"
  vpc_id      = "vpc-0286b0e40e1e91265"

  ingress {
    description = "http for alb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_alb"
  }
}
resource "aws_security_group" "access_instances" {
  name        = "jyoticontainer_http"
  description = "Allow http traffic to container"
  vpc_id      = "vpc-0286b0e40e1e91265"

  ingress {
    description = "http for instances"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_container"
  }
}

resource "aws_security_group" "allow_http_db" {
  name        = "jyotiinstance_http"
  description = "Allow http traffic to instances"
  vpc_id      = "vpc-0286b0e40e1e91265"

  ingress {
    description = "http for db"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "ssh for mysql"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "mysql/Aurora for rds"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  
  ingress {
    description = "mysql/Aurora for rds"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.access_instances.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "for rds"
  }
}
