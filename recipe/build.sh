#!/bin/bash
mkdir build
cd build
# Configure step
cmake ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -Dpython_package=ON \
    -Dlanguage=Python \
    -Dpython_version=$(python -c "import sys; print(str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2]))") \
    ..
# Build step
make -j${CPU_COUNT}
make install
