resource "aws_instance" "bastion-host" {
  ami                    = var.AMIS
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.sshkey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tags = {
    name    = "bastion-host"
    project = "aws-terraform-state"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/dbdeploy.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/dbdeploy.sh", "sudo /tmp/dbdeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.rds]
}