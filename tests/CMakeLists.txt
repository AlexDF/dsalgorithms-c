# Add Unity framework
add_library(unity STATIC
  unity/src/unity.c
)
target_include_directories(unity PUBLIC unity/src)

# Helper function to create tests
function(add_unity_test test_name test_source)
  add_executable(${test_name} ${test_source})
  target_link_libraries(${test_name} PRIVATE unity ${ARGN})
  target_include_directories(${test_name} PRIVATE ../include)

  # Register with CTest
  add_test(NAME ${test_name} COMMAND ${test_name})

  # Set working directory
  set_tests_properties(${test_name} PROPERTIES
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  )
endfunction()

add_unity_test(test_max test_max.c Max)
add_unity_test(test_dsalgorithms-c test_dsalgorithms-c.c dsalgorithms-c_static Max)
