################################ 1. main.tf ####################################
variable "region" {
    default = "us-east-1"
    description = "AWS region"
    type            = string
  
}

variable "access_key" {
    default = ""
    description = "AWS access key"
    type            = string
  
}

variable "secret_key" {
    default = ""
    description = "AWS secret key"
    type            = string
  
}

################################ END####################################

################################ 2. compute.tf ####################################
# 1.vpc 2. internet gateway 3. subnets 4. route table

variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
    description = "VPC CIDR BLOCK"
    type            = string
  
}

##############################4.S3#########################
