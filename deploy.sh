# Generate a unique Docker tag (use git commit hash or timestamp)
DOCKER_TAG=$(git rev-parse --short HEAD)

helm repo add apache-airflow https://airflow.apache.org

# Deploy with Helm using the new tag
echo "Deploying with Helm using tag $DOCKER_TAG"
helm upgrade --install airflow apache-airflow/airflow \
  --namespace airflow --create-namespace \
  --values values.yaml \
  --set images.airflow.tag="t$DOCKER_TAG" \
  --version 1.18.0 \
  --force
