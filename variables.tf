variable "cluster" {
  type = string
  description = "Name of the Strimzi cluster to use"
}

variable "name" {
  type = string
  description = "Name of the topic to create"
}

variable "namespace" {
  type = string
  description = "Namespace of use to store confimap and secrets"
}

variable "replicas" {
  type = number
  description = "Number of replicas"
  default = 1
}

variable "partitions" {
  type = number
  description = "Number of partitions"
  default = 1
}

