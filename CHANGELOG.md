# 9 May, 2025
Created machines.txt, made all machines sshable from root - NOTE, this required us to remove some lines from /root/.ssh/authorized_keys (The lines until `ssh-rsa`).

Created a public key on jump-box. ssh-copy-id did not work, so manually added as a public key on each host.

Changed hostnames on debian using `hostname` command.

Locales changed using: `sudo dpkg-reconfigure locales` - select the en_US.UTF-8 option with space and tab and arrow keys. Continue and set that as default.

Currently On:
[Host Lookup Table](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md#host-lookup-table)

# 4 May, 2025
Create node-0, node-1, and server.
Finished section 01 and 02, creating jump-box and setting it up.

Currently on:
[Compute Resources](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md)
# 02/3 May, 2025
Setup environment through terraform:
1. VPC + Security groups + Internet gateway + Route Table
2. Access key (aws_pub_key)
3. Instances (Jump box)

