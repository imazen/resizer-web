#!/bin/bash

TAG=$(printf "%s.%s" `git rev-list --count HEAD` `git rev-parse --short HEAD`)
IMAGE_NAME="resizer-web:$TAG"
FULL_IMAGE_NAME="gcr.io/$PROJECT_ID/$IMAGE_NAME"
ACTUAL_BRANCH=${ACTUAL_BRANCH:-$CI_BRANCH}      
NAMESPACE=`echo "resizerweb-$ACTUAL_BRANCH" | tr '[:upper:]' '[:lower:]'`

if [ "$ACTUAL_BRANCH" != "staging" -a "$ACTUAL_BRANCH" != "production" ] ; then
    echo -e "Not deploying the branch $ACTUAL_BRANCH."
    exit 0;
fi


#### INSTALL GCLOUD SDK ######

export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk

##############################


##### CONFIGURE GCLOUD SDK ####

echo $GOOGLE_AUTH > ./gcp-key.json
cat gcp-key.json | docker login -u _json_key --password-stdin https://gcr.io
gcloud auth activate-service-account --key-file gcp-key.json
gcloud config set project $PROJECT_ID
gcloud config set compute/zone $ZONE

###############################



##### INSTALL KUBECTL #######
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

#############################

###### SELECT CLUSTER ########

gcloud container clusters get-credentials $KUBE_CLUSTER

##############################

##### PUSH IMAGE TO GCR ######

docker tag resizer-web:latest $FULL_IMAGE_NAME
docker push $FULL_IMAGE_NAME

##############################

##### GET CURRENT IMAGE TAG IN PRODUCTION ######

KUBE_IMAGE=`kubectl get deployment resizer-web -n $NAMESPACE  -o=jsonpath='{$.spec.template.spec.containers[:1].image}'`

IFS=':' read -ra ADDR <<< "$KUBE_IMAGE"

CURRENT_PROD_TAG=`echo ${ADDR[1]}`
CURRENT_PROD_IMAGE=`echo ${ADDR[0]}`
NO_KEEP_IMAGES=4
NO_IMAGES=`gcloud container images list-tags gcr.io/cosmic-gizmo-230216/resizer-web  --limit=999999 --sort-by=TIMESTAMP --format='get(tags,digest)' | wc -l`
NO_DELETE_IMAGES=$(( NO_IMAGES - NO_KEEP_IMAGES ))

if [ $NO_DELETE_IMAGES -lt 0 ]; then
	NO_DELETE_IMAGES=0
fi

IMAGES_TO_DELETE=`gcloud container images list-tags gcr.io/cosmic-gizmo-230216/resizer-web  --limit=999999 --sort-by=TIMESTAMP --format='get(tags,digest)' | head -n $NO_DELETE_IMAGES`

echo "$IMAGES_TO_DELETE" 
echo "$IMAGES_TO_DELETE" |
while read -r line
do
	TAG_NO=`echo $line | awk '{ print NF} '`
    TAG=
    DIGEST=

	if [ $TAG_NO -eq 1 ]; then
		TAG="default "
    	DIGEST=`echo $line | awk '{ print $1 }'`
	else
    	TAG=`echo $line | awk '{ print $1} '`
    	DIGEST=`echo $TAG$line | awk '{ print $2 }'`
	fi

    if [ "$TAG" == "$CURRENT_PROD_TAG" ]; then
        echo "found prod tag. not deleting - $TAG"
    else
		if [ -n "$TAG" ]; then
            echo "deleting - $TAG - $DIGEST"
			gcloud container images delete -q --force-delete-tags "${CURRENT_PROD_IMAGE}@${DIGEST}"
        fi
    fi

done



##############################


##### DEPLOY TO K8S CLUSTER ##
cat deployment.yaml | envsubst | kubectl apply -f -

##############################

#./scripts/update_env.sh
