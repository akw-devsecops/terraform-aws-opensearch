# create password for master user
resource "aws_ssm_parameter" "this" {
  name        = var.parameter_name
  description = "password for master user for opensearch"
  type        = "SecureString"
  value       = "placeh@lder"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

# create opensearch domain
resource "aws_opensearch_domain" "this" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    dedicated_master_enabled = var.dedicated_master_enabled
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    iops        = var.ebs_iops
    throughput  = var.ebs_throughput
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }

  advanced_security_options {
    enabled                        = var.advanced_security_options
    anonymous_auth_enabled         = var.anonymous_auth_enabled
    internal_user_database_enabled = var.internal_user_database_enabled
    master_user_options {
      master_user_name     = "admin-${var.env}"
      master_user_password = aws_ssm_parameter.this.value
    }
  }

  encrypt_at_rest {
    enabled = var.encrypt_at_rest
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption
  }

  software_update_options {
    auto_software_update_enabled = var.software_update_options
  }

  vpc_options {
    security_group_ids = [aws_security_group.this.id]
    subnet_ids         = var.subnet_ids
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = var.tls_security_policy
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.application_logs.arn
    enabled                  = var.enable_cloudwatch_log
    log_type                 = var.cloudwatch_log_type
  }
}

# security group with rules to open ports 443 (HTTPS), 5601 (Opensearch Dashboard), 9200 (Opensearch REST Api)
resource "aws_security_group" "this" {
  name        = "${var.domain_name}-elasticsearch-access"
  description = "Allow access to shared elastic search."
  vpc_id      = var.vpc_id
}

# allow access only from internal network
resource "aws_security_group_rule" "from_internal" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = var.cidr_blocks_internal
}

resource "aws_security_group_rule" "for_openseach_dashboard" {
  type              = "ingress"
  from_port         = 5601
  to_port           = 5601
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = var.cidr_blocks_internal
}

resource "aws_security_group_rule" "for_openseach_restapi" {
  type              = "ingress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = var.cidr_blocks_internal
}

resource "aws_security_group_rule" "from_pods" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = var.cidr_blocks_from_pods
}

# policy document for opensearch access
data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["es:*"]
    resources = ["${aws_opensearch_domain.this.arn}/*"]
  }
}

# attach policy to opensearch domain
resource "aws_opensearch_domain_policy" "this" {
  domain_name     = aws_opensearch_domain.this.domain_name
  access_policies = data.aws_iam_policy_document.this.json
}

# enable saml for opensearch
resource "aws_opensearch_domain_saml_options" "this" {
  count       = var.enable_saml == true ? 1 : 0
  domain_name = aws_opensearch_domain.this.domain_name

  saml_options {
    enabled = var.enable_saml

    master_user_name = var.master_user_name

    idp {
      entity_id        = var.idp_entity_id
      metadata_content = var.metadata_file
    }
  }
}

# cloudwatch log group
resource "aws_cloudwatch_log_group" "application_logs" {
  name              = "/aws/OpenSearchService/domains/${var.domain_name}/application-logs"
  retention_in_days = var.retention_in_days
}

data "aws_iam_policy_document" "application_logs" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }

    actions = [
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
      "logs:CreateLogStream",
    ]
    resources = ["${aws_cloudwatch_log_group.application_logs.arn}:*"]
  }
}

resource "aws_cloudwatch_log_resource_policy" "application_logs" {
  policy_name     = "OpenSearchService-${var.domain_name}-Application-logs"
  policy_document = data.aws_iam_policy_document.application_logs.json
}
