variable "domain_name" {
  type        = string
  description = "Name of the OpenSearch Domain"
}

variable "engine_version" {
  type        = string
  description = "Opensearch version"
}

variable "instance_type" {
  type        = string
  description = "Instance Type for the cluster"
}

variable "instance_count" {
  type        = number
  description = "Number of your nodes"
}

variable "ebs_enabled" {
  type        = bool
  description = "Enable using EBS-Volume or not"
  default     = true
}

variable "ebs_iops" {
  type        = number
  description = "IOPS for EBS"
  default     = 3000
}

variable "ebs_throughput" {
  type        = number
  description = "Throughput for EBS"
  default     = 125
}

variable "ebs_volume_size" {
  type        = number
  description = "Volume Size of your EBS"
  default     = 10
}

variable "ebs_volume_type" {
  type        = string
  description = "Type of your EBS volume"
  default     = "gp3"
}

variable "subnet_ids" {
  type        = set(string)
  description = "Your Subnet IDs "
}

variable "vpc_id" {
  type        = string
  description = "Your VPC ID "
}

variable "cidr_blocks_from_pods" {
  type        = set(string)
  description = "Allow from kubernetes pods"
}

variable "parameter_name" {
  type        = string
  description = "Parameter Name for storing the master password in the Parameter Store"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "enable_saml" {
  type        = bool
  description = "enable SAML for Opensearch Dashboard"
  default     = false
}

variable "idp_entity_id" {
  type        = string
  description = "Your identity provider id"
  default     = null
}

variable "metadata_file" {
  type        = string
  description = "The file received from your identity provider (e.g. Keycloak)"
  default     = null
}

variable "master_user_name" {
  type        = string
  description = "Specify the user that should have full admin rights"
  default     = ""
}

variable "dedicated_master_enabled" {
  type        = bool
  description = "Enable or disable dedicated master"
  default     = false
}

variable "advanced_security_options" {
  type        = bool
  description = "Enable advanced security options"
  default     = true
}

variable "anonymous_auth_enabled" {
  type        = bool
  description = "Enable or disable anonymous authentication"
  default     = false
}
variable "internal_user_database_enabled" {
  type        = bool
  description = "Enable or disable internal user database"
  default     = true
}

variable "encrypt_at_rest" {
  type        = bool
  description = "Enable or disable encryption at rest"
  default     = true
}

variable "node_to_node_encryption" {
  type        = bool
  description = "Enable or disable node to node encryption"
  default     = true
}

variable "software_update_options" {
  type        = bool
  description = "Enable or disable the auto software updates"
  default     = true
}

variable "tls_security_policy" {
  type        = string
  description = "TLS Security Policy to use"
  default     = "Policy-Min-TLS-1-2-2019-07"
}

variable "cidr_blocks_internal" {
  type        = set(string)
  description = "Allow traffic from internal"
  default     = ["10.0.0.0/8", "172.16.0.0/12"]
}

variable "enable_cloudwatch_log" {
  type        = bool
  description = "Enable or disable cloudwatch logs"
  default     = true
}

variable "cloudwatch_log_type" {
  type        = string
  description = "Valid values are: INDEX_SLOW_LOGS, SEARCH_SLOW_LOGS, ES_APPLICATION_LOGS, AUDIT_LOGS"
  default     = "ES_APPLICATION_LOGS"
}

variable "retention_in_days" {
  type        = number
  description = "Retention in days for cloudwatch logs"
  default     = 7
}
