#! /bin/bash

# ERD generator script
# by Mark Edmunds
# 9/11/2024

# Check which model to use
echo "Do you want to run the model locally? Y/N"
read local
if [ "$local" == "Y" ] || [ "$local" == "y" ] && command -v ollama >/dev/null 2>&1
    then
        ollama ps
    elif [ "$local" == "Y" ] || [ "$local" == "y" ]
    then 
        echo "Ollama is not installed"
fi
echo "Do you want to see a list of available models? Y/N"
read answer
if [ "$answer" == "Y" ] || [ "$answer" == "y" ] && command -v fabric >/dev/null 2>&1 # check if fabric is installed if not the expression will evaluate to 0
    then
        echo "$( fabric -L )" | less
fi
echo "Which model do you want to use? Leave blank to use default"

# Read user Input
read model
file=$1

# Function to generate ERD
generate_ERD(){
    local file=$1
    local model=$2
    local ERD_name=$3
    
    # The previous checks for ollama and fabric did not work found this solution using ChatGPT
    if [ "$model" != "" ] && command -v fabric >/dev/null 2>&1 # check if fabric is installed if not the expression will evaluate to 0
        then
            # generate ERD using the model provided
            cat "$file" | fabric --model "$model" --output "$ERD_name" -p create_erd_ai
        elif [ "$model" == "" ] && command -v fabric >/dev/null 2>&1 # check if fabric is installed if not the expression will evaluate to 0
        then
            # generate ERD using default model
            cat "$file" | fabric --output "$ERD_name" -p create_erd_ai
        else
            # exit with error
            echo "fabric framework not installed"
            # exit with error code 1
            exit 1
    fi
}

# Check if model exist
check_for_model (){
    local model="$1"
    result=$(fabric -L | grep "$model")
    if [ "$result" != "" ]
        then
            return 0
        else
            return 1
    fi
}

# Check if file exist
if [ -f "$file" ]
    then
        # check if model exist
        if check_for_model "$model"
            then
                # call the function to generate ERD
                echo "what name do you want to give to the ERD file?"
                read ERD_name
                echo "Generating ERD..."
                generate_ERD "$file" "$model" "$ERD_name"   
            else
                echo "Model does not exist"
                exit 1
        fi
        
    else
        # provide reason for exit
        echo "No argument provided expected file path or file name"
        # exit with error code 1
        exit 1
fi
