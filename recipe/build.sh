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
#    -DCMAKE_INSTALL_PREFIX=$PREFIX \
#    -Dpython_version=$(python -c "import sys; print(str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2]))")
#    -DCMAKE_INSTALL_LIBDIR=lib \

# Build step
cmake --build build -j${CPU_COUNT}
cmake --install build
