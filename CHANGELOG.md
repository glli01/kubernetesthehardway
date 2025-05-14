# 13 May, 2025
1. Finished (08-bootstrapping-kubernetes-controllers.md)
This took quite a bit of effort because apparently in 04, the certificate and key generated for the `admin` user did not generate properly. The key was then missing in the admin.kubeconfig, and so they were regenerated and then proceeded through the setup.

Summary: Followed a lot of commands - seems like we setup the kubernetes API server / control plane... There are a lot of components here to study.

# 12 May, 2025
1. Setup an encryption config and key. (Finished 06-data-encryption keys).
2. Setup etcd and learned about etcd (a distributed key-value store with watching and strong consistency through the raft algorithm)
[etcd](etcd.io)

Also learned about the RAFT algorithm, which is the algorithm behind the consistency of etcd.
You can read more here:
[Raft algorithm](https://raft.github.io/)
The paper is [here](https://raft.github.io/raft.pdf)
- Essentially raft is a simple but robust consistency algorithm, that functions via a heartbeat and a running log. The log determines what operations have occurred and followers must confirm operations before they are considered complete.

# 11 May, 2025
Setup kube-configs and made sure that they were accessible through kubernetes' [Node authorizer](https://kubernetes.io/docs/reference/access-authn-authz/node/) This means that the kubeconfigs had to be generated with the public key associated to each node.
# 10 May, 2025
Finished setting up the jump-box with hosts entries, essentially mapped each of the hosts in the /etc/hosts file so that we can ssh to the other hosts using aliases like so: `ssh server` from the jump-box. This marks the completion of `03-compute-resources.md`

1. Created EIP for jump-box for easier readability. No other issues were had after installing the locales.
2. Finished `04-certificate-authority.md` which essentially generated a certificate authority certificate and key. Then for each cert, we generated private keys, csrs, and then certificates using these generated ca certificate and keys.
We then distributed these ca certs and private keys to the hosts.

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

