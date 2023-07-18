# Pipelines

This repo demonstrates OpenShift Pipelines

## Requirement

### Build and test a Model in a container

This functionality takes a Watson NLP model stored in IBM Cloud Object Storage (COS) then:

1. Creates a continer, packaging the model with the Watson NLP runtim
2. Deploys the container to the local OpenShift
3. Tests the container is correctly serving the model
4. If successful remove the deployment and push the container to a repository

The process is driven by configuratio documents in the model folder of this repository, where a JSON document is created for each model in COS