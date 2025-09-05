#include "unity.h"
#include "../include/dsalgorithms-c/dsalgorithms-c.h"

void setUp(void) {}
void tearDown(void) {}

void test_dsalgorithms_maxInt(void) {
  TEST_ASSERT_EQUAL(6, dsalgorithms_maxInt(-1, 6));
}

void test_dsalgorithms_maxArrayInt(void) {
  int arr_mixed_nums[] = {-2,-1,0,1,2};
  TEST_ASSERT_EQUAL(2, dsalgorithms_maxArrayInt(arr_mixed_nums, 5));
}

int main(void) {
  UNITY_BEGIN();

  RUN_TEST(test_dsalgorithms_maxInt);
  RUN_TEST(test_dsalgorithms_maxArrayInt);

  return UNITY_END();
}
