#! /bin/bash

cd ./terraform/
terraform init
terraform apply --auto-approve

cd ..

cd ./scripts/
python3.10 schedule-apply.py