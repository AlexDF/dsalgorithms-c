#include "unity.h"
#include "../include/dsalgorithms-c/max.h"

void setUp(void) {
  // Called before each test
}

void tearDown(void) {
  // Called after each test
}

void test_dsa_maxInt(void) {
  TEST_ASSERT_EQUAL(5, dsa_maxInt(3, 5));
  TEST_ASSERT_EQUAL(-2, dsa_maxInt(-2, -8));
  TEST_ASSERT_EQUAL(6, dsa_maxInt(-1, 6));
  TEST_ASSERT_EQUAL(15, dsa_maxInt(0, 15));
  TEST_ASSERT_EQUAL(30, dsa_maxInt(30, 30));
}

void test_dsa_maxArray(void) {
  int arr_positive_nums[] = {0,1,2,3};
  int arr_negative_nums[] = {-4,-3,-2,-1};
  int arr_mixed_nums[] = {-2,-1,0,1,2};

  TEST_ASSERT_EQUAL(3, dsa_maxArrayInt(arr_positive_nums, 4));
  TEST_ASSERT_EQUAL(-1, dsa_maxArrayInt(arr_negative_nums, 4));
  TEST_ASSERT_EQUAL(2, dsa_maxArrayInt(arr_mixed_nums, 5));
}

int main(void) {
  UNITY_BEGIN();

  RUN_TEST(test_dsa_maxInt);
  RUN_TEST(test_dsa_maxArray);

  return UNITY_END();
}
