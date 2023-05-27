#Creating IAM ROLE for S3 ACCESS

#STEP 1: Create role
resource "aws_iam_role" "terraform_S3_IAM_Role" {
    name = "terraform_S3_IAM_Role"
    
    #assume_role_policy — (Required) The policy that grants an entity permission to assume the role.
    assume_role_policy = <<EOF
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}


##This is going to create IAM role but we can’t link this role to AWS instance and for that, /
## we need EC2 instance Profile

#STEP 2: Create EC2 Instance Profile

resource "aws_iam_instance_profile" "terraform_S3_iam_instance_profile" {
  name = "terraform_S3_iam_instance_profile"
  role = "${aws_iam_role.terraform_S3_IAM_Role.name}"
}

## Now if we execute the above code, we have Role and Instance Profile but with no permission.
## Next step is to add IAM Policies which allows EC2 instance  /
## to execute specific commands for eg: access to S3 Bucket

#STEP 3: * Adding IAM Policies
##       * To give full access to S3 bucket

resource "aws_iam_role_policy" "terraform_S3_iam_instance_policy" {
  name = "terraform_S3_iam_instance_policy"
  role = "${aws_iam_role.terraform_S3_IAM_Role.id}"
# copy and paste the json from AmazonS3FullAccess policy
 policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "s3-object-lambda:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


#STEP 4: Create EC2 insatcne and attach the S3 Role. 

resource "aws_instance" "terraform-setupServer" {
  ami = "ami-0bef6cc322bfff646"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id, aws_security_group.alb_security_group.id, aws_security_group.ssh_group.id]
  subnet_id = aws_subnet.public_subnet_az1.id
  iam_instance_profile = "${aws_iam_instance_profile.terraform_S3_iam_instance_profile.name}"
  key_name = "DK-May21"
  
}
