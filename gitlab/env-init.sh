#!/bin/sh

#Create environment only once
if copilot env ls | grep -q "$CI_COMMIT_REF_SLUG"; then
    echo "Environment already exists"
    exit 0
else
    echo "Creating environment"
fi

# Create a new environment
copilot env init \
    --app "$APP_NAME" \
    --name "$CI_COMMIT_REF_SLUG" \
    --import-vpc-id "$VPC_ID" \
    --import-public-subnets "$PUBLIC_SUBNETS" \
    --import-private-subnets "$PRIVATE_SUBNETS"

# the env init command generates a manifest file that we need to commit to the repo
git config --global user.email "gitlab@example.com"
git config --global user.name "gitlab pipeline"
git add copilot/environments/$CI_COMMIT_REF_SLUG
git commit -m "[ci skip] Add copilot environment for $CI_COMMIT_REF_SLUG"
git remote rm origin_gitlab || echo "No origin_gitlab remote"
git remote add origin_gitlab "https://ci-user:$GIT_PROJECT_ACCESS_TOKEN@gitlab.com/$CI_PROJECT_PATH.git"
git push origin_gitlab HEAD:$CI_COMMIT_REF_NAME
