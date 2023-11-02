#! /bin/bash
function get_subnets {
    vpc_id=$1
    query=$2
    profile=$3
    subnets=""
    describe_subnets=($(aws ec2 describe-subnets --filter Name=vpc-id,Values=$vpc_id --query $query --output text --profile $profile))
    for subnet in ${describe_subnets[@]}
    do
        subnets+="$subnet,"
    done
    subnets=${subnets%,}
    retval=$subnets
}

copilot app init $APP_NAME

copilot env init --app $APP_NAME --name $DEV_ENV_NAME --profile $DEV_PROFILE --default-config --container-insights
copilot env deploy --name $DEV_ENV_NAME

copilot svc init --app $APP_NAME --name service-a --svc-type "Backend Service" -d "service-a/Dockerfile" 
copilot svc deploy --name service-a --env $DEV_ENV_NAME

copilot svc init --app $APP_NAME --name service-b --svc-type "Backend Service" -d "service-b/Dockerfile" 
copilot svc deploy --name service-b --env $DEV_ENV_NAME

export DEV_VPC_ID=$(aws ec2 describe-vpcs --filters Name=tag:copilot-application,Values=$APP_NAME --query 'Vpcs[0].VpcId' --output text --profile $DEV_PROFILE)

query='Subnets[?MapPublicIpOnLaunch==`false`].SubnetId'
get_subnets $DEV_VPC_ID $query $DEV_PROFILE
export DEV_PRIVATE_SUBNETS=$retval

query='Subnets[?MapPublicIpOnLaunch==`true`].SubnetId'
get_subnets $DEV_VPC_ID $query $DEV_PROFILE
export DEV_PUBLIC_SUBNETS=$retval

echo "DEV VPC_ID: $DEV_VPC_ID"
echo "DEV PUBLIC_SUBNETS: $DEV_PUBLIC_SUBNETS"
echo "DEV PRIVATE_SUBNETS: $DEV_PRIVATE_SUBNETS"
