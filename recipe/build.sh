#!/bin/bash
mkdir build
cd build

if [ "${mpi}" == "nompi" ]; then
  MDI_MPI=OFF
else
  MDI_MPI=ON
fi

# When cross-compiling, CMake cannot execute the arm64 mpicc wrapper to
# auto-detect MPI.  Provide the paths directly using CMake 3.17+ FindMPI hints.
MPI_CMAKE_ARGS=""
if [[ "${MDI_MPI}" == "ON" ]] && [[ "${build_platform}" != "${target_platform}" ]]; then
  MPI_CMAKE_ARGS="-DMPI_C_HEADER_DIR=${PREFIX}/include \
    -DMPI_C_LIB_NAMES=mpi \
    -DMPI_mpi_LIBRARY=${PREFIX}/lib/libmpi${SHLIB_EXT}"
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
    ${MPI_CMAKE_ARGS} \
    ..
# Build step
ninja
ninja install
