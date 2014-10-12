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

### Dry run
To test what files will be deleted, you could do a dry run with the flag `--dry-run`. This will list all files that will be removed. 

*Notice: this will still list files that may not be deleted, sorry for that. This is because in reality, there will **always** be atleast 1 file left, because the check is done after each removal. Eg the command `remove-duplicate *` with 4 duplicates will remove 3 of them, but the command `remove-duplicate *` will list all 4 files. If they are named `myimage.JPG` an all other has a suffix like `myimage-001.JPG` you could do a dry run with the command `remove-duplicate *-00*.JPG` that would list all files that would be removed.* 