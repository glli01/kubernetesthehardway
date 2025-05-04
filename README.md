# Kubernetes the hard way
Following: [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-prerequisites.md) by kelseyhightower.

Tracking the progress and infrastructure needed in terraform.

# Repo setup
1. Create a .env file from the terraform/env.example file and enter in your AWS Access token key.
1a. Also create a public key using `ssh-keygen` (take the pub file it generates) and set that as your `TF_Var_aws_pub_key`.
2. Install terraform with `brew install terraform` if you do not have it already. Or refer to official documentation.
3. Run terraform apply inside of the terraform folder.
**WARNING: This may cost you credits on AWS, so double check the resources being created with `terraform plan` if desired**
