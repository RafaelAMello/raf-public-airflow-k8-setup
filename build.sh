# Generate a unique Docker tag (use git commit hash or timestamp)
DOCKER_TAG=t$(git rev-parse --short HEAD)

# Build Docker image with unique tag
echo "Building Docker image: $IMAGE_NAME:$DOCKER_TAG"
docker buildx build -t $IMAGE_NAME:$DOCKER_TAG . --platform linux/amd64,linux/arm64 --push