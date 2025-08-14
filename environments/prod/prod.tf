
locals {
  env         = "prod"
  project     = "micro"
  region_zone = "Mexico Central"
}

module "app_service" {
  source = "../../modules/00-base"

  env         = local.env
  project     = local.project
  region_zone = local.region_zone

}


module "app_service2" {
  source      = "../../modules/01-app-service"
  rg_name     = module.app_service.rg_name
  env         = local.env
  project     = local.project
  region_zone = local.region_zone

}





