# Jetson Development Environments

Docker-based build and runtime environments for NVIDIA Jetson platforms, optimized for computer vision and machine learning applications. Supports both ARM-based Jetson devices and x86 development machines.

## 🚀 Features

### Jetson Nano (Ubuntu 20.04)
- **CMake** 3.28.3
- **OpenCV** 4.7.0 with CUDA acceleration
- **Intel RealSense** 2.53 with CUDA support
- **CUDA Toolkit** 10.2
- **TensorRT** 8.2.1
- **Tiny-TensorRT** wrapper library
- **ONNX Runtime** 1.11 with TensorRT backend

### Jetson Orin (Ubuntu 22.04)
- **CMake** 3.28.3
- **OpenCV** 4.10.0 with CUDA acceleration
- **Intel RealSense** 2.53 with CUDA support
- **CUDA Toolkit** 12.2
- **TensorRT** 10.3.0
- **Tiny-TensorRT** wrapper library

### x86 Development Environment (Ubuntu 20.04)
- CPU-only variants for local testing and development
- Same software stack without CUDA/GPU dependencies
- Separate build and runtime containers for optimized deployment

## 📋 Prerequisites

To build ARM containers on x86 hosts:

```bash
sudo apt-get install qemu binfmt-support qemu-user-static
```

## 🐳 Available Container Variants

| Container | Platform | Ubuntu | Purpose |
|-----------|----------|--------|---------|
| `jetson-nano-dev-arm-20-build` | Jetson Nano | 20.04 | Full build environment with JetPack 4.6.4 |
| `jetson-nano-dev-arm-orin-22-build` | Jetson Orin | 22.04 | Full build environment with JetPack 6.1 |
| `jetson-nano-dev-x86-20-build` | x86_64 | 20.04 | CPU-only build environment |
| `jetson-nano-dev-x86-20-run` | x86_64 | 20.04 | Minimal runtime environment |

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

- The runtime container (`x86-20-run`) includes additional tools like:
  - GDB debugger
  - Mosquitto MQTT broker
  - Node.js with Node-RED
  - Python packages: PyQt5, Mayavi, VTK
  - clang-tidy-19 for code analysis

- TensorRT plugins are sourced from the system-installed packages to avoid compilation issues in newer versions

- The build process uses `buildx` for cross-platform compilation

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## 📄 License

See repository for license details.
