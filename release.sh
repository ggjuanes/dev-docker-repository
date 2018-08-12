# Config
# Force exit if any command fails.
set -e

USERNAME=`cat DOCKER_USERNAME`
IMAGE=$1

# Move to image
cd $IMAGE

# Get versoin
VERSION=`cat VERSION`
echo "version: $VERSION"

# tag in github
git tag -a "$IMAGE-$VERSION" -m "image $IMAGE version $VERSION"
git push
git push --tags

# Prepare images
docker build -t $USERNAME/$IMAGE:latest .
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$VERSION

# Push images to Docker Hub
docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$VERSION
