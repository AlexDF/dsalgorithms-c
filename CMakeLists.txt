cmake_minimum_required(VERSION 3.10)
project(dsalgorithms-c VERSION 0.1.0 LANGUAGES C)

# Full Version, with optional pre-release label
set(PROJECT_FULL_VERSION "${PROJECT_VERSION}~alpha1-1")
set(CMAKE_C_STANDARD 17)

# Output everything to build/lib directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Build both static and shared versions
add_library(Max OBJECT src/max.c)
add_library(dsalgorithms-c_static STATIC src/dsalgorithms-c.c)
add_library(dsalgorithms-c_shared SHARED src/dsalgorithms-c.c)

# Link dependendies, point to include directories,
# and set base name of compiled library files (.a, .so, etc) 
# to 'dsalgorithms-c'. Users then only have to link with 'gcc ... -ldsalgorithms-c'.
# Links dynamically by default. Use the '-static' flag to force static linking.
foreach(lib dsalgorithms-c_static dsalgorithms-c_shared)
    target_link_libraries(${lib} PRIVATE Max)
    target_include_directories(${lib} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    )
    set_target_properties(${lib} PROPERTIES OUTPUT_NAME dsalgorithms-c)
endforeach()

target_include_directories(Max PRIVATE include)

# Set SOVERSION for shared library (for .deb packaging)
set_target_properties(dsalgorithms-c_shared PROPERTIES
  VERSION ${PROJECT_VERSION}
  SOVERSION ${PROJECT_VERSION_MAJOR}
)

# Use GNUInstallDirs default directories for installation
include(GNUInstallDirs)

# Install static and shared libraries
install(TARGETS dsalgorithms-c_static dsalgorithms-c_shared
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# Install dsalgorithms-c directory containing header files
install(DIRECTORY include/dsalgorithms-c
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  FILES_MATCHING PATTERN "*.h"
)

# Enable unit testing
option(BUILD_TESTS "Build tests" ON)
if(BUILD_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()

# Optional: build examples
if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/examples)
  add_subdirectory(examples)
endif()
