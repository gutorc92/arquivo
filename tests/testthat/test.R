context("Testing package")

test_that("Teste get env", {
  files_env <- get_env()
  expect_equal(TRUE, is.environment(files_env))
})
