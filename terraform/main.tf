module "wk2-assigment" {
  source        = "./modules/wk2-assignment"
  ami-id        = var.ami-id
  instance-type = var.instance-type

}