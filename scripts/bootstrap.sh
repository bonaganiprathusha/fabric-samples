#!/bin/bash

# Exit on first error, print all commands.
set -e

# Fetch the binaries and Docker images
export VERSION=2.2.0
export CA_VERSION=1.4.9
export ARCH=$(dpkg --print-architecture)

dockerFabricPull() {
  local FABRIC_TAG=$1
  for IMAGES in peer orderer ccenv tools baseos nodeenv; do
    echo "==> FABRIC IMAGE: $IMAGES"
    echo
    docker pull hyperledger/fabric-$IMAGES:$FABRIC_TAG
    docker tag hyperledger/fabric-$IMAGES:$FABRIC_TAG hyperledger/fabric-$IMAGES
  done
}

dockerCaPull() {
  local CA_TAG=$1
  echo "==> FABRIC CA IMAGE"
  echo
  docker pull hyperledger/fabric-ca:$CA_TAG
  docker tag hyperledger/fabric-ca:$CA_TAG hyperledger/fabric-ca
}

# Pull Hyperledger Fabric binaries
echo "===> Downloading version ${VERSION} platform specific fabric binaries"
curl -sSL https://bit.ly/2ysbOFE | bash -s -- ${VERSION} ${CA_VERSION}

# Pull Hyperledger Fabric docker images
echo "===> Pulling fabric Images"
dockerFabricPull ${VERSION}

dockerCaPull ${CA_VERSION}
