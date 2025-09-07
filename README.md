# dsalgorithms-c
A C library of data structures and algorithms.

## Documentation
You can find the full API documentation for dsalgorithms-c [here](https://alexdf.github.io/dsalgorithms-c/index.html)

## Quick Install (Debian-based distros)
Download installer script via wget:
```bash
wget https://github.com/AlexDF/dsalgorithms-c/releases/download/v0.1.0.alpha1-1/install_dsalgorithms-c_debian_amd64_arm64.sh
```

or, via curl:
```bash
curl -L -O https://github.com/AlexDF/dsalgorithms-c/releases/download/v0.1.0.alpha1-1/install_dsalgorithms-c_debian_amd64_arm64.sh
```

Give it executable permissions and run:
```bash
chmod +x install_dsalgorithms-c_debian_amd64_arm64.sh && ./install_dsalgorithms-c_debian_amd64_arm64.sh
```

The installer script will download the latest release packages, install via apt-get, and clean up downloaded files after installation.

## Uninstallation
If the above script was used to install, or if you installed .deb packagas manually via apt:
```bash
sudo apt remove libdsalgorithms-c0 libdsalgorithms-c-dev
```

## Usage
Library functions are prefixed with 'dsalgorithms_':
```c
#include <dsalgorithms-c/dsalgorithms-c.h>

int array[] = { 4, 7 ,5 };
size_t arraySize = sizeof(array) / sizeof(array[0]);

int maxElement = dsalgorithms_maxArrayInt(array, arraySize);
// maxElement equals 7
```

## API
dsalgorithms-c is in super early development and only contains the following functions at the moment. Many more are on the way!

### Maximum Algorithms
| Function | Description |
|----------|-------------|
| `dsalgorithms_maxInt(int a, int b)` | Returns the larger of `a` and `b`. |
| `dsalgorithms_maxArrayInt(int *array, size_t size)` | Returns the maximum value in an integer array. |
