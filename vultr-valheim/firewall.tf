# Firewall group must exist - it's effectively a container for the rules below.
resource "vultr_firewall_group" "this" {

}


# These rules current open 2456-2458 right now.
# Not sure if 2457-8 are actually required but I've seen them references in 
# multiple places for spinning up a Valheim server, so...
resource "vultr_firewall_rule" "valheim_tcp" {
  for_each          = toset(["2456", "2457", "2458"])

  firewall_group_id = vultr_firewall_group.this.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = each.key
}

resource "vultr_firewall_rule" "valheim_udp" {
  for_each          = toset(["2456", "2457", "2458"])

  firewall_group_id = vultr_firewall_group.this.id
  protocol          = "udp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = each.key
}


# Allow pinging the instance.
resource "vultr_firewall_rule" "icmp" {
  firewall_group_id = vultr_firewall_group.this.id
  protocol          = "icmp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
}


# If you either need to SFTP to an instance, or really want to see what's going
# on inside, you can enable this rule.
# TODO: be not lazy and just make a variable
/*
resource "vultr_firewall_rule" "ssh" {
  firewall_group_id = vultr_firewall_group.this.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = 22
}
*/