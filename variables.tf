# services inputs
variable "instance-type" {
  description = "node-group instance type"
  default     = "e2-standard-4"
  type        = string
}

variable "disk-size" {
  description = "node-group diks size"
  default     = "50"
  type        = string
}

variable "num-nodes" {
  description = "node-group count"
  default     = "1"
  type        = string
}

variable "vpc-native" {
  description = "VPC native networking"
  default     = true
  type        = bool
}

variable "private-cluster" {
  description = "is private cluster"
  default     = true
  type        = bool
}

variable "zones" {
  description = "availability zones"
  type        = list(string)
  default     = []
}

variable "vpc-network" {
  description = "network name to provision the services to"
  default     = "default"
  type        = string
}

variable "subnet-cidr" {
  type        = string
  description = "cidr for a fresh gke subnet"
  default     = "10.160.100.0/24"
}

variable "version-prefix" {
  type        = string
  description = "k8s version"
}

# cloud inputs
variable "project" {
  description = "gcp project name"
  type        = string
}

variable "region" {
  description = "gcp region to deploy the services to"
  default     = "asia-south1"
  type        = string
}

variable "credentials" {
  description = "iam credentials"
  type        = string
}

# run unique identifier
variable "identifier" {
  description = "identifier to prefix to all resources created"
  default     = "yugabyte"
  type        = string
}

variable "cluster-count" {
  description = "number of GKE clusters"
  default     = "1"
  type        = string
}
