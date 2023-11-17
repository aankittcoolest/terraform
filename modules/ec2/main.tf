resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name

  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex

  yum install -y nginx
  echo "<h1>Hello world</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    "environment" : "dev"
  }
}