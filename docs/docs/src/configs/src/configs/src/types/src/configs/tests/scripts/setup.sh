#!/bin/bash

# Setup script for AI Chronicle System

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "Setting up AI Chronicle System..."

# Check dependencies
check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}Error: $1 is required but not installed.${NC}"
        exit 1
    fi
}

check_dependency "node"
check_dependency "npm"
check_dependency "typescript"

# Install dependencies
echo "Installing dependencies..."
npm install

# Build TypeScript
echo "Building TypeScript..."
npm run build

# Run tests
echo "Running tests..."
npm test

# Setup configuration
echo "Setting up configuration..."
if [ ! -f "./config/local.yaml" ]; then
    cp ./config/default.yaml ./config/local.yaml
    echo "Created local configuration file"
fi

# Setup monitoring
echo "Setting up monitoring..."
mkdir -p ./logs
touch ./logs/system.log
touch ./logs/events.log

echo -e "${GREEN}Setup complete!${NC}"
