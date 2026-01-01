# Jetson Development Environments

Docker-based build and runtime environments for NVIDIA Jetson platforms, optimized for computer vision and machine learning applications. Supports both ARM-based Jetson devices and x86 development machines.

## 🚀 Features

### Jetson Nano (Ubuntu 20.04)
- **CMake** 3.31.2
- **OpenCV** 4.7.0 with CUDA acceleration (compute 5.3, 7.5)
- **Intel RealSense** 2.53 with CUDA support (compute 5.3, 7.5)
- **CUDA Toolkit** 10.2
- **cuDNN** 8
- **TensorRT** 8.2.1
- **Tiny-TensorRT** (supports compute 5.3, 7.5, 8.0, 8.6)
- **Boost** 1.90.0 (static and shared libraries)

### Jetson Orin (Ubuntu 22.04)
- **CMake** 3.31.2
- **OpenCV** 4.12.0 with CUDA acceleration (compute 5.3, 7.5, 8.0, 8.6, 8.9)
- **Intel RealSense** 2.53 with CUDA support (compute 5.3, 7.5, 8.0, 8.6, 8.9)
- **CUDA Toolkit** 12.2
- **cuDNN** 9
- **TensorRT** 10.3.0
- **Tiny-TensorRT** (supports compute 5.3, 7.5, 8.0, 8.6)
- **Boost** 1.90.0 (static and shared libraries)

### x86 Development Environment (Ubuntu 20.04)
- Build and runtime containers available
- Same software stack as ARM builds with broader GPU architecture support
- Suitable for development and testing before deployment to Jetson devices

## 📋 Prerequisites

To build ARM containers on x86 hosts:

```bash
sudo apt-get install qemu binfmt-support qemu-user-static
```

## 🐳 Available Container Variants

| Container | Platform | Ubuntu | Purpose |
|-----------|----------|--------|---------|
| `jetson-nano-dev-arm-20-build` | Jetson Nano | 20.04 | Full build environment with JetPack 4.6.4 (r32.7) |
| `jetson-nano-dev-arm-orin-22-build` | Jetson Orin | 22.04 | Full build environment with JetPack 6.1 (r36.4) |
| `jetson-nano-dev-x86-20-build` | x86_64 | 20.04 | Build environment with CUDA/GPU support |
| `jetson-nano-dev-x86-20-run` | x86_64 | 20.04 | Minimal runtime environment with development tools |

## 🔨 Building

### Build All Containers (Ubuntu 20.04)
```bash
make build-all-20
```

### Build All Containers (All Versions)
```bash
make build-all
```

### Build Individual Containers
```bash
# Jetson Nano
make arm-20-build

# Jetson Orin
make arm-orin-22-build

# x86 development
make x86-20-build

# x86 runtime
make x86-20-run
```

### Custom Version Tag
```bash
VERSION=v1.0.0 make build-all
```

## 📦 Docker Hub

Pre-built images are available on Docker Hub:

- [attiladoor/jetson-nano-dev-arm-20-build](https://hub.docker.com/r/attiladoor/jetson-nano-dev-arm-20-build)
- [attiladoor/jetson-nano-dev-arm-orin-22-build](https://hub.docker.com/r/attiladoor/jetson-nano-dev-arm-orin-22-build)
- [attiladoor/jetson-nano-dev-x86-20-build](https://hub.docker.com/r/attiladoor/jetson-nano-dev-x86-20-build)
- [attiladoor/jetson-nano-dev-x86-20-run](https://hub.docker.com/r/attiladoor/jetson-nano-dev-x86-20-run)

### Pull Pre-built Images
```bash
docker pull attiladoor/jetson-nano-dev-arm-20-build:latest
docker pull attiladoor/jetson-nano-dev-arm-orin-22-build:latest
```

## 🛠️ Usage

### Interactive Development
```bash
docker run -it --rm \
  --runtime nvidia \
  --gpus all \
  -v $(pwd):/workspace \
  attiladoor/jetson-nano-dev-arm-orin-22-build:latest \
  bash
```

### Build Your Application
```bash
docker run --rm \
  --runtime nvidia \
  -v $(pwd):/workspace \
  -w /workspace \
  attiladoor/jetson-nano-dev-arm-20-build:latest \
  bash -c "mkdir build && cd build && cmake .. && make"
```

## 📝 Notes

- **CUDA Architecture Support**:
  - Jetson Nano: compute_53 and compute_75 for OpenCV/RealSense
  - Jetson Orin: compute_53, 75, 80, 86, 89 for OpenCV/RealSense
  - Tiny-TensorRT: Built with support for compute_53, 75, 80, 86
  - Architecture selection is automatic based on the target platform

- **Platform-Specific Builds**:
  - ARM builds include Jetson-specific L4T packages and NVIDIA drivers
  - Jetson Nano uses GCC 8 for CUDA 10.2 compatibility
  - Both platforms build with C++17 standard

- The runtime container (`x86-20-run`) includes additional tools:
  - GDB debugger
  - Mosquitto MQTT broker and paho-mqtt Python client
  - Node.js 18 with Node-RED and dashboard
  - Python packages: PyQt5, Mayavi, VTK, pyrealsense2, onnxruntime-gpu, onnx
  - Google Test framework
  - clang-tidy-19 for code analysis

- **Build Optimizations**:
  - Uses ccache for faster OpenCV compilation
  - Multi-architecture CUDA compilation for broader GPU support
  - Boost built with both static and shared libraries

- **Cross-Platform Compilation**: Uses Docker buildx for ARM builds on x86 hosts

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## 📄 License

See repository for license details.
