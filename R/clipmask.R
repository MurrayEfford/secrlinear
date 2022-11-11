############################################################################################
## package 'secrlinear'
## clipmask.R
## last changed 2022-11-11 untested
############################################################################################

clipmask <- function (mask, traps, buffer = 100, clipvert = FALSE) {
    tmp <- networkdistance (mask, traps, geometry = mask)
    inrange <- apply(tmp,1,min) < buffer
    mask <- subset(mask, inrange)
    if (clipvert) {

        # if (!requireNamespace('rgeos', quietly = TRUE))
        #     stop ("clipvert currently requires package rgeos")
        # SPDF <- SpatialPoints(coords = as.matrix(mask))
        # SP <- rgeos::gBuffer(spgeom = SPDF, width = attr(mask, "spacing")/2)
        # SLDF <- attr(mask, "SLDF")
        # newvert <- rgeos::gIntersection (SLDF, SP)
        # ldf <-  data.frame(ID = 1:length(newvert), rownames=1)
        # newvert <- SpatialLinesDataFrame(newvert, data = ldf)
        
        sfmaskpoints <- st_sfc(st_multipoint(as.matrix(mask)))
        sfmaskpoly <- st_buffer(sfmaskpoints, attr(mask, "spacing")/2)  
        sfmasklines <- st_as_sf(attr(mask, "SLDF"))
        newvert <- st_intersection (sfmasklines, sfmaskpoly)
        attr(mask, "SLDF") <- as(newvert, 'Spatial')
    }
    mask
}

clippopn <- function (popn, mask, buffer = 100) {
    tmp <- networkdistance (mask, popn, geometry = mask)
    inrange <- apply(tmp,2,min) < buffer
    popn <- subset(popn, inrange)
    popn
}

