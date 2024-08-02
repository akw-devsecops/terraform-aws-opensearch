<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.application_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.application_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_opensearch_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [aws_opensearch_domain_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain_policy) | resource |
| [aws_opensearch_domain_saml_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain_saml_options) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.for_openseach_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.for_openseach_restapi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.from_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.from_pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_iam_policy_document.application_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks_from_pods"></a> [cidr\_blocks\_from\_pods](#input\_cidr\_blocks\_from\_pods) | Allow from kubernetes pods | `set(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of the OpenSearch Domain | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Opensearch version | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of your nodes | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance Type for the cluster | `string` | n/a | yes |
| <a name="input_parameter_name"></a> [parameter\_name](#input\_parameter\_name) | Parameter Name for storing the master password in the Parameter Store | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Your Subnet IDs | `set(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Your VPC ID | `string` | n/a | yes |
| <a name="input_advanced_security_options"></a> [advanced\_security\_options](#input\_advanced\_security\_options) | Enable advanced security options | `bool` | `true` | no |
| <a name="input_anonymous_auth_enabled"></a> [anonymous\_auth\_enabled](#input\_anonymous\_auth\_enabled) | Enable or disable anonymous authentication | `bool` | `false` | no |
| <a name="input_cidr_blocks_internal"></a> [cidr\_blocks\_internal](#input\_cidr\_blocks\_internal) | Allow traffic from internal | `set(string)` | <pre>[<br>  "10.0.0.0/8",<br>  "172.16.0.0/12"<br>]</pre> | no |
| <a name="input_cloudwatch_log_types"></a> [cloudwatch\_log\_types](#input\_cloudwatch\_log\_types) | Valid values are: INDEX\_SLOW\_LOGS, SEARCH\_SLOW\_LOGS, ES\_APPLICATION\_LOGS, AUDIT\_LOGS | `list(string)` | <pre>[<br>  "ES_APPLICATION_LOGS"<br>]</pre> | no |
| <a name="input_dedicated_master_enabled"></a> [dedicated\_master\_enabled](#input\_dedicated\_master\_enabled) | Enable or disable dedicated master | `bool` | `false` | no |
| <a name="input_ebs_enabled"></a> [ebs\_enabled](#input\_ebs\_enabled) | Enable using EBS-Volume or not | `bool` | `true` | no |
| <a name="input_ebs_iops"></a> [ebs\_iops](#input\_ebs\_iops) | IOPS for EBS | `number` | `3000` | no |
| <a name="input_ebs_throughput"></a> [ebs\_throughput](#input\_ebs\_throughput) | Throughput for EBS | `number` | `125` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | Volume Size of your EBS | `number` | `10` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | Type of your EBS volume | `string` | `"gp3"` | no |
| <a name="input_enable_cloudwatch_log"></a> [enable\_cloudwatch\_log](#input\_enable\_cloudwatch\_log) | Enable or disable cloudwatch logs | `bool` | `true` | no |
| <a name="input_enable_saml"></a> [enable\_saml](#input\_enable\_saml) | enable SAML for Opensearch Dashboard | `bool` | `false` | no |
| <a name="input_encrypt_at_rest"></a> [encrypt\_at\_rest](#input\_encrypt\_at\_rest) | Enable or disable encryption at rest | `bool` | `true` | no |
| <a name="input_idp_entity_id"></a> [idp\_entity\_id](#input\_idp\_entity\_id) | Your identity provider id | `string` | `null` | no |
| <a name="input_internal_user_database_enabled"></a> [internal\_user\_database\_enabled](#input\_internal\_user\_database\_enabled) | Enable or disable internal user database | `bool` | `true` | no |
| <a name="input_master_user_name"></a> [master\_user\_name](#input\_master\_user\_name) | Specify the user that should have full admin rights | `string` | `""` | no |
| <a name="input_metadata_file"></a> [metadata\_file](#input\_metadata\_file) | The file received from your identity provider (e.g. Keycloak) | `string` | `null` | no |
| <a name="input_node_to_node_encryption"></a> [node\_to\_node\_encryption](#input\_node\_to\_node\_encryption) | Enable or disable node to node encryption | `bool` | `true` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Retention in days for cloudwatch logs | `number` | `7` | no |
| <a name="input_software_update_options"></a> [software\_update\_options](#input\_software\_update\_options) | Enable or disable the auto software updates | `bool` | `true` | no |
| <a name="input_tls_security_policy"></a> [tls\_security\_policy](#input\_tls\_security\_policy) | TLS Security Policy to use | `string` | `"Policy-Min-TLS-1-2-2019-07"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dashboard_endpoint"></a> [dashboard\_endpoint](#output\_dashboard\_endpoint) | Endpoint of Opensearch dashboard |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Domain name of the opensearch cluster |
| <a name="output_name"></a> [name](#output\_name) | Name of the cloudwatch log group |
| <a name="output_parameter_name"></a> [parameter\_name](#output\_parameter\_name) | Name of parameter for master password saved in the parameter store |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | Name of the security group |
<!-- END_TF_DOCS -->