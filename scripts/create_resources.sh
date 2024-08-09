#!/bin/bash

LOCATION=eastus

# Parse the resource group name from the parameter
RESOURCE_GROUP_NAME=rg-doc-demo


# Generate a random suffix
RANDOM_SUFFIX=$(openssl rand -hex 3)

# Concatenate the resource group name with the random suffix
FULL_RESOURCE_GROUP_NAME="${RESOURCE_GROUP_NAME}"
STORAGE_NAME="strd${RANDOM_SUFFIX}" 
DOCUMENT_INTELLIGENCE_NAME="docintelligence-${RANDOM_SUFFIX}"

# Create the resource group using Azure CLI
az group create --name "$FULL_RESOURCE_GROUP_NAME" --location $LOCATION --output none

az storage account create --name $STORAGE_NAME --resource-group $FULL_RESOURCE_GROUP_NAME --location $LOCATION --sku Standard_LRS --output none

az cognitiveservices account create --name $DOCUMENT_INTELLIGENCE_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --kind FormRecognizer \
  --sku F0 \
  --location $LOCATION \
  --yes \
  --output none

# Output the full resource group name
echo "Resource group created: $FULL_RESOURCE_GROUP_NAME"
echo "Storage created: $STORAGE_NAME"
echo "Storage created: $DOCUMENT_INTELLIGENCE_NAME"