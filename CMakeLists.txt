# Project
# (c) 2017 by Florian Wolz
# All rights reserved.

CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12)
SET(CMAKE_COLOR_MAKEFILE ON)
SET(CMAKE_VERBOSE_MAKEFILE OFF)

SET(PACKAGE_NAME        "project")
SET(PACKAGE_VERSION     "0.0.1-dev")
SET(PACKAGE_STRING      "${PACKAGE_NAME} ${PACKAGE_VERSION}")
SET(PACKAGE_TARNAME     "${PACKAGE_NAME}--${PACKAGE_VERSION}")
SET(PACKAGE_BUGREPORT   "https://github.com/name/project/issues")

# Generate project titles
STRING(TOUPPER ${PACKAGE_NAME}	PROJECT_NAME)

PROJECT(${PACKAGE_NAME} C CXX)

# Update the directories
SET(PROJECT_MAIN_DIRECTORY ${PROJECT_SOURCE_DIR})
SET(PROJECT_SOURCE_DIRECTORY "${PROJECT_MAIN_DIRECTORY}/${PACKAGE_NAME}")

SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "../../bin")
SET(CMAKE_MODULE_PATH "${PROJECT_MAIN_DIRECTORY}/cmake")

ADD_COMPILE_OPTIONS(-std=c++1y)

# Macros for headers and sources
MACRO(ADD_HEADERS module_name module_headers)
	STRING(TOUPPER ${module_name} mod_name)
	SET(VARIABLE_NAME "PROJECT_${mod_name}_HEADERS")

	SET(${VARIABLE_NAME} "${module_headers}")
ENDMACRO()

MACRO(ADD_SOURCES module_name module_sources)
	STRING(TOUPPER ${module_name} mod_name)
	SET(VARIABLE_NAME "PROJECT_${mod_name}_SOURCES")

	# Prepend the module name before the files
	SET(mod_sources_ ${module_sources})
	SEPARATE_ARGUMENTS(mod_sources_)
	SET(mod_sources "")

	FOREACH(f ${mod_sources_})
		IF(mod_sources STREQUAL "")
			SET(mod_sources "${module_name}/${f}")
		ELSE()
			SET(mod_sources "${mod_sources} ${module_name}/${f}")
		ENDIF()
	ENDFOREACH()

	SET(${VARIABLE_NAME} "${mod_sources}")

	IF(DEFINED ${VARIABLE_NAME})
		#IF(PROJECT_SOURCES STREQUAL "")
		#	SET(PROJECT_SOURCES "${${VARIABLE_NAME}}" PARENT_SCOPE)
		#ELSE()
		#	SET(PROJECT_SOURCES "${PROJECT_SOURCES} ${${VARIABLE_NAME}}" PARENT_SCOPE)
		#ENDIF()

		ADD_LIBRARY(${module_name} SHARED ${module_sources})

		IF(PROJECT_LINK_LIBRARIES STREQUAL "")
			SET(PROJECT_LINK_LIBRARIES "${module_name}" PARENT_SCOPE)
		ELSE()
			SET(PROJECT_LINK_LIBRARIES "${PROJECT_LINK_LIBRARIES} ${module_name}" PARENT_SCOPE)
		ENDIF()
	ENDIF()
ENDMACRO()

# Enable testing
ENABLE_TESTING()

# Find Google Test and Mockup
FIND_PACKAGE(Gtest REQUIRED)

INCLUDE_DIRECTORIES(${GTEST_INCLUDE_DIRS})

INCLUDE_DIRECTORIES(${PROJECT_MAIN_DIRECTORY})
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIRECTORY})

# Setup the link libraries
#
# If you want to link projects to the main source file, just append
# the libary path to PROJECT_LINK_LIBRARIES.
SET(PROJECT_LINK_LIBRARIES "")

SET(PROJECT_SOURCES "main.cpp")

ADD_SUBDIRECTORY(project)
