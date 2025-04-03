# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

# Ruby version

3.4.2

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

# Deployment instructions

## AWS Configuration

### EC2-Instance Creation

- Need an EC2 instance, best and cheapest option is an arm64 t4g.nano
- Use the Amazon Linux 2 AMI
- Security Group attached should allow https inbound only
- Change the EC2 IAM task role to support Session Manager connections

### EC2-Instance Preparation

- Connect to the instance when running and execute the following commands
```
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
```

### Using kamal

- check for the current profile by executing `aws configure list`
- export aws profile by executing `export AWS_PROFILE=envotax`
- setup aws configure and provide the necessary credentials
- it needs a user in aws that has the necessary permissions for ecr and ec2
- adjust the `deploy.yml` file to match the server settings
- when running `kamal deploy` from own machine, ssh port needs to be opened up

## Database backup
- create a backup of the database by executing `kamal server exec cat /mnt/storage/production.sqlite3 > production.sqlite3`
- but rememeber to remove the first couple of lines, it contains output from the kamal command