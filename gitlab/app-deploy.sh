#!/bin/sh

echo "Deploying service $service"

copilot svc deploy \
    --name "$COPILOT_SERVICE" \
    --env "$CI_COMMIT_REF_SLUG" \
    --force \
    --diff-yes
