#!/bin/sh

for file in $(git diff --staged --name-only --diff-filter=ACM --no-color --unified=0); do
	if [[ $file =~ \.json$ ]];
	then 
		if grep -q 'private_key_id\|private_key\|client_id\|auth_uri\|token_uri\|auth_provider_x509_cert_url\|client_x509_cert_url'< $file; then
			echo "Can not commit a GCP key to git repository."
			echo "File Name -" $file
			echo "Steps:----"
			echo "1. Please remove json file containing GCP key from staging area."
			echo "2. Commit using git commit -m <message> command"
			exit 1
		fi
	fi
done
