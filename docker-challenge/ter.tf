terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

provider "docker" {}



resource "docker_image" "simplegoservice" {
  name         = "registry.gitlab.com/alta3/simplegoservice"
  keep_locally = true       // keep image after "destroy"
}

resource "docker_container" "simplegoservice" {
  image = docker_image.simplegoservice.image_id
  name  = var.container_name
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}


variable "internal_port" {
  description = "val of int port num"
  # basic types include string, number and bool
  type        = number
  default     = 9876
}

variable "external_port" {
  description = "val of ext port num"
  # basic types include string, number and bool
  type        = number
  default     = 5432
}

variable "container_name" {
  description = "Value of the name for the Docker container"
  # basic types include string, number and bool
  type        = string
  default     = "AltaResearchWebService"
}
