#!/bin/bash

# dsalgorithms-c Installation Script for Debian-based Systems
# Supports AMD64 and ARM64 architectures

# Configuration
VERSION="0.1.0.alpha1-1"
BASE_URL="https://github.com/AlexDF/dsalgorithms-c/releases/download/v${VERSION}"

set -e # exit on any error

# Print error message and exit
error_exit() {
  echo "Error: $1" >&2
  exit 1
}

TITLE="dsalgorithms-c Installation Script v${VERSION}"
printf "\n"
printf '=%.0s' $(seq 1 ${#TITLE})
printf "\n"
echo "$TITLE"
printf '=%.0s' $(seq 1 ${#TITLE})
printf "\n\n"

# Check if system is Debian-based
echo "Checking if system is Debian-based..."
if [ ! -f /etc/debian_version ]; then
  error_exit "A Debian-based Linux distro is required to run this script."
fi
echo "✓ Debian-based system detected"

# Architecture mappings - add new architectures here
declare -A ARCH_PACKAGES=(
  ["amd64"]="libdsalgorithms-c0_${VERSION}_amd64.deb libdsalgorithms-c-dev_${VERSION}_amd64.deb"
  ["arm64"]="libdsalgorithms-c0_${VERSION}_arm64.deb libdsalgorithms-c-dev_${VERSION}_arm64.deb" 
)

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Download file using wget or curl, whichever is available
download_file() {
  local url="$1"
  local filename="$2"

  if command_exists wget; then
    echo "Downloading $filename with wget ..."
    wget -O "$filename" "$url"
  elif command_exists curl; then
    echo "Downloading $filename with curl ..."
    curl -L -o "$filename" "$url"
  else
    error_exit "Commands 'wget' and 'curl' do not exist."
  fi
}

# Check for wget or curl
echo "Checking for download tools..."
if ! command_exists wget && ! command_exists curl; then
  error_exit \
    "The programs 'wget' and 'curl' were not detected on this system. 
       One of them is required so the script can download the installation packages. 
       Please install either 'wget' or 'curl' onto your system and re-run this script."
fi

if command_exists wget; then
  echo "✓ wget found"
elif command_exists curl; then
  echo "✓ curl found"
fi

# Detect architecture
echo "Detecting system architecture..."
ARCH=$(dpkg --print-architecture)
echo "Detected architecture: $ARCH"

# Check if architecture is supported
if [[ ! -v ARCH_PACKAGES["$ARCH"] ]]; then
  error_exit "Only AMD64 and ARM64 CPU architectures are supported at this time."
fi

# Get package list for the detected architecture
PACKAGES=(${ARCH_PACKAGES["$ARCH"]})
echo "Packages to download: ${PACKAGES[*]}"

# Download packages
echo "Downloading packages..."
# Create temp directory for downloads
TEMP_DIR="/tmp"
cd "$TEMP_DIR"

for package in "${PACKAGES[@]}"; do
  url="${BASE_URL}/${package}"
  download_file "$url" "$package"
  echo "✓ Downloaded: $package"
done

# Install packages using apt-get
echo "Installing packages..."
# sudo apt-get update

# Install each package individually
for package in "${PACKAGES[@]}"; do
  echo "Installing: $package"
  sudo apt-get install -y "$TEMP_DIR/$package"
done

# Clean up downloaded files
echo "Cleaning up downloaded files..."
for package in "${PACKAGES[@]}"; do
  if [ -f "$package" ]; then
    rm "$package"
    echo "✓ Removed: $package"
  fi
done
cd - >/dev/null
rmdir "$TEMP_DIR" 2>/dev/null || true

echo ""
echo "Installation completed successfully!"
echo "dsalgorithms-c version ${VERSION} has been installed."
echo ""
echo "To uninstall later, you can use:"
echo "  sudo apt-get remove libdsalgorithms-c0 libdsalgorithms-c-dev"
