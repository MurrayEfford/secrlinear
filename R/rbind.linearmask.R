# #############################################################################
# package 'secrlinear'
# rbind.linearmask.R
# 2014-08-28, 2022-11-11
# #############################################################################

rbind.linearmask <- function (..., cleanskips = TRUE) {

    allargs <- list(...)
    spacing <- attr(allargs[[1]], 'spacing')
    spacingfactor <- attr(allargs[[1]], 'spacingfactor')
    check <- function (x) {
        if (!is(x,'linearmask'))
            stop ("arguments must be linearmask objects")
        if (attr(x,'spacing') != spacing)
            stop ("arguments must have same 'spacing' attribute")
        if (attr(x,'spacingfactor') != spacingfactor)
            stop ("arguments must have same 'spacingfactor' attribute")
    }
    sapply (allargs, check)

    vert <- lapply(allargs, attr, 'SLDF')

    # ## must ensure unique ID
    ID <- lapply(vert, function(x) rownames(as(x, 'data.frame')))
    ID2 <- mapply(function(x,i) paste(i,x,sep='.'), ID, 1:length(ID))
    vert <- mapply(spChFIDs, vert, ID2)
    
    # if (!requireNamespace("maptools")) stop("package maptools currently required")
    # newvert <- do.call(maptools::spRbind, vert)          ## SLDF
    
    newvert <- do.call(rbind, vert)          ## SLDF
    
    xyl <- lapply(coordinates(newvert), range)
    maskSPDF <- sample.line (newvert, spacing)           ## SPDF
    tmp <- data.frame(maskSPDF)
    mask <- data.frame(coordinates(maskSPDF))            ## dataframe
    names(mask) <- c('x', 'y')

    graph <-  !is.null(attr(allargs[[1]], 'graph'))

    make.linearmask(newvert, spacing, spacingfactor, graph, cleanskips = cleanskips)

}
