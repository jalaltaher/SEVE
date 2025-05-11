#!/bin/bash

# Name of the environment
ENV_NAME="math_tech"

# Create conda env from environment.yml
mamba env create -f environment.yml

# Optional: Install pip packages if requirements.txt exists
if [ -f "requirements.txt" ]; then
  mamba activate $ENV_NAME
  pip install -r requirements.txt
fi

echo "✅ Environment '$ENV_NAME' created successfully."