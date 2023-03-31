## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.47.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 2.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ctfd_alb"></a> [ctfd\_alb](#module\_ctfd\_alb) | ./alb | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./ecs | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./iam | n/a |
| <a name="module_mysql_db"></a> [mysql\_db](#module\_mysql\_db) | ./mysql_db | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ./redis | n/a |
| <a name="module_s3_uploads"></a> [s3\_uploads](#module\_s3\_uploads) | ./s3_uploads | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.secret_key](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_subnets"></a> [alb\_subnets](#input\_alb\_subnets) | subnet ids the ALB should live in | `list(string)` | n/a | yes |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | GB of storage for the database | `number` | `10` | no |
| <a name="input_allow_cloudflare"></a> [allow\_cloudflare](#input\_allow\_cloudflare) | is cloudflare being used? | `bool` | `false` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN for the SSL certificate used by the ALB | `string` | `""` | no |
| <a name="input_create_aws_dns"></a> [create\_aws\_dns](#input\_create\_aws\_dns) | do you want to create DNS entries in route53? | `bool` | `false` | no |
| <a name="input_ctfd_version"></a> [ctfd\_version](#input\_ctfd\_version) | docker tag for CTFd version | `string` | `"3.5.0"` | no |
| <a name="input_db_subnets"></a> [db\_subnets](#input\_db\_subnets) | subnets that the db nodes live in | `list(string)` | n/a | yes |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Number of instances of the task definition to place and keep running | `string` | `""` | no |
| <a name="input_ecs_subnets"></a> [ecs\_subnets](#input\_ecs\_subnets) | subnets used by the ECS service | `list(string)` | n/a | yes |
| <a name="input_ecs_task_depends_on"></a> [ecs\_task\_depends\_on](#input\_ecs\_task\_depends\_on) | list of resources that have to be created first, avoiding race conditions | `any` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | what environment are these resources being deployed to? | `string` | `"staging"` | no |
| <a name="input_https_redirect_enabled"></a> [https\_redirect\_enabled](#input\_https\_redirect\_enabled) | is the https redirect enabled? | `bool` | `false` | no |
| <a name="input_inbound_ips"></a> [inbound\_ips](#input\_inbound\_ips) | list of allowed inbound IP addresses | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_mail_password_arn"></a> [mail\_password\_arn](#input\_mail\_password\_arn) | SSM or ASM ARN for the username used to authenticate to the SMTP server | `string` | n/a | yes |
| <a name="input_mail_port"></a> [mail\_port](#input\_mail\_port) | The mail port that emails are sent from if not overriden in the configuration panel. | `string` | n/a | yes |
| <a name="input_mail_server"></a> [mail\_server](#input\_mail\_server) | The mail server that emails are sent from if not overriden in the configuration panel. | `string` | n/a | yes |
| <a name="input_mail_username_arn"></a> [mail\_username\_arn](#input\_mail\_username\_arn) | SSM or ASM ARN for the username used to authenticate to the SMTP server | `string` | n/a | yes |
| <a name="input_mailfrom_addr"></a> [mailfrom\_addr](#input\_mailfrom\_addr) | The email address that emails are sent from if not overridden in the configuration panel. | `string` | n/a | yes |
| <a name="input_max_cpu_threshold"></a> [max\_cpu\_threshold](#input\_max\_cpu\_threshold) | n/a | `string` | `85` | no |
| <a name="input_name_override"></a> [name\_override](#input\_name\_override) | a unique prefix for resource names | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | aws region the resources will be created in | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | hosted zone id | `string` | `""` | no |
| <a name="input_ssl_termination_enabled"></a> [ssl\_termination\_enabled](#input\_ssl\_termination\_enabled) | is SSL termination enabled? | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc\_id that all the things will live in | `string` | n/a | yes |
| <a name="input_workers"></a> [workers](#input\_workers) | number of gunicorn workers | `string` | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns"></a> [dns](#output\_dns) | n/a |
