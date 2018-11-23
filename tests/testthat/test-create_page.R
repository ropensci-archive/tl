context("test-create_page")

test_that("a new .md file is created", {

  create_page("testFun", "testNS")
  expect_true(file.exists("testNS/testFun.md"))

})

