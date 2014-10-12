# Setup
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RMDC="$DIR/../remove-duplicate.sh"

function setup() {
	echo "Test file" > "$DIR/testfile.txt"
	cp "$DIR/testfile.txt" "$DIR/testfile-001.txt"
	cp "$DIR/testfile.txt" "$DIR/testfile-002.txt"
	cp "$DIR/testfile.txt" "$DIR/testfile-001.md"
}

# Removes files that exists
function removeQuiet() {
	for filename in $*; do
		if [ -e "$DIR/$filename" ]; then
			rm "$DIR/$filename"
		fi
	done
}

function teardown() {
	removeQuiet testfile.txt testfile-001.txt testfile-002.txt testfile-001.md
}

function checkNotRemoved() {

	# Check that original is still present
	for filename in $*; do
		if [ ! -e "$DIR/$filename" ]; then
			echo "ERROR file $filename was removed"
			exit 1;
		fi
	done
}

function checkRemoved() {

	# Check that files are removed
	for filename in $*; do
		if [ -e "$filename" ]; then
			echo "ERROR file $DIR/testfile-001.txt still exists" 
			exit 1;
		fi
	done
}

# Setup 
setup

# Remove all with suffix 001.txt
$RMDC test/*-001.txt

# Check that file does not exist exits
checkRemoved testfile-001.txt

# Check original
checkNotRemoved testfile.txt

# Setup
setup

# Remove all with suffix
$RMDC test/*-00*

# Check removed files
checkRemoved testfile-001.txt testfile-002.txt testfile-001.md

# Check original
checkNotRemoved testfile.txt

setup

$RMDC test/*.md

# Check that file is removed
checkRemoved testfile-001.md

# Check that original is still present
checkNotRemoved testfile.txt

# Remove all files
teardown

echo "OK everything is good :)"