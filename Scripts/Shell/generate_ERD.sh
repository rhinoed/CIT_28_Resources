#! /bin/bash

# ERD generator script
# by Mark Edmunds
# 9/11/2024

# Check which model to use
echo "Which model do you want to use?"
echo "Enter 1 to use llama 3.1 (local)"
echo "Enter 2 to use gemini-1.5-pro-latest (remote)"
# Read user Input
read model
file=$1

# Function to generate ERD
generate_ERD(){
    local file=$1
    local model=$2
    
    # The previous checks for ollama and fabric did not work found this solution using ChatGPT
    if [ "$model" == "1" ] && command -v ollama >/dev/null 2>&1 # check if ollama is installed if not the expression will evaluate to 0
        then
            # start ollama
            ollama serve
            # generate ERD using llama 3.1
            cat "$file" | fabric --model llama3.1:latest --output package_ERD.md -p create_erd
        elif [ "$model" == "2" ] && command -v fabric >/dev/null 2>&1 # check if fabric is installed if not the expression will evaluate to 0
        then
            # generate ERD using gemini-1.5-pro-latest
            cat "$file" | fabric --model models/gemini-1.5-pro-latest --output package_ERD.md -p create_erd
        else
            # exit with error
            echo "Invalid model selected or framework not installed"
            # exit with error code 1
            exit 1
    fi
}

# Check if file exist
if [ -f "$file" ]
    then
        # call the function to generate ERD
        generate_ERD "$file" "$model"
    else
        # provide reason for exit
        echo "No argument provided expected file path or file name"
        # exit with error code 1
        exit 1
fi
