#! /bin/bash

# Convert schema to DBML script
# by Mark Edmunds
# 10 - 8 - 2024

# Get the path of the schema file
schema_path=$1

# Get the parent directory of the schema file
path_parent_dir=$(dirname $schema_path)

# Set prompt to echo
prompt="Convert this sqlite schema to dbml format. Make sure that the references are outside of the entity blocks"
# Check if fabric is installed
if command -v fabric >/dev/null 2>&1 # check if fabric is installed if not the expression will evaluate to 0
        then
            mkdir -p "$path_parent_dir/DBML"
            file_name=${schema_path##*/}
            file_name_no_ext=${file_name%.*}
            # generate ERD using the model provided
            echo "$prompt \n$(cat "$schema_path")" | fabric --output "$path_parent_dir/DBML/$file_name_no_ext.dbml"
        else
            # exit with error
            echo "fabric framework not installed"
            # exit with error code 1
            exit 1
fi  

