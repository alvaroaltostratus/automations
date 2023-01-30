#! /bin/bash

cd ./scripts/
python3.10 get-disks.py

cd ..

cd ./terraform/
terraform init
terraform apply --auto-approve
