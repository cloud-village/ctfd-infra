resource "random_string" "secret_key" {
  length  = 16
  upper   = true
  lower   = true
  special = true

  # there's probably a better way to do this
  # the secret key shouldn't really per deployment, and 
  # it shouldn't be managed manually :expressionless:
  lifecycle {
    ignore_changes = all
  }
}
