resource "vultr_instance" "this" {
  count             = var.servers

  label             = (var.servers == 1) ? var.server_name : "${var.server_name} - ${count.index}"
  plan              = var.plan
  region            = var.region
  os_id             = "387" # Ubuntu 20.04, ID came from the Vultr CLI tool
  firewall_group_id = vultr_firewall_group.this.id
  script_id         = element(vultr_startup_script.this.*.id, count.index)
}

# It hurts my OCD to create multiple of these when they're 99% the same
resource "vultr_startup_script" "this" {
  count  = var.servers

  name   = "startup"
  script = base64encode(templatefile("${path.module}/data/startup.tpl", { server_name = (var.servers == 1) ? var.server_name : "${var.server_name} - ${count.index}", world_name = var.world_name, password = var.password, access_key = vultr_object_storage.this.s3_access_key, secret_key = vultr_object_storage.this.s3_access_key }))
}
