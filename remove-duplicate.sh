#!/bin/sh

CWD=$(pwd)
#filename=$1

for filename in $*
do
	dir=$(dirname "$CWD/$filename")
	filename=$(basename "$filename")

	# Check that file exists
	if [ ! -e "$dir/$filename" ]; then
		echo "File $dir/$filename does not exist"
		exit 1;
	fi

	hash=$(shasum "$dir/$filename" | sed -E 's/([a-z0-9]+).*$/\1/')

	# A string containing all sha1 hashes
	allHashes=$(shasum $dir/*)
	# Remove current file from list
	allHashes=$(echo $allHashes | sed -E "s/[a-z0-9]+ $filename//")

	#echo $hash
	#echo $allHashes

	# Grep for hash
	grepResult=$(echo "$allHashes" | grep "$hash")

	if [ "$grepResult" != "" ]; then
		#echo "This is a duplicate removing"
		rm "$dir/$filename"
	#else
		#echo "This is not a duplicate"
	fi

done


#echo $shasums
