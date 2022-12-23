test_that("Unique ID lookup", {
  test_data1 <- tibble::tibble(id = 1:3, name = c("a", "b", "c"))
  test_data2 <- tibble::tibble(id = 1:3, name = c("a", "b", "b"))

  expect_equal(unique_id_lookup(test_data1, "a", "name", "id"), 1)
  expect_error(unique_id_lookup(test_data1, "d", "name", "id"))
  expect_error(unique_id_lookup(test_data2, "b", "name", "id"))
  expect_error(unique_id_lookup(test_data1, "a", "name", "invalid_column"))
})
