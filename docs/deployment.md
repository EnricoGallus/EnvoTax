# Deployment

Production is a single Docker container on an arm64 EC2 instance, deployed with Kamal 2.
Images are pushed to Amazon ECR, Postgres runs as a Kamal accessory on the same host, and uploaded
files go to S3.

## Configuration

`config/deploy.yml` loads host-specific values from `.env.prod`, which is gitignored:

| Variable                     | Purpose                             |
|------------------------------|-------------------------------------|
| `KAMAL_WEB_SERVER_PUBLIC_IP` | Public IP of the EC2 instance       |
| `KAMAL_REGISTRY_SERVER`      | ECR registry host                   |
| `SENTRY_DSN`                 | Sentry project DSN                  |
| `DATABASE_PASSWORD`          | Password for the Postgres accessory |

`config/master.key` (also not in the repository) decrypts `config/credentials.yml.enc` and is passed
to the container as `RAILS_MASTER_KEY`. To edit the credentials:

```bash
EDITOR="code --wait" bin/rails credentials:edit
```

## AWS setup

### EC2 instance

- An arm64 `t4g.nano` is the cheapest option that works.
- Use the Amazon Linux 2 AMI.
- The security group should allow HTTPS inbound only.
- Give the instance an IAM role that allows Session Manager connections.

### Instance preparation

Connect to the instance and install Docker:

```bash
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
```

### Swap file

A `t4g.nano` has little memory, so add swap to survive memory spikes:

```bash
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo swapon -a
```

## Deploying with Kamal

- Check the current AWS profile with `aws configure list`, then `export AWS_PROFILE=envotax`.
- The AWS user needs permissions for ECR and EC2.
- Adjust `config/deploy.yml` to match the server.
- When deploying from your own machine, the SSH port has to be open.
- Deploy with `kamal app stop && kamal deploy`. Stopping the app first avoids memory spikes that can
  freeze the server.

## Docker cleanup

- `kamal prune all` removes unused containers and images.
- Check the result with `kamal server exec docker system df`.
- If containers are left over, force it with `kamal server exec docker container prune -f`.
