# output "availability-zones" {
#   value = can(module.wk2-assigment.availability-zones)

# }
# output "ami" {
#   value = can(module.wk2-assigment.ami)

# }

output "lb-dns" {
  value = module.wk2-assigment.lb-dns
}