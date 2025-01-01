#!/bin/bash
prefix="${PREFIX}"
read -p "Enter Your DevUploads API Key: " api
response=$(curl -s "https://devuploads.com/api/account/info?key=$api")
response=$(echo "$response" | sed 's/"//g')
email=$(echo "$response" | awk -F 'email:' '{print $2}' | cut -d ',' -f 1 | tr -d ' ')
storage_used=$(echo "$response" | awk -F 'storage_used:' '{print $2}' | cut -d ',' -f 1 | tr -d ' ')
storage_used_gb=$(echo "$storage_used" | awk '{print $1/1024/1024/1024}')
balance=$(echo "$response" | awk -F 'balance:' '{print $2}' | cut -d ',' -f 1 | tr -d ' ')
curl -o $prefix/bin/devuploads.sh "https://devuploads.com/upload.sh"
echo ""
echo " [X] Email: $email"
echo " [X] Storage Used: $storage_used_gb GB"
echo " [X] Balance: $balance$"
echo ""
echo -e '$PREFIX/bin/devuploads.sh -f $@ -k $api'> $prefix/bin/upload
command="$prefix/bin/devuploads.sh -f \"\$@\" -k $api"
echo -e $command > $prefix/bin/upload
chmod 777 $prefix/bin/upload $prefix/bin/devuploads.sh
echo -e "\033[32mDevUploads Script is Ready To Use Enter upload followed by File Path\033[0m"
