/**
 * @file dsalgorithms-c.c
 * @brief dsalgorithms-c main library
 * @details This file provides the public API implementations that 
 *          wrap the private, internal functions.
 */

#include "dsalgorithms-c/dsalgorithms-c.h"
#include "dsalgorithms-c/max.h"

// Public exports
int dsalgorithms_maxArrayInt(const int *array, size_t n) {
  return dsa_maxArrayInt(array, n);
}

int dsalgorithms_maxInt(const int a, const int b) {
  return dsa_maxInt(a, b);
}
