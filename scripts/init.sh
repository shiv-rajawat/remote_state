#!/bin/sh
terraform init
terraform apply -auto-approve
terraform destroy -auto-approve
