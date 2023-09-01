module "ec2" {
    source        ="https://github.com/Aman960007/ec2-simple-module.git?ref=main"
    ami           = var.ami
    instance_type = var.instance_type
    tags = {
    Name = "HelloWorld"
  }
}


variable "instance_type" {
  description = "Name of the instance"
  type = string
  default = ""
}

variable "ami" {
  description = "name of the ami"
  type = string
  default = ""
}

instance_type="t2.micro"
ami="ami-08a52ddb321b32a8c"

