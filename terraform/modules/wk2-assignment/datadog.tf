# module "datadog_forwarders" {
#   source  = "terraform-aws-modules/datadog-forwarders/aws"

#   kms_alias             = "alias/datadog"
#   dd_api_key = var.data-dog-api-key
#   dd_site = var.data-dog-site

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }