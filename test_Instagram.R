#install.packages("testthat")

context("Instagram")

test_file("Instagram.R", reporter = default_reporter(), env = test_env(),
          start_end_reporter = TRUE, load_helpers = TRUE, encoding = "unknown",
          wrap = TRUE)

context("Testing column names")

test_that("Did you re-assign column names inside the data frame?", {

  expect_equal( colnames(insta), c("user", "posts", "followers", "following", "likes10", "likes11", "likes12", "self_posts","sex","date"))
  
})
