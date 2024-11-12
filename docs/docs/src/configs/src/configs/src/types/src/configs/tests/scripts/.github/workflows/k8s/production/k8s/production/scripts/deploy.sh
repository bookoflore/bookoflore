#!/bin/bash

# Deployment script for AI Chronicle System
set -e

# Configuration
DEPLOYMENT_ENV=$1
DOCKER_REGISTRY="your-registry.azurecr.io"
IMAGE_NAME="chronicle-system"
IMAGE_TAG=$(git rev-parse --short HEAD)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Validate environment
if [ -z "$DEPLOYMENT_ENV" ]; then
    echo -e "${RED}Error: Deployment environment not specified${NC}"
    echo "Usage: ./deploy.sh [production|staging]"
    exit 1
fi

echo "Deploying to $DEPLOYMENT_ENV environment..."

# Build Docker image
echo "Building Docker image..."
docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG .

# Push to registry
echo "Pushing to registry..."
docker push $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG

# Update Kubernetes deployment
echo "Updating Kubernetes deployment..."
kubectl config use-context chronicle-$DEPLOYMENT_ENV

# Update deployment image
kubectl set image deployment/chronicle-system \
    chronicle-system=$DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \
    --namespace=$DEPLOYMENT_ENV

# Wait for rollout
echo "Waiting for rollout to complete..."
kubectl rollout status deployment/chronicle-system \
    --namespace=$DEPLOYMENT_ENV \
    --timeout=300s

# Verify deployment
echo "Verifying deployment..."
kubectl get pods -n $DEPLOYMENT_ENV | grep chronicle-system

echo -e "${GREEN}Deployment complete!${NC}"
