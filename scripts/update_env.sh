#!/bin/bash

declare -A ENVMAP

err() {
    echo "- ERROR: $*"
    echo "Exiting script."
    exit 1
}

handle_error() {
    if [ ! $? -eq 0 ];then
        err "$*"
    fi
}

# M A I N #

# sample value CLIENT_PATTERN='^LABEL_'
if [ -z "${CLIENT_PATTERN+x}" ] || [ -z "${CLIENT_PATTERN}" ];then
    echo "CLIENT_PATTERN not set."
    exit 0
fi

ENV_VARIABLES=$(printenv|grep -E "${CLIENT_PATTERN}")

if [ -z "${ENV_VARIABLES+x}" ] || [ -z "${ENV_VARIABLES}" ];then
    echo "No env variables matches the pattern. Please check"
    exit 0
fi

if [ -z "${KUBE_CLUSTER+x}" ] || [ -z "${ZONE+x}" ] || [ -z "${PROJECT_ID+x}" ] || [ -z "${NAMESPACE+x}" ];then
    err "Mandatory k8 cluster env variables not found. Please check"
fi

for env in ${ENV_VARIABLES}
do
    key=$(echo $env|sed 's/'"${CLIENT_PATTERN}"'//g'|cut -d'=' -f1)
    value=$(echo $env|cut -d'=' -f2)
    ENVMAP[${key}]=${value}
done

#for K in "${!ENVMAP[@]}"
#do
#    echo $K,${ENVMAP[${K}]}
#done

# connect to cluster
#gcloud container clusters get-credentials ${KUBE_CLUSTER} --zone ${ZONE} --project ${PROJECT_ID} > /dev/null
#handle_error "Unable to authenticate to cluster"

if [ -z ${DEPLOYMENT_NAME+x} ]
then
    DEPLOYMENT_NAME=$(kubectl -n ${NAMESPACE} get deploy -o name|sed 's/^deployment.extensions\///g')
fi

for dep in ${DEPLOYMENT_NAME}
do
    # get container/app name:
    APP_NAME=$(kubectl -n ${NAMESPACE} get deploy ${DEPLOYMENT_NAME} -o=jsonpath='{.spec.template.spec.containers[0].name}')
    
    echo "Updating env variables for deployment: ${DEPLOYMENT_NAME} application: ${APP_NAME}"

    JSON_STRING_START='{"spec":{"template":{"spec":{"containers":[{"name":"'
    JSON_STRING_MID='","env":['
    JSON_STRING_END=']}]}}}}'

    DELIMITER=','
    ENVMAP_LENGTH=$(echo ${#ENVMAP[@]})
    i=0
    for K in "${!ENVMAP[@]}"
    do
        i=$(expr $i + 1)
        KEY=$K
        VALUE=${ENVMAP[${K}]}
        if [ ${ENVMAP_LENGTH} -eq ${i} ];then
            ENV_JSON_STRING=${ENV_JSON_STRING}$(jq -n --arg var1 "$KEY" --arg var2 "$VALUE" '{name:$var1,value:$var2}')
            ENV_JSON_STRING=$(echo ${ENV_JSON_STRING}|sed 's/ //g')
        else
            ENV_JSON_STRING=${ENV_JSON_STRING}$(jq -n --arg var1 "$KEY" --arg var2 "$VALUE" '{name:$var1,value:$var2}')${DELIMITER}
        fi
    done
    JSON_STRING_FULL="${JSON_STRING_START}${APP_NAME}${JSON_STRING_MID}${ENV_JSON_STRING}${JSON_STRING_END}"
    #echo $JSON_STRING_FULL

    # run kubectl patch command:
    KUBECTL_CMD="kubectl -n ${NAMESPACE} patch deployment ${DEPLOYMENT_NAME} -p '"${JSON_STRING_FULL}"'"
    echo $KUBECTL_CMD
    OUT=`bash -c "$KUBECTL_CMD"`

    if [ $? -eq 0 ];then
        if [[ ${OUT} == *"no change"* ]];then
            echo "No change in Env variables"
        else
            echo "Env variables update completed"
        fi
    else
        if [[ ${OUT} == *"not patched"* ]];then
            echo "No change in Env variables"
        else
            err "Env variables update failed: ${OUT}"
        fi
    fi
done


