#/usr/bin/env bash

set -ex

mkdir build
cd build
# Configure step
cmake -Bbuild \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DPython_EXECUTABLE=${PYTHON} \
    -DBUILD_SHARED_LIBS=ON \
    -DMDI_Fortran=OFF \
    -DMDI_Python=ON \
    -DMDI_CXX=ON \
    -DMDI_Python_PACKAGE=ON
    -Dpython_version=$(python -c "import sys; print(str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2]))")

# Build step
cmake --build build -j${CPU_COUNT}
cmake --install build
