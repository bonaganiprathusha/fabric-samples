# Use the Gitpod base image
FROM gitpod/workspace-full:latest

# Install Hyperledger Fabric CLI tools
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/hyperledger/fabric/releases/download/v2.2.0/hyperledger-fabric-linux-amd64-2.2.0.tar.gz && \
    tar -xvzf hyperledger-fabric-linux-amd64-2.2.0.tar.gz && \
    mv bin/* /usr/local/bin/ && \
    rm -rf hyperledger-fabric-linux-amd64-2.2.0.tar.gz

# Set environment variables for Fabric tools
ENV PATH=$PATH:/usr/local/bin
