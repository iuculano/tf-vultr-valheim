variable "plan" {
  type        = string
  default     = "vc2-2c-4gb"
  description = "The instance plan to use."
}

variable "region" {
  type        = string
  default     = "ewr"
  description = "The region to launch instances in."
}

variable "server_name" {
  type        = string
  default     = "ServerName"
  description = "The server's name."
}

variable "world_name" {
  type        = string
  default     = "WorldName"
  description = "The name of the world."
}

variable "password" {
  type        = string
  default     = "Password"
  description = "The server's password."
}

variable "servers" {
  type        = number
  default     = 1
  description = "The number of servers to create."
}
