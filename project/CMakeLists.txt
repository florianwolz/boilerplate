# Neptune
# (c) 2016 by Aurora Finance Inc.
# All rights reserved.

# Set compiler flags
ADD_COMPILE_OPTIONS(-std=c++1y)
ADD_COMPILE_OPTIONS(-O3)

# Add the packages
ADD_SUBDIRECTORY(module)

# Compile the libaries into one
ADD_LIBRARY(libproject ${PROJECT_SOURCES})

# Add the executable
ADD_EXECUTABLE(project main.cpp)

# Link all the libraries to the executable
TARGET_LINK_LIBRARIES(project ${PROJECT_LINK_LIBRARIES})
