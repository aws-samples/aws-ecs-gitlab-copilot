#!/bin/sh

if [ "$CI_COMMIT_REF_SLUG" == 'main' ]; then ENV="dev"; else ENV=$CI_COMMIT_REF_SLUG; fi

if [ "$CI_MERGE_REQUEST_TARGET_BRANCH_NAME" == 'main' ]; then printf "Target branch is main.\n"; else printf "Target branch is not main.\n" && return 1; fi

if copilot env ls | grep -q "$ENV"; then

    echo "Deleting $COPILOT_SERVICE_A:"
    copilot svc delete --name $COPILOT_SERVICE_A --env $ENV --yes

    echo "Deleting $COPILOT_SERVICE_B:"
    copilot svc delete --name $COPILOT_SERVICE_B --env $ENV --yes

    echo "Deleting environment $ENV"
    copilot env delete \
        --name "$ENV" \
        --yes
else
    echo "Environment doesn't exists!"
    exit 0
fi


