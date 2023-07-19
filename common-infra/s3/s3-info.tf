variable "s3-info" {
  type    = map
  default = {
    kops-k8-cluster-state : {
      name = "kops-k8-cluster-state"
      bucket-tags = {
        application : "kops"
      }
    }
    application-infra-terraform-state : {
      name = "application-infra-terraform-state"
      bucket-tags = {
        application : "terraform"
      }
    }
  }
}