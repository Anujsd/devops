provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0005e0cfe09cc9050"
   instance_type = "t2.micro"
   key_name = "abc"

   connection {
        type     = "ssh"
        user     = "ec2-user"
        private_key = file("./abc.pem")
        host     = self.public_ip
    }

    provisioner "remote-exec" {
        on_failure = continue

        inline = [
            "sudo yum install -y nginx",
            "sudo systemctl start nginx"
        ]
    }

    provisioner "remote-exec" {
        on_failure = continue
        when    = destroy

        inline = [
            "sudo yum remove -y nginx"
        ]
    }

    provisioner "local-exec" {
        command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"
    }

    tags = {
        Name = "nginx-server"
    }
}
