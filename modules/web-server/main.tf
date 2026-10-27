
# Look up the latest Amazon Linux 2023 AMI
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}



# Create the EC2 web server
resource "aws_instance" "web" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  # Require IMDSv2 for instance metadata security
  metadata_options {
    http_tokens = "required"
  }



  # Configure encrypted root storage
  root_block_device {
    encrypted             = true
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
  }



  # Install Nginx and create a basic website on first boot
  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    dnf install -y nginx

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!doctype html>
    <html>
      <head><title>Terraform AWS Web App</title></head>
      <body>
        <h1>It works!</h1>
        <p>Deployed with Terraform on AWS.</p>
      </body>
    </html>
    HTML

    systemctl enable --now nginx
  EOF

  user_data_replace_on_change = true

  tags = {
    Name    = "${var.project_name}-web-server"
    Project = var.project_name
  }
}
