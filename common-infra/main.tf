module "variables" {
  source = "./variables"
}

module "s3" {
  source = "./s3"
  tags = module.variables.tags
}

module "dynamodb" {
  source = "./dynamodb"
  tags = module.variables.tags
}

module "iam" {
  source = "./iam"
}