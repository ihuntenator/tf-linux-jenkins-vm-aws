resource "aws_instance" "jenkins" {
  ami             = lookup(var.amis, var.region) 
  subnet_id       = var.subnet 
  security_groups = var.securityGroups 
  key_name        = var.keyName 
  instance_type   = var.instanceType 
  
  tags = {
    Name = var.instanceName
  }

  volume_tags = {
    Name = var.instanceName
  }

  connection {
    type        = "ssh"
    user        = "centos"
    private_key = file(var.keyPath)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade",
      "sudo yum install jenkins java-1.8.0-openjdk-devel -y",
      "sudo systemctl daemon-reload",
      "sudo systemctl start jenkins",
      "sudo yum install git -y",
      "sudo service jenkins start",
      "sudo chkconfig jenkins on",
      "sudo wget -O /tmp/terraform_0.14.0_linux_amd64.zip  https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_linux_amd64.zip",
      "sudo unzip /tmp/terraform_0.14.0_linux_amd64.zip",
      "sudo cp /tmp/terraform /usr/bin/terraform",
    ]
  }
} 
