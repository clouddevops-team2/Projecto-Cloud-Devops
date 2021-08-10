provider "aws" { #definir el proveedor cloud
    region = "sa-east-1" #Definir la región a gestionar
    access_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxx"
    secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"

}

resource "aws_instance" "terraform-test" { #Crear una instancia
    ami = "ami-054a31f1b3bf90920" #Seleccionar la AMI correspondiente a la región (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type)
    instance_type = "t2.micro"
    tags = {
      "Name" = "terraform-test"
      "mgmt" = "auto-managed"
      "date" = "05-08-2021"
    }    
}

resource "aws_security_group" "example_rules" { #Crear un grupo de seguridad
    name = "security-group-terraform-tcp" #Nombre de la regla
    description = "Permitir TCP-SSH"
    ingress = [{
        description = "SSH Access"
        from_port = 60022 #SSH
        to_port = 60022 #SSH
        protocol = "tcp" #TCP
        cidr_blocks = ["18.65.127.36/32"] #Se pueden agregar varias direcciones en lista ["18.65.127.36/32","18.65.137.11/32"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false

    }]
      egress = [{
          description ="All traffic"
          from_port= 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
          prefix_list_ids = []
          security_groups = []
          self = false
    }]
}
