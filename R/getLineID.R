############################################################################################
## package 'secrlinear'
## getLineID.R
## 2022-11-12 separate file
############################################################################################

getLineID <- function (mask, laboffset= rep(spacing(mask)*3,2), ...) {
    if (is.null(covariates(mask)$LineID))
        stop("LineID not found in covariates(mask)")
    plot(mask, ...)
    cat ("click on line \n")
    output <- data.frame(Point=numeric(0), LineID=character(0))
    repeat {
        xy1 <- as.data.frame(locator(1))
        if (nrow(xy1) < 1)
            break
        else {
            matched <- nearesttrap(xy1, mask)
            lineID <- as.character(covariates(mask)$LineID[matched])
            cat("Point ", matched, " is on line ", lineID, "\n")
            points(mask$x[matched], mask$y[matched], pch=1)
            text (mask$x[matched] + laboffset[1], mask$y[matched] + laboffset[2],
                lineID, cex=0.7, col = 'red')
            output<- rbind(output, data.frame(Point=matched, LineID=lineID, stringsAsFactors=FALSE))
        }
    }
    invisible (output)
}

