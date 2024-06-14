#!/bin/bash

# Create k3d cluster
k3d cluster create ${TF_VAR_k3d_cluster_name} --api-port ${TF_VAR_k3d_api_server}:${TF_VAR_k3d_server_port} --wait

# Export kubeconfig
export KUBECONFIG=$(k3d kubeconfig write ${TF_VAR_k3d_cluster_name})

# Create a directory for certificates
mkdir -p $(dirname $0)/certificates
