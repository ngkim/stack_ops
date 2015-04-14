#!/bin/bash

INSTANCE_ID="106d02d7-73b0-49dc-8bc6-390bf9635575"
TENANT_ID="4a5e1b9342c342c7873de76a8a070b83"
SECRET="foo"

SIGNATURE=`python metadata.py $INSTANCE_ID $SECRET`
curl \
  -H 'x-instance-id: ${INSTANCE_ID}' \
  -H 'x-tenant-id: ${TENANT_ID}' \
  -H 'x-instance-id-signature: ${SIGNATURE}' \
  http://localhost:8775/latest/meta-data

