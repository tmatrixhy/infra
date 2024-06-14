#!/bin/bash

# Set variables
CERT_DIR="$(dirname $0)/certificates"
CA_KEY="${CERT_DIR}/ca.key"
CA_CERT="${CERT_DIR}/ca.crt"
SERVER_KEY="${CERT_DIR}/server.key"
SERVER_CERT="${CERT_DIR}/server.crt"

# Generate self-signed certificates
openssl req -newkey rsa:4096 -nodes -keyout ${CA_KEY} -x509 -days 365 -out ${CA_CERT} -subj "/CN=k3d-ca"
openssl req -newkey rsa:4096 -nodes -keyout ${SERVER_KEY} -out ${CERT_DIR}/server.csr -subj "/CN=${TF_VAR_k3d_api_server}"
openssl x509 -req -in ${CERT_DIR}/server.csr -CA ${CA_CERT} -CAkey ${CA_KEY} -CAcreateserial -out ${SERVER_CERT} -days 365
