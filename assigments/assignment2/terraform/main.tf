# module "wk2-assigment" {
#   source        = "./modules/wk2-assignment"
#   ami-id        = var.ami-id
#   instance-type = var.instance-type
#   region        = var.region
#   data-dog-api-key = var.data-dog-api-key
#   data-dog-site = var.data-dog-site
# }

module "ec2" {
  source = "./modules/ec2-standalone"
  ami-id        = var.ami-id
  instance-type = var.instance-type
  region        = var.region
  data-dog-api-key = var.data-dog-api-key
  data-dog-site = var.data-dog-site
}