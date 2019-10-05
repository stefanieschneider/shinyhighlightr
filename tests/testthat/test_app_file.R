context("App")

library(shinytest)

test_that("app works", {
  skip_on_cran()

  appdir <- system.file(package = "shinyhighlightr", "appdir")
  expect_pass(testApp(appdir, compareImages = FALSE))
})
