#!/bin/bash
set -e

# TODO: Make sure that having curl doesn't cause vulnebirity issues
apt-get update
apt-get install curl

# Define variables
data_dir="/piston/packages"
python_3_12_env_config_file="$data_dir/python/3.12.0/environment"
python_3_12_env_file="$data_dir/python/3.12.0/.env"
node_20_env_config_file="$data_dir/node/20.11.1/environment"

rm -rf /piston/packages/*

# Make sure python 3.12 is installed and configured
if [ ! -f "$python_3_12_env_file" ]; then
    # Make a POST request to the API
    curl -X POST http://localhost:2000/api/v2/packages \
         -H "Content-Type: application/json" \
         -d '{"language": "python", "version": "3.12.0"}'

    # Append the line to the environment file
    echo "export PYTHONUNBUFFERED=1" >> "$python_3_12_env_config_file"
    echo "PYTHONUNBUFFERED=1" >> "$python_3_12_env_file"
    cat "$python_3_12_env_file"
fi


# Make sure node 20.11.1 is installed and configured
if [ ! -f "$node_20_env_config_file" ]; then
    # Make a POST request to the API
    curl -X POST http://localhost:2000/api/v2/packages \
         -H "Content-Type: application/json" \
         -d '{"language": "node", "version": "20.11.1"}'
fi



rm -rf post-build.sh