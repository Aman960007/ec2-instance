module "ec2" {
    source        ="https://github.com/Aman960007/ec2-simple-module.git?ref=main"
    ami           = var.ami
    instance_type = var.instance_type
    tags = {
    Name = "HelloWorld"
  }
}



