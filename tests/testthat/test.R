context("Testing package")

test_that("Teste get env", {
  files_env <- get_env()
  expect_equal(TRUE, is.environment(files_env))
})

test_that("Set bases files", {
  f <- system.file("extdata", "bases.csv", package = "arquivoIPEA")
  set_bases_file(f)
  expect_equal(f, get_bases_file())
})

test_that("Check variables", {
  result <- check_variable("test")
  expect_equal(FALSE, result)
  files_env <- get_env()
  files_env$test <- 1
  result <- check_variable("test")
  expect_equal(TRUE, result)
})

test_that("Check set variable", {
  test <- 1
  set_variable("test", test)
  result <- check_variable("test")
  expect_equal(TRUE, result)
})

test_that("Read servers", {
  f <- system.file("extdata", "bases.csv", package = "arquivoIPEA")
  set_bases_file(f)
  read_from_function <- read_servers()
  result <- data.frame(server1=c("E:"), server2=c("J:"), X=c(NA), X.1=c(NA), stringsAsFactors = F)
  expect_equal(read_from_function, result)
})

test_that("Read bases", {
  f <- system.file("extdata", "bases.csv", package = "arquivoIPEA")
  set_bases_file(f)
  read_from_function <- read_bases()
  bases <- c("Rais","CadUnico")
  file.name <- c("rais_2","cad_unico2")
  dir.input <- c("rais","cad_unico")
  dir.output <- c("consolidadas/rais", "consolidadas/cad_unico")
  result <- data.frame(bases=bases, file_name=file.name, dir_input=dir.input, dir_output=dir.output, stringsAsFactors = F)
  expect_equal(read_from_function, result)
})


