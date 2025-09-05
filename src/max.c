/**
 * @file max.c
 * @brief Internal implementations of the maximum value module (max.h)
 * @details Contains the internal implementation functions for the 
 *          maximum value operations in max.h. The public exports, 
 *          prefixed with 'dsa' are defined at the very bottom.
 */

#include "../include/dsalgorithms-c/max.h"

/**
 * @brief Internal, private implementation of maxArrayInt, which
 *        finds the maximum element in an array of integers
 * @param array Pointer to the array of integers
 * @param n Number of elements in the array
 * @return The maximum element in the array
 * @since 0.1.0
 * @internal
 */
static int _maxArrayInt(const int *array, size_t n) {
  int currentMax = array[0];

  // Search linearly through remaining elements
  for (size_t i = 1; i < n; i++) {
    if (currentMax < array[i]) {
      currentMax = array[i];
    }
  }

  return currentMax;
}

/**
 * @brief Internal, private implementation of maxInt, which
 *        finds the larger of two integers.
 * @param a First integer
 * @param b Second integer
 * @return The larger of the two integers
 * @since 0.1.0
 * @internal
 */
static int _maxInt(const int a, const int b) {
  return (a >= b) ? a : b;
}

// Public exports
int dsa_maxArrayInt(const int *array, size_t n) {
  return _maxArrayInt(array, n);
}

int dsa_maxInt(const int a, const int b) {
  return _maxInt(a, b);
}
