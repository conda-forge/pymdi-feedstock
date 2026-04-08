#!/bin/bash
mkdir build
cd build

if [ "${mpi}" == "nompi" ]; then
  MDI_MPI=OFF
else
  MDI_MPI=ON
fi

# Configure step
cmake ${CMAKE_ARGS} -GNinja -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DMDI_Python_PACKAGE=ON \
    -DMDI_CXX=ON \
    -DMDI_Fortran=OFF \
    -DMDI_Python=ON \
    -DMDI_Python_VERSION=$(python -c "import sys; print(str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2]))") \
    -DMDI_USE_MPI=${MDI_MPI} \
    ..
# Build step
ninja
ninja install
