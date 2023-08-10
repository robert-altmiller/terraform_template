variable "cluster_name" {
  description = "A name for the cluster."
  type        = string
  default     = "my-cluster"
}

variable "cluster_autotermination_minutes" {
  description = "How many minutes before automatically terminating due to inactivity."
  type        = number
  default     = 60
}

variable "cluster_num_min_workers" {
  description = "The number of workers."
  type        = number
  default     = 1
}

variable "cluster_num_max_workers" {
  description = "The number of workers."
  type        = number
  default     = 4
}