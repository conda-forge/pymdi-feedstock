#/usr/bin/env bash

set -ex

# Configure step
cmake -Bbuild \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -Dpython_package=ON \
    -Dlanguage=Python \
    -Dpython_version=$(python -c "import sys; print(str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2]))")

# Build step
cmake --build build -j${CPU_COUNT}
cmake --install build
