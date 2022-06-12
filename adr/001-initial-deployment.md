# 1. CTFd, First as VMs

Date: 2020-07-10

## Status

Accepted

## Context

This is an attempt to capture context after the fact for the first version of this deployment, and functions as an ADR as well as a retrospective.

The goal is to use [CTFd](https://github.com/CTFd/CTFd) as the administration tool for a CTF challenge, as the other major tool in the ecosystem, [`fbctf`](https://github.com/facebookarchive/fbctf) was archived around 2018.

## Decision

Once we decided on using CTFd, the focus was on how to deploy it.

I chose to use VMs as a compute layer, to build the VMs using [Packer](https://www.packer.io/), configure them on boot using [Ansible](https://www.ansible.com/), deploy them in an autoscaling group across multiple availability zones to support high availability, and to have the autoscaling group increase the quantity of VMs in response to high CPU utilization. CTFd can use MySQL as it's database, Redis as it's cache, and S3 for storing staic assets, so these were built as well to provide a more stable and reliable deployment.

Regarding application configuration, I wrote a systemd unit file to manage the service, and used AWS Secrets Manager to store credentials and configuration details (I tried but was unsuccessful in using AWS SSM Parameter Store).

For ease of development, I also built a `packer` template where all resources were deployed to one machine (CTFd can use the local filesystem to store assets, so there was on need to install a service similar to s3).

## Consequences

By running on VMs instead of a serverless platform, scaling took more time. To that end, we ran into a performance issue: despite there being negligible load (under 25% CPU utilization), the app was crawling: registrations were timing out and the app was throwing 500s. The answer turned out to be the way `gunicorn` workers were configured: the default configuration using `gunicorn` was for one thread and one worker, which was not enough to make use of the available hardware. We changed the configuration to use three times the number of workers and threads, after which the app performance improved.


## References

https://nopresearcher.github.io/Deploying-CTFd/
https://medium.com/csictf/self-hosting-a-ctf-platform-ctfd-90f3f1611587
https://pythonspeed.com/articles/gunicorn-in-docker/
https://medium.com/building-the-system/gunicorn-3-means-of-concurrency-efbb547674b7
