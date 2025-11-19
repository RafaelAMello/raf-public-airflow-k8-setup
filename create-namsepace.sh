#!/bin/bash

REDIS_PASSWORD=$(python3 -c 'import secrets; print(secrets.token_hex(8))')

kubectl create namespace airflow

kubectl config set-context --current --namespace=airflow

kubectl create secret generic airflow-redis-secret --from-literal="password=$REDIS_PASSWORD" --from-literal="connection=redis://default:$REDIS_PASSWORD@airflow-redis:6379"

kubectl create secret generic airflow-api-secret-key --from-literal="api-secret-key=$(python3 -c 'import secrets; print(secrets.token_hex(16))')"

kubectl create -f secrets.yml
