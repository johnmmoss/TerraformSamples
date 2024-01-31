variable "enable_appconfig" {
  default     = false
  type        = bool
  description = "Enable an app config for app service"
}


variable "region" {
  default     = "ukwest"
  type        = string
  description = "The region for each resource to use"
}