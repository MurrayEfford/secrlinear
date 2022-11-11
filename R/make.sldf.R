############################################################################################
## package 'secrlinear'
## make.sldf.R
## last changed 2022-11-12
## 2014-11-07 allow breaks in lines
############################################################################################

make.sldf <- function (coord, f) {
    ## Form SpatialLinesDataFrame from coordinates data
    ## coord is dataframe of coordinates - must include columns 'x','y'
    ## f is vector of values by which to split coord rows
    if (missing(f) & ('LineID' %in% names(coord)))
        f <-  coord$LineID
    if (missing(f))
        coordlist <- list(coord)
    else
        coordlist <- split(coord[,c('x','y')], f)
    S0 <- lapply(coordlist, Line)
    S1 <- Lines(S0, ID = '1')
    S2 <- SpatialLines(list(S1))
    ldf <-  data.frame(ID = 1:length(S2), rownames=1)
    SpatialLinesDataFrame(S2, data = ldf)
}
#------------------------------------------------------------------------------------------

