## 2022-11-11 start

library(secrlinear)

## to avoid ASAN/UBSAN errors on CRAN, following advice of Kevin Ushey
## e.g. https://github.com/RcppCore/RcppParallel/issues/169
Sys.setenv(RCPP_PARALLEL_BACKEND = "tinythread")

###############################################################################
set.seed(1235)

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
mask <- read.linearmask(data = xy, spacing = 20)
trps <- make.line(mask, n = 15, startbuffer = 1000, by = 30)
inputdir <- system.file("extdata", package = "secrlinear")
habitatmap <- paste0(inputdir, "/silverstream.shp")

test_that("can read read.linearmask from dataframe", {
    expect_equal(mean(as.matrix(mask)), 314.7773242,
        tolerance = 1e-6, check.attributes = FALSE)
})

test_that("can read.linearmask from shapefile", {
    expect_silent(silverstreammask <- read.linearmask(file = habitatmap, 
        spacing = 50))
    expect_equal(mean(as.matrix(silverstreammask)), 3162550.963,
        tolerance = 1e-6, check.attributes = FALSE)
    expect_equal(masklength(silverstreammask), 91.45,
        tolerance = 1e-6, check.attributes = FALSE)
})

test_that("correct network distances", {
    netd <- networkdistance (trps, mask, mask)
    expect_equal(mean(netd), 718.8952381,
        tolerance = 1e-6, check.attributes = FALSE)
})

test_that("can make.line", {
    trps <- make.line(mask, n = 15, startbuffer = 1000, by = 50)
    expect_equal(nrow(trps), 15)
    expect_equal(mean(as.matrix(trps)), 284.7760167,
        tolerance = 1e-6, check.attributes = FALSE)
})

