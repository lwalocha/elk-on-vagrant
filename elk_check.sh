#! /bin/bash

curl https://192.168.33.25:9203/_cluster/health?pretty --key certs/client.key --cert certs/client.cer --cacert client-ca.cer -k -v

