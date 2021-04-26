module "vultr_valheim" {
  source      = "./vultr-valheim"

  server_name = "Incredibly punny server name"
  world_name  = "Very clever world name"
  password    = "this is a strong password 12309"
  servers     = 1
}
