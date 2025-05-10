# Kubernetes the hard way
Following: [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-prerequisites.md) by kelseyhightower.

Tracking the progress and infrastructure needed in terraform.

# Repo setup
1. Create a .env file from the terraform/env.example file and enter in your AWS Access token key.
2. Install terraform with `brew install terraform` if you do not have it already. Or refer to official documentation.
3. Run `terraform apply` inside of the terraform folder.
**WARNING: This may cost you credits on AWS, so double check the resources being created with `terraform plan` if desired**
4. To connect with your instances, you should see that a key has been generated inside of your terraform/ folder called `terraform-the-hard-way-tf` (feel free to name this what you want inside of your terraform `ec2.tf` file).  
I would recommend symlinking this into your `~/.ssh/` folder using `ln -s <source> <target>`, that way each time it's updated it should automatically update the key inside of your ssh config.
4a. Connect as usual by finding the public IP under amazon EC2 Instances and ssh into it.

## Notes
1. There is an OPTIONAL elastic ip that has been created for jump-box. This is to avoid having to redo your SSH config every time you start and stop instances. The other nodes don't need it as much because once you have your entry point you can just ssh into the other nodes via private IP.
