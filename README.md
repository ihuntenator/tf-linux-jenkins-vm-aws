# Terraform deploy for AWS linux instance with jenkins

To set up a jenkins instance to pipeline terraform.

## the tfvars file

Have a tfvars file per environment to give access to AWS environment and ssh key for vm.

### dev.tfvars

```
access_key = "ACCESS_KEY"
secret_key = "SECRET_KEY"
keyName = "keyname"
keyPath = "/path/to/key"
```

## terraform run
```
terraform init
terraform validate
terraform plan -var-file=dev.tfvars -out tf-linux-vm-aws.out
terraform apply "tf-linux-vm-aws.out"
```

## terrarform explore

Create terraform dependency graph in DOT:
```
terraform graph
```

## terraform clean up

When finished:
```
terraform destroy -var-file=dev.tfvars
```

## Firewall

```
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"

firewall-cmd $PERM --new-service=jenkins
firewall-cmd $SERV --set-short="Jenkins ports"
firewall-cmd $SERV --set-description="Jenkins port exceptions"
firewall-cmd $SERV --add-port=$YOURPORT/tcp
firewall-cmd $PERM --add-service=jenkins
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
```
