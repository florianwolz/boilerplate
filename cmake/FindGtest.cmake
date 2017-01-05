include(ExternalProject)

# Download and install GoogleMock
ExternalProject_Add(
      gtest
      GIT_REPOSITORY https://github.com/google/googletest.git
      GIT_TAG release-1.8.0
      PREFIX gtest
      # Disable install step
      INSTALL_COMMAND ""
      LOG_DOWNLOAD ON
      LOG_UPDATE 1
      LOG_CONFIGURE ON
      LOG_BUILD ON
      LOG_TEST 1
      LOG_INSTALL 1
)

add_library(libgmock IMPORTED STATIC GLOBAL)
add_dependencies(libgmock gtest)
add_library(libgmock_main IMPORTED STATIC GLOBAL)
add_dependencies(libgmock_main gtest)

# Set gtest properties
ExternalProject_Get_Property(gtest source_dir binary_dir)
set_target_properties(libgmock PROPERTIES
    "IMPORTED_LOCATION" "${binary_dir}/googlemock/libgmock.a"
    "INTERFACE_LINK_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
)

set_target_properties(libgmock_main PROPERTIES
    "IMPORTED_LOCATION" "${binary_dir}/googlemock/libgmock_main.a"
    "INTERFACE_LINK_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
)

set(GTEST_INCLUDE_DIRS ${source_dir}/googlemock/include ${source_dir}/googletest/include)

# Specify MainTest's link libraries
set(GTEST_LIBS_DIR ${binary_dir}/googlemock)

# Create
SET(GTEST_OUTPUT_DIR ${PROJECT_SOURCE_DIR}/build/tests)
file(MAKE_DIRECTORY ${GTEST_OUTPUT_DIR})

function(add_gtest test_name test_source)
    add_executable(${test_name} ${test_source})
    target_link_libraries(${test_name} libgmock libgmock_main)
    set_target_properties(${test_name}
        PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${GTEST_OUTPUT_DIR}"
    )
    add_test(${test_name} ${GTEST_OUTPUT_DIR}/${test_name})
endfunction()
