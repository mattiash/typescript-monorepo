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

# Start with the template
dockerfile_content=$(cat "$TEMPLATE_FILE")

# Replace #include Dockerfile.build
if [ -f "$BUILD_FILE" ]; then
    build_content=$(cat "$BUILD_FILE")
    # Use perl for more reliable multiline replacement
    dockerfile_content=$(echo "$dockerfile_content" | perl -pe "s|#include Dockerfile\.build|$build_content|g")
else
    # Remove the include line if file doesn't exist
    dockerfile_content=$(echo "$dockerfile_content" | grep -v "#include Dockerfile.build")
fi

# Replace #include Dockerfile.prod
if [ -f "$PROD_FILE" ]; then
    prod_content=$(cat "$PROD_FILE")
    # Use perl for more reliable multiline replacement
    dockerfile_content=$(echo "$dockerfile_content" | perl -pe "s|#include Dockerfile\.prod|$prod_content|g")
else
    # Remove the include line if file doesn't exist
    dockerfile_content=$(echo "$dockerfile_content" | grep -v "#include Dockerfile.prod")
fi

# Output the final Dockerfile content to stdout
echo "$dockerfile_content"