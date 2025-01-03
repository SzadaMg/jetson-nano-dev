ARG BASE
FROM ${BASE}

# install mqtt broker
RUN apt-get update && \
    apt-get install -y mosquitto gdb

RUN pip3 install paho-mqtt


# install gtest
RUN git clone https://github.com/google/googletest.git && \
    cd googletest && \
    mkdir build && cd build && \
    cmake .. -DBUILD_SHARED_LIBS=ON -DINSTALL_GTEST=ON -DCMAKE_INSTALL_PREFIX:PATH=/usr && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    cd ../../ && \
    rm -rf googletest

# install nodejs
RUN wget -O - https://deb.nodesource.com/setup_18.x | bash && \
    wget -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y nodejs yarn && \
    npm install -g --unsafe-perm node-red node-red-dashboard moment

# install realsense python
RUN pip3 install pyrealsense2

RUN pip3 install onnxruntime-gpu onnx

# mayavi and GUI packages
RUN apt-get -yqq install \
    '^libxcb.*-dev' \
    libx11-xcb-dev \
    libglu1-mesa-dev \
    libxrender-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev

RUN pip3 install --upgrade pip

RUN pip3 install pyqt5

#https://github.com/enthought/mayavi/issues/1325
RUN pip3 install numpy==1.24.4 vtk==9.3.0
RUN pip3 install mayavi --no-cache-dir --verbose  --no-build-isolation

RUN wget -qO- https://apt.llvm.org/llvm.sh | bash -s -- 19 && \
    apt-get install -y clang-tidy-19