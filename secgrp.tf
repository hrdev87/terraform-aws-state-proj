resource "aws_security_group" "beanstalk-elb-sg" {
  name        = "beanstalk-elb-sg"
  description = "Security Group for Beanstalk elb"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [module.vpc]
}


resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security Group for Bastionisioner ec2 instance"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.MYIP]
  }
  depends_on = [module.vpc]
}

resource "aws_security_group" "prod-sg" {
  name        = "prod-sg"
  description = "Security Group for Beanstalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.bastion-sg.id]
  }
  depends_on = [module.vpc]
}

resource "aws_security_group" "backend-sg" {
  name        = "backend-sg"
  description = "Security Group for RDS, AciveMQ, Elastic Cache"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    security_groups = [aws_security_group.prod-sg.id]
  }

  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.bastion-sg.id]
  }
  depends_on = [module.vpc]
}

resource "aws_security_group_rule" "sec_grp_allow_itself" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend-sg.id
  source_security_group_id = aws_security_group.backend-sg.id
  depends_on               = [module.vpc]
}

