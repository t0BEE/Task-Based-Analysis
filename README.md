# Task-Based-Analysis
The code is used to evaluate if any performance differences for parallel, task-based programming between OpenMP and HPX exist.
C++ is choosen as progrmming language.

## Algorithm
A generic algorithm, fibonacci and mergesort are chosen to be implemented and compared.
The latter two are part of the [Barcelona OpenMP Benchmark Suite](https://github.com/bsc-pm/bots), whereas the generic algorithm is chosen to enable maximum flexibility in task size.

## Stress Test Scripts

## Dependencies
	### CMake
### HPX
[Get HPX](https://stellar-group.github.io/hpx/docs/sphinx/latest/html/manual/getting_hpx.html)

HPX requires some libraries, [Boost](https://www.boost.org/), [jemalloc](https://github.com/STEllAR-GROUP/hpx/issues/2524#issuecomment-282954083) and [HWLOC](https://www.open-mpi.org/projects/hwloc/).

After installing these libraries I run:
- Create a folder to install HPX, `HPX_LOCATION`, in and a subfolder as build directory
- Switch into the subfolder and execute the following commands
- `cmake -DBOOST_ROOT=$BOOST_ROOT -DHWLOC_ROOT=$HWLOC_ROOT -DHPX_WITH_MALLOC=JEMALLOC -DJEMALLOC_ROOT=$JEMALLOC_ROOT -DCMAKE_INSTALL_PREFIX=$HPX_LOCATION ~/Downloads/hpx_1.3.0`
- `make`
- `make install`

To use the installed HPX CMake variables have to be set in the CMakeList.txt file of the project.
- `HPX_INSTALL_DIR`: to the location of the installed HPX 
- `HPX_DIR`: `${HPX_INSTALL_DIR}/lib/cmake/HPX`
- `HPX_PREFIX_PATH`: `${HPX_INSTALL_DIR}`
Further information can be found [here](https://stellar-group.github.io/hpx/docs/sphinx/latest/html/manual/creating_hpx_projects.html#using-hpx-with-cmake-based-projects).


Pipenv is created according to [this site](https://docs.python-guide.org/dev/virtualenvs/).
