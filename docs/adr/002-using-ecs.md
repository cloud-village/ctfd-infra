# 2. Using AWS ECS

Date: 2021-06-20

## Status

Accepted

## Context

I wanted to experiment with using ECS, and I spent my innovation budget on re-platforming from VMs to AWS Elastic Container Service.

I also wanted to force myself towards more ephemeral deployments and application infrastructure so that I wouldn't be able to make changes on the fly and have them persist. I was trying to keep myself more accountable, and by accountable I mean making sure that my changes were added to this repo.

In addition to changing from VMs to ECS, I also was able to successfully leverage AWS SSM Parameter Store instead of AWS Secrets Manager: in my opinion, Parameter Store has a better developer experience. Also, it's cheaper.

For scaling, I leveraged a module from the Terraform Registry instead of writing it by hand. Again, the scaling factor was CPU utilization.

## Decision

We did it, it worked, and when we ran into issues, we had to use Cloudwatch Logs, which is kind of crap.

## Consequences

The biggest drawbacks of this migration were losing SSH access for debugging, and having to use Cloudwatch Logs for logging. While the former can be addressed through using [ECS Exec](https://aws.amazon.com/blogs/containers/new-using-amazon-ecs-exec-access-your-containers-fargate-ec2/), I wasn't able to implement by the deadline. For the latter, I'm interested in exploring [Loki](https://grafana.com/oss/loki/) for log management. We'll see how this goes next time around.
