

output "node_public_ips" {
  value       = { for k, v in aws_instance.ec2 : k => v.public_ip }
  description = "Public IPs of the Kubernetes nodes"
}

# data "template_file" "hosts_yml_content" {
#   template = <<-EOT
#   ---
#   all:
#     children:
#       nodes:
#         hosts:
#           %s
#   EOT

#   vars = {
#     nodes = join("\n", flatten([
#       for idx, ip in aws_instance.ec2 :
#       idx == 0 ? "master: ${ip.public_ip}" : "worker: ${ip.public_ip}"
#     ]))
#   }
# }

# resource "local_file" "hosts_yml" {
#   filename = "${path.module}/../ansible/playbooks/../install_k8s/hosts_tf.yml"
#   content  = data.template_file.hosts_yml_content.rendered
# }