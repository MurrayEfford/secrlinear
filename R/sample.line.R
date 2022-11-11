############################################################################################
## package 'secrlinear'
## sample.line.R
## last changed 2022-11-12
############################################################################################

along.line <- function (route, spacing, break.at = 0) {
    ## Interpolate points along route at interval 'spacing'
    ## route is matrix of vertices
    np <- nrow(route)
    if (nrow(route)<2) {
        return (matrix(nrow=0, ncol=2))
    }
    dxy <- route[2:np,,drop=FALSE] - route[1:(np-1),,drop=FALSE]
    d <- apply(dxy^2,1,sum)^0.5
    d[break.at] <- 0    ## disjoint lines
    cumd <- cumsum(d)
    linelength <- cumd[np-1]
    if (linelength == 0)
        return (matrix(nrow=0, ncol=2))
    else {
        
        ipos <- seq(spacing/2, linelength, spacing)
        first <- sapply(ipos, function(x) match(TRUE, cumd>=x))
        cumd <- c(0,cumd)
        add <- ipos - cumd[first]
        pr <- add / d[first]
        result <- route[first,, drop = FALSE] + dxy[first,] * pr
        result <- cbind(result, rep(0, nrow(result)), ipos)
        itermini <- c(cbind(break.at, break.at+1)[-1],np)
        termini <- cbind(route[itermini,], rep(1, length(itermini)), cumd[itermini])
        result <- rbind(result, termini)
        result <- result[order(result[,4]), 1:3]
        return(result)
    }
}

sample.line <- function(x, spacing) {
    ## Function for systematic point sample
    ## Input  -- SpatialLinesDataFrame
    ## Output -- SpatialPointsDataFrame
    ## default type=2 includes endpoints
    sampleone <- function (i) {
        lsub <- x[i,]
        ns <- trunc(lgth[i] / spacing)
        if (ns>0) {
            xyL <- coordinates(lsub)[[1]]
            nLine <- length(xyL)
            nperLine <- sapply(xyL, nrow)
            xy <- do.call(rbind, xyL)
            breaks <- c(0, cumsum(nperLine)[-nLine])
            lsamp <- along.line(xy, spacing, breaks)
            nrl <- nrow(lsamp)
            pdf <- data.frame(LineID = rep(i, nrl), Terminal = as.logical(lsamp[,3]))
            pdf <- merge(pdf, lsub)
            SpatialPointsDataFrame(lsamp[,1:2], data = pdf)
        }
        else NULL
    }
    if (!is(x, "SpatialLinesDataFrame")) stop("x must be SpatialLinesDataFrame")
    lgth <- SpatialLinesLengths(x)
    nr <- nrow(x)
    ## For each feature
    results <- sapply(1:nr, sampleone)
    results <- results[!sapply(results, is.null)]
    do.call(rbind, results)
}

