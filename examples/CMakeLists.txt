add_executable(Demo demo.c)
target_link_libraries(Demo PRIVATE dsalgorithms-c_shared)

set_target_properties(Demo PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)
