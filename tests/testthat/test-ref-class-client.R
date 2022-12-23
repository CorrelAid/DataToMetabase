test_that("Client initilizes", {
  mc <- MetabaseClient()
  expect_equal(mc$session, "")
})

test_that("Client does not initilize w/o pwd", {
  withr::with_envvar(new = c("METABASE_PWD" = ""), expect_error(MetabaseClient()))
  mc <- MetabaseClient(password = "explicit_password")
  expect_equal(mc$password, "explicit_password")
})

test_that("Databases can be fetched", {
  mc <- MetabaseClient()
  expect_equal(mc$session, "")
  vcr::use_cassette("fetch-databases", {
    databases <- mc$get_databases()
  })
  expect_true(mc$session != "")
  expect_true(tibble::is_tibble(databases))
  expect_true(all(c("id", "name") %in% colnames(databases)))
})

test_that("Collection overview can be fetched", {
  mc <- MetabaseClient()
  vcr::use_cassette("fetch-collections", {
    collections <- mc$get_collections()
  })
  expect_true(tibble::is_tibble(collections))
  expect_true(all(c("id", "location", "name") %in% colnames(collections)))
})

test_that("Item overview can be fetched", {
  mc <- MetabaseClient()
  vcr::use_cassette("fetch-items", {
    items <- mc$get_items(12)
  })
  expect_true(tibble::is_tibble(items))
  expect_true(all(c("id", "model", "name") %in% colnames(items)))
})

test_that("Tables can be fetched", {
  mc <- MetabaseClient()
  vcr::use_cassette("fetch-tables", {
    tables <- mc$get_tables()
  })
  expect_true(tibble::is_tibble(tables))
  expect_true(
    all(c("table_id", "table_name", "db_id", "db_name") %in% colnames(tables))
  )
})

test_that("Specific cards can be fetched", {
  mc <- MetabaseClient()
  vcr::use_cassette("fetch-card", {
    card <- mc$get_card(147)
  })
  expect_equal(147, card$id)
})
