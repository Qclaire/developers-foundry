# output "availability-zones" {
#   value = can(module.wk2-assigment.availability-zones)

# }
# output "ami" {
#   value = can(module.wk2-assigment.ami)

# }

# output "lb-dns" {
#   value = try(module.wk2-assigment, "lb-dns")
# }

output "public_ip" {
  value = module.ec2.public_ip
}