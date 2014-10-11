Remove Duplicate
===================

Removes file if it is a duplicate of another file in the same folder. Check is done with sha1 sum

## Usage ##
```bash
remove-duplicate myimage-001.JPG
```

This removes myimage-001.JPG if the same file is already present in the folder


To remove multiple files:
```bash
remove-duplicate *-001.JPG
```

This removes all files ending in -001.JPG if they are duplicates of another file in this folder. 