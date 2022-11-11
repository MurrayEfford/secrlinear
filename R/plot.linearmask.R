# #############################################################################
# package 'secrlinear'
# plot.linearmask.R
# 2014-08-28, 2022-11-11
# #############################################################################

plot.linearmask <- function(x, ..., linecol = 'black', label = FALSE,
                            laboffset = c(spacing(x), 0)) {

    defaultarg <- list(col = 'lightgrey', pch = 16, add = FALSE, 
                       lty = 1, lwd = 1, legend = TRUE, pt.cex = 1)
    arg <- list(...)
    arg <- replacedefaults(defaultarg, arg)
    arg$x <- x
     
    linearg <- arg[names(arg) %in% c('lwd','lty')]
    arg <- arg[!names(arg) %in% names(linearg)]
    legend <- arg$legend
    arg$legend <- FALSE   ## suppress plot.mask legend
    
    ## optionally under plot with SLDF
    if (is.null(arg$border)) {
        plot(attr(x, 'SLDF'),  col = linecol, lty = linearg$lty,
             lwd = linearg$lwd, add = arg$add)
        arg$add <- TRUE
    }    
    ## plot.mask
    class(arg$x) <- class(arg$x)[-1]   ## as mask, not linearmask
    legenddata <- do.call(plot, arg)
    
    if (legend & !is.null(arg$covariate)) {
        ncolour <- length(legenddata)
        if (length(arg$col) < ncolour) {
            if (length(arg$col) > 1)
                warning ("too few colours; using terrain.colors(", ncolour, ")")
            arg$col <- terrain.colors(ncolour)   
        }
        legend('right', legend = rev(legenddata), pch = 16, 
               pt.cex = arg$pt.cex, 
               col = rev(arg$col[1:ncolour]),
               title = arg$covariate)
    }    
    
    if (!is.na(linecol))
        plot(attr(x, 'SLDF'),  col = linecol, lty = linearg$lty,
             lwd = linearg$lwd, add = TRUE)
    if (label)
        text (x$x+laboffset[1], x$y+laboffset[2], rownames(x), cex=0.6)
    
    invisible(legenddata)
}
 
# plot.linearmask <- function(x, ..., linecol = 'black', label = FALSE,
#                             laboffset = c(spacing(x), 0), add = FALSE) {
#     arg <- list(...)
#     arg$x <- x
#     if (is.null(arg$col))
#         arg$col <- 'lightgrey'
#     if (is.null(arg$pch))
#         arg$pch <- 16
#     linearg <- arg[names(arg) %in% c('lwd','lty')]
#     if(is.null(linearg$lty))
#         linearg$lty <- 1
#     if(is.null(linearg$lwd))
#         linearg$lwd <- 1
#     arg <- arg[!names(arg) %in% names(linearg)]
#     
#     plot(attr(x, 'SLDF'),  col = linecol, lty = linearg$lty,
#          lwd = linearg$lwd, add = add)
#     do.call(points, arg)
#     plot(attr(x, 'SLDF'),  col = linecol, lty = linearg$lty,
#          lwd = linearg$lwd, add = TRUE)
#     if (label)
#         text (x$x+laboffset[1], x$y+laboffset[2], rownames(x), cex=0.6)
#     
# }
