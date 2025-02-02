variable "ami-id" {
    description = "The AMI id we wish to use. This should be passed down from the top level"
}

variable "top-level-prefix" {
  default = "tech4dev"
}

variable "instance-type" {
  default = "t2.micro"
}

variable "region" {
  default = "eu-west-1"
}
variable "data-dog-api-key" {}
variable "data-dog-site" {}