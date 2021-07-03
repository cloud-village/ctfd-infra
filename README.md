# CTFd on AWS

![CTFd on AWS](image/04a30368-9e4c-4823-ab2c-787073103c3a_200x200.png)


Build yourself some infra to run [`ctfd` v3.3.0](https://github.com/CTFd/CTFd/releases/tag/3.3.0) in AWS.

## Requirements
- `terraform` (this was built and tested with v0.15.4)
- VPC and subnets for AWS resources
- smtp server and credentials, such as [AWS SES](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-smtp.html) or [Mailgun](https://www.mailgun.com/)

## Things To Know
- This deployment does not support SSL by default. 
- Secrets are expected to be stored in [SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html) or [ASM](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html) under the path `/ctfd/`

## Usage
Populate your `myvars.tf` file appropriately, then you're ready to go!
```
~ cat myvars.tfvars
vpc_id        = "vpc-abc123"
alb_subnets   = ["subnet-abc124", "subnet-abc123", "subnet-abc125"]
region        = "us-east-1"
mailfrom_addr = "hello@example.com"
mail_server   = "localhost"
mail_port     = "25"
ecs_subnets   = ["subnet-abc124", "subnet-abc123", "subnet-abc125"] 
logs_region   = "us-east-1"
desired_count = 1
db_subnets    = ["subnet-abc124", "subnet-abc123", "subnet-abc125"] 

~ `terraform apply -var-files=myvars.tfvars`
```

