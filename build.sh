set -e

CONTAINER_BASE_NAME="attiladoor/jetson-nano-dev-"
DOCKER_COMMAND=$1
ARCH=$2
UBUNTU_VERSION=$3
VARIANT_OPT=$4

if [ -z $VERSION ]
then
    VERSION=latest
fi

if [ $ARCH == "arm" ]
then
    if [ $UBUNTU_VERSION == "20" ]
    then
        BASE="arm64v8/ubuntu:20.04"
    else
        echo "Wrong ubuntu version:" $UBUNTU_VERSION
        exit 1
    fi
    DOCKER_FILE="docker-build/Dockerfile"
    VARIANT_TAG="-build"
    JETPACK_RELEASE=r32.7
    TEGRA_VERSION="t210"
    ARM_DOCKER_PLATFORM="--platform=linux/arm64"

elif [ $ARCH == "arm-orin" ]
then
    # https://developer.nvidia.com/embedded/jetson-linux-r362
    # https://catalog.ngc.nvidia.com/orgs/nvidia/containers/l4t-base/tags
    if [ $UBUNTU_VERSION == "22" ]
    then
        BASE="nvcr.io/nvidia/l4t-base:r36.2.0"
    else
        echo "Wrong ubuntu version:" $UBUNTU_VERSION
        exit 1
    fi
    DOCKER_FILE="docker-build/Dockerfile"
    VARIANT_TAG="-build"
    JETPACK_RELEASE=r36.4
    TEGRA_VERSION="t234"
    ARM_DOCKER_PLATFORM="--platform=linux/arm64"

elif [ $ARCH == "x86" ]
then
    if [ $UBUNTU_VERSION == "22" ]
    then
        BASE="nvcr.io/nvidia/tensorrt:24.08-py3"
    else
        echo "Wrong ubuntu version:" $UBUNTU_VERSION
        exit 1
    fi

    ARCH="x86"

    if [ -z $VARIANT_OPT ]
    then
        echo "Container variant should be specified"
        exit 1
    elif [ $VARIANT_OPT == "run" ]
    then
        VARIANT_TAG="-run"
        BASE="${CONTAINER_BASE_NAME}${ARCH}-${UBUNTU_VERSION}-build:${VERSION}"
    elif [ $VARIANT_OPT == "build" ]
    then
        VARIANT_TAG="-build"
    fi

    DOCKER_FILE="docker${VARIANT_TAG}/Dockerfile"

else
    echo "Wrong architecture:" $ARCH
    exit 1
fi


if [ $UBUNTU_VERSION == "20" ]
then
    OPENCV_VERSION="4.7.0"
elif [ $UBUNTU_VERSION == "22" ]
then
    OPENCV_VERSION="4.12.0"
fi

if [[ $DOCKER_COMMAND == "build" ]]
then
    docker buildx  --debug build $ARM_DOCKER_PLATFORM \
        --build-arg BASE=$BASE \
        --build-arg ARCH=$ARCH \
        --build-arg JETPACK_RELEASE=$JETPACK_RELEASE \
        --build-arg TEGRA_VERSION=$TEGRA_VERSION \
        --build-arg OPENCV_VERSION=$OPENCV_VERSION \
        --tag $CONTAINER_BASE_NAME$ARCH-$UBUNTU_VERSION$VARIANT_TAG:$VERSION \
        --file $DOCKER_FILE .
elif [[ $DOCKER_COMMAND == "push" ]]
then
echo $CONTAINER_BASE_NAME$ARCH-$UBUNTU_VERSION$VARIANT_TAG:$VERSION
docker push $CONTAINER_BASE_NAME$ARCH-$UBUNTU_VERSION$VARIANT_TAG:$VERSION
else
echo "Invalid docker command $DOCKER_COMMAND"
fi
