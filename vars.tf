variable "REGION" {
    default = "us-west-1"
}

variable "ZONE1" {
    default = "us-west-1a" 
}

variable "ZONE2" {
    default = "us-west-1b" 
}

variable "AMIS" {
    default = "ami-0ce2cb35386fc22e9"
    }

variable "PRIV_KEY_PATH" {
  default = "mainhome"
}

variable "PUB_KEY_PATH" {
  default = "mainhome.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
    default = "99.241.84.32/32"
}

variable "rmquser" {
 default = "rabbit" 
}

variable "rmqpass" {
  default = "3%Zu6^_I~45@rT!N"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
default = "1"
}

variable "VPC_NAME" {
    default = "Infra-VPC" 
}

variable "vpcCIDR" {
  default = "172.21.0.0/16"
}

variable "PubSub1CIDR" {
  default = "172.21.1.0/24"
}

variable "PubSub2CIDR" {
  default = "172.21.2.0/24"
}
variable "PubSub3CIDR" {
  default = "172.21.3.0/24"
}
variable "PrivSub1CIDR" {
  default = "172.21.4.0/24"
}
variable "PrivSub2CIDR" {
  default = "172.21.5.0/24"
}

variable "PrivSub3CIDR" {
  default = "172.21.6.0/24"
}