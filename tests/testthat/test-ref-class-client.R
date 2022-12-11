test_that("Client initilizes", {
  mc <- MetabaseClient()
  expect_equal(mc$session, "")
})

test_that("Databases can be fetched", {
  mc <- MetabaseClient()
  expect_equal(mc$session, "")
  vcr::use_cassette("fetch-databases", {
    databases <- mc$get_databases()
  })
  expect_true(mc$session != "")
  expect_true(tibble::is_tibble(databases))
})
