#!/bin/sh
#
# An example hook script to verify what is about to be committed.
# Called by "git commit" with no arguments.  The hook should
# exit with non-zero status after issuing an appropriate message if
# it wants to stop the commit.
#
# To enable this hook, rename this file to "pre-commit".
# Cross platform projects tend to avoid non-ASCII filenames; prevent
# them from being added to the repository. We exploit the fact that the
# printable range starts at the space character and ends with tilde.
for file in $(git diff --staged --name-only --diff-filter=ACM --no-color --unified=0); do
	if [[ $file =~ \.json$ ]];
	then 
		# grep -q bla $file && echo "Can not commit a GCP key to git repository." && exit 0
		# if cat $file |grep -w bla
		# then
		# 	exit 1
		# fi
		if grep -q 'private_key_id\|private_key\|client_id\|auth_uri\|token_uri\|auth_provider_x509_cert_url\|client_x509_cert_url'< $file; then
			echo "Can not commit a GCP key to git repository."
			echo "File Name -" $file
			echo "Steps:----"
			echo "1. Please remove json file containing GCP key from staging area."
			echo "2. Commit using git commit -m <message> command"
			exit 1

		fi
	fi
#   for elem in ${!PATTERNS[*]} ; do
#     { git show :0:"$file" | grep -Eq ${elem}; } || continue;
#     errors+=("${PATTERNS[${elem}]} in ${file}…");
#   done
done

# If there are whitespace errors, print the offending file names and fail.
# exec git diff-index --check --cached $against --
