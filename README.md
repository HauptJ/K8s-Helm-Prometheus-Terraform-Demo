# K8s-Helm-Prometheus-Terraform-Demo

Terraform / OpenTofu, Kubernetes, and Helm Deployment to demonstrate the Kube-Prometheus-Stack. This is the Terraform / OpenTofu deployment script which incorporates the K8s and Helm chart configurations used during my ["Intro to Kubernetes Helm, K8s Operators, and Prometheus Monitoring" Presentation on Oct. 20. 2025.](https://www.meetup.com/dsort-net/events/311539053/)

## Prerequisites

- A DigitalOcean account and an API key - [Promotion: Spend $25 on DigitalOcean and receive a $200 credit.](https://m.do.co/c/d3723dfedb27)
- A Domain Name for testing
- [OpenTofu v1.10.3](https://opentofu.org/)

## Installation

- Create and export a DigitalOcean API token:
``` 
export DO_PAT="your_personal_access_token" 
```
- Configure a .tfvars file based on the demo.tfvars.example
- Initialize:
```
tofu init
```
- Plan:
```
tofu plan -var-file=<your var file> -var "do_token=${DO_PAT}"
```
- Apply:
```
tofu apply -var-file=<your var file> -var "do_token=${DO_PAT}"
```

## Cleaning Up

- Destroy:

```
tofu destroy -var-file=<your var file> -var "do_token=${DO_PAT}"
```

## License

Apache 2.0
