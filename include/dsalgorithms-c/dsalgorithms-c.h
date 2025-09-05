/**
 * @file dsalgorithms-c.h
 * @brief dsalgorithms-c main entry point header
 * @details This is the primary public interface for the dsalgorithms-c library. 
 *          Users should include this header to access the entire library.
 * @version 0.1.0~alpha1-1
 * @author Alexandre De Freitas
 */


#pragma once
#include <stddef.h>

/**
 * @brief Find the maximum element in an array of integers
 * @param array Pointer to the array of integers
 * @param n   Number of elements in the array (must be >= 1)
 * @return    The maximum element in the array
 * @since 0.1.0
 * @pre array != NULL && n > 0
 * @note Behavior is undefined if array is NULL or n is 0
 * 
 * @par Example:
 * @code
 * int numbers[] = {3, 7, 2, 9, 1};
 * int max = dsalgorithms_maxArrayInt(numbers, 5); // Returns 9
 * @endcode
 */
int dsalgorithms_maxArrayInt(const int *array, size_t n);

/**
 * Return the larger of two numbers.
 * 
 * @param a First number
 * @param b Second number
 * @return  The larger of the two numbers
 * @since 0.1.0
 * @pre a and b are type 'int'
 * @note Behavior is undefined if a or b are not valid integer values
 * 
 * @par Example:
 * @code
 * int result = dsalgorithms_maxInt(5, 10); // Returns 10
 * @endcode
 */
int dsalgorithms_maxInt(const int a, const int b);
