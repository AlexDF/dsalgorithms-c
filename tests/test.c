#include <stdio.h>
#include <dsalgorithms-c/dsalgorithms-c.h>
#include <dsalgorithms-c/max.h>

int main() {
  int arr[] = {1,2,3};
  int maxElement = dsalgorithms_maxArrayInt(arr, 3);
  int maxOfTwo = dsa_maxInt(4,5);

  printf("The maximum value of { 1, 2, 3 } is: %d\n", maxElement);
  printf("The larger of 4 and 5 is: %d\n\n", maxOfTwo);

  return 0; 
}

