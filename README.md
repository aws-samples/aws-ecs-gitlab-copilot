### Building preview environments for your Amazon ECS applications using AWS Copilot

### Pre-requisites
- aws-cli-v2
- docker
- aws copilot cli

### Setup

1. Bootstrap the App and Dev Environment, and Deploy 2 services to the Dev Environment. 

```

export APP_NAME="copilot-demo-app"
export DEV_ENV_NAME="dev"
export DEV_PROFILE="dev"
export AWS_PROFILE="dev"

chmod +x ./scripts/bootstrap.sh && ./scripts/bootstrap.sh
```

2. Export the **APP_NAME**, **AWS_REGIION**, **VPC_ID**, **PUBLIC_SUBNETS**, and **PRIVATE_SUBNETS** into the Gitlab Variables(Settings -> CI/CD -> Variables)

3. Push to the Gitlab

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.


