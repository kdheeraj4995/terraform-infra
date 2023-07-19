variable "tags" {
  type = map
  default = {
    "managedBy" = "terraform"
  }
}

output "tags" {
  value = var.tags
}