#!/bin/sh

if [ "$CI_COMMIT_REF_SLUG" == 'main' ]; then ENV="dev"; else ENV=$CI_COMMIT_REF_SLUG; fi

#Create environment only once
if copilot env ls -a $APP_NAME | grep -q "$ENV"; then
    echo "Environment already exists"
    exit 0
else
    if [ "$ENV" == 'dev' ]; then
        echo "You must create dev from bootsrap script locally"
        exit 1
    fi
    echo "Creating preview environment.."
fi

# Create a new environment
copilot env init \
    --app "$APP_NAME" \
    --name "$ENV" \
    --import-vpc-id "$VPC_ID" \
    --import-public-subnets "$PUBLIC_SUBNETS" \
    --import-private-subnets "$PRIVATE_SUBNETS" 
