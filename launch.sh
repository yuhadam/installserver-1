#! /bin/sh

JOB_NAME=$1
JOB_PATH=$2
MIP=$3
IMAGE_NAME=$MIP:5000/$JOB_NAME

cd $JOB_PATH

curl -L -H 'Content-Type: application/json' -X GET http://$MIP:8080/v2/apps/chronos/ > chronos.txt && wait

CHRONOS_ENDPOINT_IP=$(cat chronos.txt | jq '.app.tasks[0].host' | sed 's/"//g'  )
CHRONOS_ENDPOINT_PORT=$(cat chronos.txt | jq '.app.tasks[0].ports[0]')

echo $CHRONOS_ENDPOINT_PORT
echo $CHRONOS_ENDPOINT_IP



docker build --tag $IMAGE_NAME . && wait

#docker login -u ichthysngs -p dlrxntm123 && wait

docker push $IMAGE_NAME && wait


curl -L -H 'Content-Type: application/json' -X POST -d @docker.json $CHRONOS_ENDPOINT_IP:$CHRONOS_ENDPOINT_PORT/scheduler/iso8601 && wait
curl -L -X PUT $CHRONOS_ENDPOINT_IP:$CHRONOS_ENDPOINT_PORT/scheduler/job/$JOB_NAME
