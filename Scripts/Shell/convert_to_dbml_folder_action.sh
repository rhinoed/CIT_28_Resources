#! /bin/bash

# Convert schema to DBML
# Intended to be used as a folder action
# by Mark Edmunds
# 10 - 8 - 2024


# Set prompt to echo
prompt="Convert this sqlite schema to dbml format. Make sure that the references are outside of the entity blocks"

# Set path to dirname
p_dirname=$(command -v dirname)
# Set path to Cat
p_cat=$(command -v cat)
# Set path to Fabric
p_fabric=$(command -v fabric)

# Get the path of the schema file
schema_path=$1

# Get the parent directory of the schema file
path_parent_dir=$($p_dirname "$schema_path")

# Check if fabric is installed
if command -v $p_fabric >/dev/null 2>&1 && [ -f "$schema_path" ] # check if fabric is installed and if the schema file exists and is a file.
        then
            # create a directory to store the dbml files
            mkdir -p "$path_parent_dir/DBML"
            # create a directory to store the origial files
            mkdir -p "$path_parent_dir/Original"
            # set output path
            output_path="$path_parent_dir/DBML"
            # set original path
            original_path="$path_parent_dir/Original"
            # get the file name
            file_name=${schema_path##*/}
            # remove the file extension
            file_name_no_ext=${file_name%.*}
            # generate ERD using the model provided
            # Note: replace /replace/with/path/to/fabric with the path to the fabric executable. The /bin/cat should be the same on all Mac systems but you might want to verify that.
            echo -e "$prompt\n$(/bin/cat "$schema_path")" | /replace/with/path/to/fabric --output "$output_path/$file_name_no_ext.dbml"
            # move the original file to the Original directory
            mv "$schema_path" "$original_path"
        else
            # exit with error
            echo "fabric framework not installed"
            # exit with error code 1
            exit 1
fi  

