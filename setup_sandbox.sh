#!/bin/sh

docker build -t cloudmonkey -f Dockerfile.cloudmonkey .

TERRAFORM_TFVARS="./terraform.tfvars"

CLOUDSTACK_API_URL="http://localhost:8080/client/api"
CLOUDSTACK_API_KEY=$( ./cloudmonkey list users | grep apikey | awk '{gsub(/\s/, "", $3); print $3}' )
CLOUDSTACK_SECRET_KEY=$( ./cloudmonkey list users | grep secretkey | awk '{gsub(/\s/, "", $3); print $3}' )

echo "cloudstack_api_url = \"${CLOUDSTACK_API_URL}\"" > $TERRAFORM_TFVARS
echo "cloudstack_api_key = \"${CLOUDSTACK_API_KEY}\"" >> $TERRAFORM_TFVARS
echo "cloudstack_secret_key = \"${CLOUDSTACK_SECRET_KEY}\"" >> $TERRAFORM_TFVARS
