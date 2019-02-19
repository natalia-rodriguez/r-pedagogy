# Note we need to install these packages, Jack we will add these to the JIRA ticket
library(knitr)
library(testthat)
library(stringr)
# JACK AND JAKE Be sure to set wd to correct location
# setwd("path name")
purl("./instagram.Rmd")

insta_solution <- read.csv("Instagram.csv", header=TRUE, sep=",", as.is=TRUE)

test_that("The insta dataframe contains the data from Instagram.csv",{
  expect_equal(insta_solution, insta_csv)
})

test_that("Did you re-assign column names inside the data frame?", {

  expect_equal( colnames(insta), c("user", "posts", "followers", "following", "likes10", "likes11", "likes12", "self_posts","sex","date","influence_ratio", "p2f"))

})


test_that("Plot layers match expectations",{
  expect_equal(gg$data, gginsta)
})

test_that("Scale is labelled correctly",{
  expect_identical(gg$labels$x, "Followers")
  expect_identical(str_trim(gg$labels$y), "Likes on 10th post")
})


test_that("The variable is the corect type", {
  expect_type(insta$posts, "double")
})
