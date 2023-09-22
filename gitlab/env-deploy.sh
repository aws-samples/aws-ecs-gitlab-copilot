#!/bin/sh

#Copilot checks if there are changes automatically
copilot env deploy \
    --name "$CI_COMMIT_REF_SLUG" \
    --force \
    --diff-yes
