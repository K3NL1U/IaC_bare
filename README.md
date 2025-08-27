# Auto-Healing Web Tier on AWS with Terraform and Docker Hub

## Requirements

The choice of AWS is only due to my extended familiarity with the provider, similar set up can be replicated in other platforms such as Azure.

Key features:
- **Self-healing**: EC2 instances run in an Auto Scaling Group (ASG) that replaces any failed instance automatically.
- **Self-provisioning**: Everything is defined in Terraform, allowing one command to deploy the entire infrastructure.
- **N+1 Capacity**: At least two instances are deployed to handle traffic behind the ALB.
- **Custom Docker image**: NGINX serves a static page pulled from Docker Hub.

---

### Getting started

If you run this locally, the following will need to be installed:
- AWS CLI.
- Terraform.
- Docker and Docker Hub account to push your image.

### Deploying infastructure.
1. Clone the repository:
```bash
git clone https://github.com/K3NL1U/IaC_bare.git
cd IaC_bare
```
2. Build Docker image and push to Docker Hub
```bash
docker build -t yourusername/nginx-custom:latest
docker push yourusername/nginx-custom:latest
```
3. Initialise Terraform:
```bash
terraform init
```
4. Preview the planned changes, and specify your Docker Hub image:
```bash
terraform plan -var="dockerhub_image=yourusername/nginx-custom:latest"
```
1. Apply the infrastructure:
```bash
terraform apply -var="dockerhub_image=yourusername/nginx-custom:latest"
```
1. After deployment completes, Terraform outputs the ALB DNS name. Open this URL in a browser.

---

## Assumptions and Cost Estimate

- **Instance Type:** `t3.micro` which may be considered for free tier usage, otherwise choose `t2.micro`.
- **Minimum Instances:** 2, to satisfy N+1 availability.
- **Region:** `ap-southeast-2` (Sydney).
- **Estimated Monthly Cost:** This design is only based on the configuration requirements which it turn does not satisfy the cost requirement. It will cost more than 20 USD/month (not even in AUD), with just the ALB provisioned.

---

## Next Steps / Enhancements

- Instead of installing the dependencies, authenticating and deploying manually, automate it further by having GitHub Actions perform these "actions" for us, triggered by code push.
- Autoscaling policies based on CloudWatch metrics.
- Utilise ECS (fargate containers) for better resource utilisation.
- Use R53 for custom domain and ACM in conjunction with ALB to secure the traffic with HTTPS.
- Move Docker image hosting to Amazon ECR for better integration/private image.
- However, if the purpose is only to serve simple static content, I would recommend a redesign, using CloudFront + ACM + S3 instead of provisioning lots of underutilised compute resources.

---

## Contact

LinkedIn: https://www.linkedin.com/in/ken-l-a87703139/

---

*Thank you for reviewing this project!*
