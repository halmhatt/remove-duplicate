#!/bin/sh

dryRun=false

# Parse options
for opt in $*; do

	# Check for option
	if [[ $opt == -* ]]; then
		# Shift away flags
		shift

		# Check for dry run
		if [ $opt == "--dry-run" ]; then
			echo "Dry run"
			dryRun=true
		fi

		if [ $opt == "--help" ]; then
			echo "usage: remove-duplicate [--dry-run] [--help] file1 [file2 [...]]"
			echo
			echo "       --dry-run  List all files that would be removed, do not remove anything"
			echo "       --help     Show this help message"
			exit;
		fi
	fi
done

CWD=$(pwd)

# Do for each file
for filename in $*
do
	# Dirname
	dir=$(dirname "$CWD/$filename")
	# Filename
	filename=$(basename "$filename")

	# Check that file exists
	if [ ! -e "$dir/$filename" ]; then
		echo "File $dir/$filename does not exist"
		continue
	fi

	# Calculate the hash for file
	hash=$(shasum "$dir/$filename" | sed -E 's/([a-z0-9]+).*$/\1/')

	# A string containing all sha1 hashes
	allHashes=$(shasum $dir/*)
	# Remove current file from list
	allHashes=$(echo $allHashes | sed -E "s/[a-z0-9]+ $filename//")

	# Grep for hash
	grepResult=$(echo "$allHashes" | grep "$hash")

	if [ "$grepResult" != "" ]; then
		
		# If dry run, do not remove anything
		if [ $dryRun = true ]; then
			echo "$dir/$filename"
		else
			# Remove file
			rm "$dir/$filename"
		fi
	fi

done
