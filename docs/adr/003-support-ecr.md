# 3. Adding support for ECR

Date: May 21, 2024

## Status

Accepted


## Context

[Themes for CTFd](https://docs.ctfd.io/docs/themes/overview/) can be added through the UI or [packaged alongside the application itself](https://docs.ctfd.io/docs/themes/overview/#self-hosted-ctfd). In order to provide a customized private image with themes packaged alongside, we need to support another container registry, and we want to stick with services offered by AWS for security benefits like roles for IAM as well as limiting the number of external dependencies.

## Decision

Since we deploy CTFd as a container, adding support for a custom image stored in an ECR repository provides us with both a consistent packaging mechanism and allows us to support theme development using version control. We now support pulling an image from AWS ECR to support customized themes as well as any additional changes we want to make to CTFd itself.

## Consequences

Maintaining custom themes means we need to ensure testing of the platform with successive versions.
