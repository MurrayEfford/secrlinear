## 2022-11-11 start

library(secrlinear)

## to avoid ASAN/UBSAN errors on CRAN, following advice of Kevin Ushey
## e.g. https://github.com/RcppCore/RcppParallel/issues/169
Sys.setenv(RCPP_PARALLEL_BACKEND = "tinythread")

###############################################################################
set.seed(1235)

# test_that("correct single-catch estimate", {
#     expect_equal(fitsum$predicted[,'estimate'], 
#         # c(6.051439, 0.247498, 28.834703),  # 1.2.0
#         c(6.063915,  0.243899, 28.850853),  # 1.3.0
#         
#         tolerance = 1e-4, check.attributes = FALSE)
# })

