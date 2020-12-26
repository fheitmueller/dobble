test_that("create_cards() makes cards out of test pictures", {
  infolder <-

  expect_equal(length(list.files(outfolder)), 57)
})
