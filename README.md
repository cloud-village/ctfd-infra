![CTFd on AWS](image/04a30368-9e4c-4823-ab2c-787073103c3a_200x200.png)


Build yourself some infra to run [`ctfd` v2.5.0](https://github.com/CTFd/CTFd/) in AWS.

## Requirements
### workstation
```
➜  packer -version
1.6.0
➜  terraform -version
Terraform v0.12.28
```

### AWS
- Domain imported into Route53 and SSL from ACM
- VPC and subnets for EC2 instances

### Other Stuff
- smtp server and credentials, such as [AWS SES](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-smtp.html) or [Mailgun](https://documentation.mailgun.com/en/latest/quickstart-sending.html#send-via-api)


## Build the Things
### Build the AMI
update your `vars.json` file accordingly

```
cd packer
packer build -var-file=vars.json ctfd.json

# or for the install built to run off one box
cd all-in-one
packer build -var-file=vars.json ctfd.json
```


### Build the Infra
update your `variables.tf` file accordingly

```
cd terraform/
terraform apply
```


## Known issues
* infra and config management do not currently set up or manage SMTP configs for `CTFd`. Those need to be added by hand in the UI, or written to the config database. This will likely get addressed by the [`config.ini` file as of `CTFd v3.0.0`](https://github.com/CTFd/CTFd/blob/master/CTFd/config.ini)
