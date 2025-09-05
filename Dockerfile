FROM ubuntu:latest

# Install all build dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    debhelper \
    cmake \
    dpkg-dev \
    gcc \
    libc6-dev \
  && rm -rf /var/lib/apt/lists/*

# Starting working directory
WORKDIR /workspace-root/workspace

# Default command
CMD ["/bin/bash"]
