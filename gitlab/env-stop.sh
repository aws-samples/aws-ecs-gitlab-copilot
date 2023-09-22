#!/bin/sh

echo "Deleting environment $CI_COMMIT_REF_SLUG"

copilot env delete \
    --name "$CI_COMMIT_REF_SLUG" \
    --yes
