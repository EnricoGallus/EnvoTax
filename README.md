# README

# TODO:
Dashboard when creating time entry with valid data
Failure/Error: expect(page).to have_no_css(form_selector)
expected not to find visible css "form[action='/time_entries']", found 1 match: "Name\nProject\nCristopher Kertzmann Jr.\nDate\nFrom\nTo"

     [Screenshot Image]: /home/runner/work/EnvoTax/EnvoTax/tmp/capybara/failures_r_spec_example_groups_dashboard_when_creating_time_entry_with_valid_data_564.png


     # ./spec/system/dashboard/dashboard_index_spec.rb:56:in 'block (3 levels) in <top (required)>'
This test always fails on CI, but works locally.

Run actions/upload-artifact@v4
No files were found with the provided path: /home/runner/work/EnvoTax/EnvoTax/tmp/screenshots. No artifacts will be uploaded.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

# Ruby version

3.4.6

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

# Deployment instructions

## Credentials/Secrets

- use `EDITOR="code --wait" bin/rails credentials:edit` to edit the credentials

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
- run `kamal app stop && kamal deploy` to prevent memory spikes and server freezing

## Docker cleanup
- run `kamal prune all` to remove all unused containers and images
- but make sure it is cleaned up `kamal server exec docker system df`
- looks like sometimes it needs to be manually forced `kamal server exec docker container prune -f`

## Database backup
- deactivate caching by executing `kamal shell` and then twice executing `bin/rails dev:cache`
- create a backup of the database by executing `kamal server exec cat /mnt/storage/production.sqlite3 > production.sqlite3`
- but remember to remove the first couple of lines, it contains output from the kamal command

# Database copy
scp -i ~/.ssh/EnvoTax.pem storage/production.sqlite3 ec2-user@52.198.76.244:/mnt/storage/production.sqlite3
