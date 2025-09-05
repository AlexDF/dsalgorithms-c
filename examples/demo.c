#include <stdio.h>
#include "../include/dsalgorithms-c/dsalgorithms-c.h"
#include "../include/dsalgorithms-c/max.h"

int main(int argc, char *argv[]) {
  int testArray[] = {3, 7, 2, 1, 8, 4};
  size_t arraySize = sizeof(testArray) / sizeof(testArray[0]);
  int maxElement = dsalgorithms_maxArrayInt(testArray, arraySize);

  int value1 = 4, value2 = 10;
  int maxOfTwo = dsa_maxInt(value1, value2);

  printf(
    "\n**************************"
    "\n********* demo.c *********"
    "\n**************************"
    "\n\n"
  );

  printf("Testing dsalgorithms_maxArrayInt(int *array):\n");
  printf("Array: {");
  for (size_t i = 0; i < arraySize; i++) {
    printf("%d", testArray[i]);
    i == (arraySize - 1) ? 
      printf(" "): printf(", ");
  }
  printf("}\n");
  printf("Maximum element: %d\n\n", maxElement);

  printf("Testing dsa_maxInt(int a, int b):\n");
  printf("Value 1: %d, Value 2: %d\n", value1, value2);
  printf("Larger number: %d\n\n", maxOfTwo);

  return 0;
}
