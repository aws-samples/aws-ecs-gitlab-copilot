#!/bin/sh

if [ "$CI_COMMIT_REF_SLUG" == 'main' ]; then ENV="dev"; else ENV=$CI_COMMIT_REF_SLUG; fi

echo "Deploying service $COPILOT_SERVICE"

copilot svc deploy \
    --name "$COPILOT_SERVICE" \
    --env "$ENV" \
    --force \
    --diff-yes
