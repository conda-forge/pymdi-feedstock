#/usr/bin/env bash

set -ex

# Configure step
cmake -Bbuild \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DMDI_Fortran=OFF \
    -DMDI_Python=ON \
    -DMDI_CXX=OFF \
    -DMDI_Python_PACKAGE=ON \
    -DPython_EXECUTABLE=$(which python)

# Build step
cmake --build build -j${CPU_COUNT}
cmake --install build
