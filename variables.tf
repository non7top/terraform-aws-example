variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}
variable "platform" {
  default = "centos7"
}

variable "ami" {
description = "AWS AMI Id, if you change, make sure it is compatible with instance type, not all AMIs allow all instance types "
default = {
us-east-1-ubuntu = "ami-fce3c696"
us-east-2-ubuntu = "ami-b7075dd2"
us-west-1-ubuntu = "ami-a9a8e4c9"
us-west-2-ubuntu = "ami-9abea4fb"
eu-west-1-ubuntu = "ami-47a23a30"
eu-central-1-ubuntu = "ami-accff2b1"
ap-northeast-1-ubuntu = "ami-90815290"
ap-northeast-2-ubuntu = "ami-58af6136"
ap-southeast-1-ubuntu = "ami-0accf458"
ap-southeast-2-ubuntu = "ami-1dc8b127"
us-east-1-rhel6 = "ami-0d28fe66"
us-east-2-rhel6 = "ami-aff2a9ca"
us-west-2-rhel6 = "ami-3d3c0a0d"
us-east-1-centos6 = "ami-57cd8732"
us-east-2-centos6 = "ami-c299c2a7"
us-west-2-centos6 = "ami-1255b321"
us-east-1-rhel7 = "ami-2051294a"
us-east-2-rhel7 = "ami-0a33696f"
us-west-2-rhel7 = "ami-775e4f16"
us-east-1-centos7 = "ami-6d1c2007"
us-east-2-centos7 = "ami-6a2d760f"
us-west-1-centos7 = "ami-af4333cf"
eu-west-1-centos7 = "ami-7abd0209"
}
}

variable "vpc_cidr_block" {
  default = "172.31.0.0/16"
}

variable "zones" {
    default = {
        "us-west-1" = "us-west-1b,us-west-1c"
        "us-west-2" = "us-west-2a,us-west-2b,us-west-2c"
        "us-east-1" = "us-east-1c,us-east-1d,us-east-1e"
        "eu-west-1" = "eu-west-1c,eu-west-1b"
        # use "aws ec2 describe-availability-zones --region us-east-1"
        # to figure out the name of the AZs on every region
    }
}

variable "tagName" {
  default = "test"
}
