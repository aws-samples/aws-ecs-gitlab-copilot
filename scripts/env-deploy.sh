#!/bin/sh

if [ "$CI_COMMIT_REF_SLUG" == 'main' ]; then ENV="dev"; else ENV=$CI_COMMIT_REF_SLUG; fi

mkdir -p copilot/environments/$ENV
copilot env show -n $ENV --manifest > copilot/environments/$ENV/manifest.yml

#Copilot checks if there are changes automatically
copilot env deploy \
    --name "$ENV" \
    --force \
    --diff-yes
