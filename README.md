# Boilerplate

This is a boilerplate project for C++ projects. Out-of-the-box it brings support for the following things:

- [x] Different modules that can be linked together. This helps to structure the project.
- [x] Google Test and Mockup. It even has the handy `ADD_GTEST` CMake macro, that does the rest. Write your tests,
      add them with the macro and use `make test` to see if everything passes. Easy-peasy.

## Usage

Usage is simple. Clone this repository, rename the `project/` directory into the name of your project and
replace `PROJECT` in all CMakeLists.txt files. Then you can start editing a module and code your stuff.

To compile the project use `make`. The tests are compiled into the internal `build/` directory and can all be executed via
`make test`. If you want to run individual tests you can use CTest, since all tests are registered via the `ADD_GTEST`
macro. For more information consult the CTest documentation.
`make clean` deletes the binaries and all CMake generated files.
