variable "name" { type = string }
variable "image_tag_mutability" { type = string default = "MUTABLE" }
variable "scan_on_push" { type = bool default = true }
variable "keep_last_images" { type = number default = 20 }
variable "tags" { type = map(string) default = {} }
