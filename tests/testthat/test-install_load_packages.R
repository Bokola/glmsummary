
test_that("a non empty comma separated character vector is supplied as pkg argument", {
  expect_type("glmsummary", "character")
  expect_type(c("glmsummary", "glmsummary"), "character")
})
