############################################################################################
## package 'secrlinear'
## read.linearmask.R
## last changed 2014-08-30; 2014-10-26 graph attribute;
## 2014-10-31 optional read from shapefile
## 2014-11-03 make.linearmask (called by read.linearmask and rbind.linearmask)
## 2023-12-15 drop empty geometries from sf object before as(...,"Spatial)
## "this resource by B. Rowlingson is quite inspiring :"
## https://rstudio-pubs-static.s3.amazonaws.com/1572_7599552b60454033a0d5c5e6d2e34ffb.html
############################################################################################

make.linearmask <- function (SLDF, spacing, spacingfactor, graph, cleanskips)  {
    ## for bounding box...
    tmp <- lapply(sp::coordinates(SLDF), function(x) do.call("rbind", x))
    tmp <- do.call(rbind, tmp)
    xyl <- lapply(as.data.frame(tmp), range)
    names(xyl) <- c('x','y')

    ## discretize line
    maskSPDF <- sample.line (SLDF, spacing)   ## SPDF
    if (is.null(maskSPDF)) {
        mask <- data.frame(x=numeric(0), y=numeric(0))
        covariates(mask) <- data.frame(LineID = numeric(0))
    }
    else {
         mask <- data.frame(sp::coordinates(maskSPDF))         ## dataframe
         names(mask) <- c('x', 'y')
    }
    attr(mask, 'SLDF') <- SLDF
    attr(mask,'boundingbox') <- do.call(expand.grid, xyl)[c(1,2,4,3),]
    attr(mask,'type')    <- 'user'
    attr(mask,'spacing') <- spacing
    attr(mask,'spacingfactor') <- spacingfactor
    class(mask) <- c('linearmask', 'mask', 'data.frame')

    if (nrow(mask) > 0) {
        ## covariates
        df <- data.frame(maskSPDF)
        covariates(mask) <- df

        ## construct graph
        if (graph) {
            attr(mask, 'graph') <- asgraph(mask)
        }

        ## remove termini etc.
        OK <- !(names(df) %in% c( "coords.x1", "coords.x2", "x", "y", "Terminal"))
        terminal <- df$Terminal
        mask <- mask[!terminal,]
        covariates(mask) <- covariates(mask)[!terminal,OK]
        attr(mask,'meanSD')  <- getMeanSD(mask)

        if(cleanskips)
            mask <- cleanskips(mask)
    }

    mask
}

read.linearmask <- function (file = NULL, data = NULL, spacing = 10, spacingfactor = 1.5,
                             graph = TRUE, cleanskips = TRUE, ...)
{
  if (is.null(data)) {
        if (is.null(file)) stop("require one of 'file' or 'data'")
        else {
            if (tools::file_ext(file) == 'shp') {
              data <- st_read(file, quiet = TRUE)
              data <- data[!st_is_empty(data),,drop = FALSE]  # 2023-12-15
              data <- as(data, "Spatial")
            }
            else {
                data <- read.table (file, ...)
            }
        }
    }
  
    isSLDF <- is(data, "SpatialLinesDataFrame")
    if (!isSLDF) {
        if (length(dim(data))!=2)
            stop ("require SpatialLinesDataFrame, dataframe or matrix",
                  " for 'data' input to read.linearmask")
        coln <- colnames(data)
        ixy <- match(c('x', 'y'), tolower(coln))
        if (any(is.na(ixy))) ixy <- 1:2
        mask <- as.data.frame(data[,ixy])
        names(mask) <- c('x', 'y')
        if (any(!apply(mask, 2, is.numeric)))
        stop ("non-numeric x or y coordinates")
        if (any(is.na(unlist(mask))))
            stop ("missing value(s) in x or y coordinates")
        if ('LineID' %in% coln)
            mask <- cbind(data[,'LineID'], mask)
        SLDF <- make.sldf(mask)
    }
    else {
        SLDF <- data
    }

    make.linearmask(SLDF, spacing, spacingfactor, graph, cleanskips)
}
