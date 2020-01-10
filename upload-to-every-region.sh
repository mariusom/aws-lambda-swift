#!/bin/bash
set -e

REGIONS=("us-east-2" "us-east-1" "us-west-1" "us-west-2"  "ca-central-1" "eu-central-1" "eu-west-1" "eu-west-2" "eu-west-3" "eu-north-1" "sa-east-1")

for i in ${!REGIONS[@]};
do
  
  REGION=${REGIONS[$i]}

  echo "-------------------------------------"
  echo "Switching to: $REGION"

  VERSION=$(aws2 --region $REGION --profile aws-lambda-swift lambda publish-layer-version \
    --layer-name swift \
    --compatible-runtimes "provided" \
    --license-info "Apache-2.0" \
    --zip-file fileb://$(pwd)/tmp/swift-lambda-layer.zip \
    --output json | jq -r '.Version')

  echo "✅ Uploaded version"
  ACCESS=$(aws2 --region $REGION --profile aws-lambda-swift lambda add-layer-version-permission \
    --layer-name swift \
    --statement-id "public-access" \
    --action "lambda:GetLayerVersion" \
    --principal "*" \
    --version-number $VERSION \
    --output json)

  echo "✅ Allowed access"

done

echo "All uploaded"