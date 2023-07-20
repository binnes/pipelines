# Access to container registries

If you need to authenticate to a container registry you need to create a secret then add it to the service account:

export CONTAINER_REGISTRY_SERVER='example-registry-quay-openshift-operators.bi-ocp-162e406f043e20da9b0ef0731954a894-0000.eu-gb.containers.appdomain.cloud' 
export CONTAINER_REGISTRY_USER='brian'
export CONTAINER_REGISTRY_PASSWORD='<your registry user password>'

kubectl create secret -n pipelines-tutorial docker-registry local-quay-registry-secret \
  --docker-server=$CONTAINER_REGISTRY_SERVER \
  --docker-username=$CONTAINER_REGISTRY_USER \
  --docker-password=$CONTAINER_REGISTRY_PASSWORD

kubectl patch serviceaccount pipeline \
  -p '{"secrets": [{"name": "local-quay-registry-secret"}]}'