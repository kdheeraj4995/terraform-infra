variable "tags" {
  type = map
}

variable "local_tags" {
  type = map
  default = {
    application: "terraform"
  }
}