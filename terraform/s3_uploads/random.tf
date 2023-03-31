resource "random_string" "bucket_seed" {
  length  = 24
  upper   = false
  lower   = true
  special = false

  # the bucket_seed shouldn't change per deployment
  lifecycle {
    ignore_changes = all
  }
}
