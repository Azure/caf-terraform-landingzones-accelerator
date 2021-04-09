# Flux Variables 

variable "flux_namespace" {
  type        = string  
  default     = ""
}

variable "flux_auth_secret" {
  type        = string  
  default     = ""
}

variable "github_owner" {
  type        = string
  description = "github owner"
  default     = ""
}

variable "github_token" {
  type        = string
  description = "github token"
  default     =  ""
}


variable "repository_name" {
  type        = string
  description = "github repository name (without owner)"
  default     =  ""
}

variable "repository_visibility" {
  type        = string
  description = "how visible is the github repo"
  default     =  ""
}

variable "branch" {
  type        = string
  description = "branch name"
  default     =  ""
}

variable "target_install_path" {
  type        = string
  description = "flux install target path"
  default     =  ""
}

variable "target_sync_path" {
  type        = string
  description = "flux sync target path"
  default     =  ""
}

variable "k8s_configPath" {
  type        = string
  default     =  ""
}


