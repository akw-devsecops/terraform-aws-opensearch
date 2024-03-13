output "dashboard_endpoint" {
  description = "Endpoint of Opensearch dashboard"
  value       = aws_opensearch_domain.this.dashboard_endpoint
}

output "domain_name" {
  description = "Domain name of the opensearch cluster"
  value       = aws_opensearch_domain.this.domain_name
}

output "security_group" {
  description = "Name of the security group"
  value       = aws_security_group.this.name
}

output "parameter_name" {
  description = "Name of parameter for master password saved in the parameter store"
  value       = aws_ssm_parameter.this.name
}

output "name" {
  description = "Name of the cloudwatch log group"
  value       = aws_cloudwatch_log_group.application_logs.name
}
