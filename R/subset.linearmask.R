# #############################################################################
# package 'secrlinear'
# subset.linearmask.R
# 2014-08-28, 2022-11-11
# #############################################################################

subset.linearmask <- function (x, subset, LineID, droplinesbeyond = Inf, ...) {

    if (ms(x))
        stop ("subset of multi-session linearmask not implemented")

    # subset may be numeric index or logical
    SLDF <- attr(x, 'SLDF')
    if (!missing(LineID)) {
        if (!missing(subset))
            stop("specify only one of subset and LineID")
        SLDF <- SLDF[LineID, ]
        subset <- covariates(x)$LineID %in% LineID
    }
    temp <- x[subset,,drop=F]
    covariates(temp) <- covariates(x)[subset,,drop=F]

    if (is.finite(droplinesbeyond)) {
        beyond <- function (xy) {
            xy <- do.call(rbind, xy)
            !any(distancetotrap (xy, temp) < droplinesbeyond)
        }
        xyl <- coordinates(SLDF)
        df <- data.frame(SLDF)
        SLDF <- SLDF[!sapply(xyl, beyond), ]
    }
    attr(temp,'type')        <- 'subset'
    attr(temp,'meanSD')      <- getMeanSD(temp)
    attr(temp,'SLDF')        <- SLDF
    attr(temp,'spacing')     <- attr(x,'spacing')
    attr(temp,'spacingfactor')     <- attr(x, 'spacingfactor')

    xyl <- lapply(temp, range)
    names(xyl) <- c('x','y')
    attr(temp,'boundingbox') <- do.call(expand.grid, xyl)[c(1,2,4,3),]

    ## re-form graph if present in first original mask
    if (!is.null(attr(x, 'graph'))) {
        attr(temp, 'graph') <- asgraph(temp)
    }

    if (!is.null(attr(temp,'OK')))
        attr(temp,'OK') <- attr(temp,'OK')[subset]
    class(temp) <- class(x)
    temp
}