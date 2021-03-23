resource "aws_instance" "web" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  subnet_id   = "subnet-079c819ba73cb67dc"
  vpc_security_group_ids = [aws_security_group.allow_http_instances.id]
  key_name = "webserverkey"
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo service httpd start",
      "sudo chkconfig httpd on"
    ]

    connection {
    type     = "ssh"
    user     = "ec2-user"
    host     = aws_instance.web.public_ip
    private_key = file("${path.module}/webserverkey.pem")
  }  
    
}
}