mkdir build
cd build

if "%VS_MAJOR%" == "9" (
ECHO VS 2008
set CXXFLAGS=%CXXFLAGS:-D_hypot=hypot
) else (
REM This is a fix for a CMake bug where it crashes because of the "/GL" flag
REM See: https://gitlab.kitware.com/cmake/cmake/issues/16282
set CXXFLAGS=%CXXFLAGS:-GL=%
set CFLAGS=%CFLAGS:-GL=%
)

if "%mpi%" == "nompi" (
    set MDI_MPI=OFF
) else (
    set MDI_MPI=ON
)

for /f "usebackq" %%v in (`python -c "import sys; print(str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2]))"`) do set PYTHON_VERSION=%%v

cmake -G Ninja %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_INCLUDE_PATH:PATH="%LIBRARY_INC%" ^
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
    -DMDI_Python_PACKAGE=ON ^
    -DMDI_CXX=ON ^
    -DMDI_Fortran=OFF ^
    -DMDI_Python=ON ^
    -DMDI_Python_VERSION=%PYTHON_VERSION% ^
    -DMDI_USE_MPI=%MDI_MPI% ^
    ..
ninja install
