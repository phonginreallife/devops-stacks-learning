module "frontend" {
  source = "../../modules/fe-stacks"
  
  domain_name = local.domain_name
  sub_domain_name = local.sub_domain_name
  hosted_zone_var = local.hosted_zone_name
  bucket_prefix = "tf-phong-fe"


  providers = {
    aws.acm_provider = aws.acm_provider
  }
}
