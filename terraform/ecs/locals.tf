locals {
  # if name_override is not provided, use "ctfd", else append name_override to "ctfd"
  name = var.name_override == "" ? "ctfd" : "ctfd-${var.name_override}"
}
