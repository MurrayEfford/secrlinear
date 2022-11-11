############################################################################################
## package 'secrlinear'
## showpath.R
## 2022-11-12 showpath in separate file
############################################################################################

## Call this function interactively to verify the difference between
## Euclidean and network distances. In order to compute network distances
## with networkdistance() we set the `mask' attribute of its second
## argument.

showpath <- function (mask, add = FALSE, ...) {
    plot(mask, cex = 0.5, add = add)
    results <- NULL
    paths <- vector('list')
    npath <- 0
    repeat {
        cat("Click near 'from' and 'to' points\n\n")
        flush.console()
        xy <- as.data.frame(locator(2))
        if (nrow(xy) < 2)
            break
        else {
            matched <- nearesttrap(xy, mask)
            points(xy, pch = 1, cex = 1.3, col = 'black', type = 'p')
            points(mask[matched,], pch = 16, cex = 1.3, col = 'red',
                type = 'o', lwd = 2, lty = 2)
            path <- get.shortest.paths(asgraph(mask), matched[1], matched[2])
            maskpoints <- data.frame(mask[path$vpath[[1]],])
            lines(maskpoints, col = 'red', type = 'l', ...)
            npath <- npath + 1
            paths[[npath]] <- maskpoints
            xy1 <- xy[1,]; xy2 <- xy[2,]
            attr(xy2, 'mask') <- mask
            Euclid <- as.numeric(dist(mask[matched,]))
            network <- as.numeric(networkdistance(xy1, xy2, geometry = mask))
            temp <- data.frame(from = matched[1],
                to = matched[2],
                Euclidean.d = Euclid,
                network.d = network)
            if (is.null(results)) {
                results <- temp
            }
            else {
                results <- rbind(results,temp)
            }
            cat('Mask points       ', matched, '\n')
            cat('Euclidean distance', Euclid, ' m \n')
            cat('Network distance  ', network, ' m \n\n')
            flush.console()
        }
    }
    results <- list(paths = paths, results = results)
    invisible(results)
}
