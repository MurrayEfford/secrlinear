# #############################################################################
# package 'secrlinear'
# plot.linearpopn.R
# 2014-08-28, 2022-11-11
# #############################################################################

plot.linearpopn <- function (x, ..., jitter = 0, plotline = TRUE) {
    if (ms(x)) {
        ## force shared frame
        temp <- do.call(rbind, lapply(x, function(y) attr(y,'boundingbox')))
        vertices <- apply(temp,2,range)
        for (i in 1:length(x)) attr(x,'boundingbox') <- vertices
        lapply (x, plot, jitter = jitter, plotline = plotline, ...)
        invisible()        
    }
    else {
    mask <- attr(x, 'mask')
    class(x) <- c('popn','data.frame')
    x[,] <- x[,] + jitter * (runif(nrow(x)*2)-0.5) * spacing(mask)
    plot (x, ..., frame = FALSE)
    if (plotline)
        plot (attr(mask,('SLDF')), add = TRUE, col = 'grey')
    }
}
