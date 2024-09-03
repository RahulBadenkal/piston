#!/bin/bash
set -e

apt-get install curl

# Define variables
data_dir="/data/coolify/applications/dk4w8kwk0g0swoowsoks8s4s/data/piston/packages"
python_3_12_env_file="$data_dir/python/3.12.0/environment"

# Make sure python 3.12 is installed and configured
if [ ! -f "$python_3_12_env_file" ]; then
    # Make a POST request to the API
    curl -X POST http://localhost:2000/api/v2/packages \
         -H "Content-Type: application/json" \
         -d '{"language": "python", "version": "3.12.0"}'

    # Append the line to the environment file
    echo "export PYTHONUNBUFFERED=1" >> "$python_3_12_env_file"
fi


rm -rf post-build.sh