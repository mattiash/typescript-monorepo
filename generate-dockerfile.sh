#!/bin/bash

# Script to generate Dockerfile by processing template and includes
# Usage: ./generate-dockerfile.sh

set -e

TEMPLATE_FILE="../Dockerfile.template"
BUILD_FILE="Dockerfile.build"
PROD_FILE="Dockerfile.prod"

# Check if template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file $TEMPLATE_FILE not found" >&2
    exit 1
fi

# Function to safely replace include with file content
replace_include() {
    local input="$1"
    local include_pattern="$2"
    local file_path="$3"
    
    if [ -f "$file_path" ]; then
        # Use awk to avoid variable expansion issues
        echo "$input" | awk -v pattern="$include_pattern" -v file="$file_path" '
        {
            if ($0 ~ pattern) {
                while ((getline line < file) > 0) {
                    print line
                }
                close(file)
            } else {
                print $0
            }
        }'
    else
        # Remove the include line if file doesn't exist
        echo "$input" | grep -v "$include_pattern"
    fi
}

# Start with the template
dockerfile_content=$(cat "$TEMPLATE_FILE")

# Replace #include Dockerfile.build
dockerfile_content=$(replace_include "$dockerfile_content" "#include Dockerfile.build" "$BUILD_FILE")

# Replace #include Dockerfile.prod
dockerfile_content=$(replace_include "$dockerfile_content" "#include Dockerfile.prod" "$PROD_FILE")

# Output the final Dockerfile content to stdout
echo "$dockerfile_content"