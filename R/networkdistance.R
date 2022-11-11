############################################################################################
## package 'secrlinear'
## networkdistance.R
## 2022-11-12 asgraph, showpath in separate files
############################################################################################

networkdistance <- function (xy1, xy2, geometry) {
    ## notify secr.fit that no parameter is required
    if (missing(xy1)) return(character(0))
    ## form matrix of distances from each point in xy1 (rows)
    ## to each point in xy2 (columns), given geometry 'geometry'
    rn <- list(rownames(xy1), rownames(xy2))
    ## in case xy is not matrix or dataframe 2014-09-05
    if (is.null(dim(xy1)))
        xy1 <- matrix(xy1, ncol = 2)
    if (is.null(dim(xy2)))
        xy2 <- matrix(xy2, ncol = 2)
    if (missing(geometry))
        geometry <- xy2
    ## obtain igraph representation
    gr <- attr(geometry, 'graph')
    if (is.null(gr)) gr <- asgraph(geometry)

    ## relate points to geometry
    geometryxy <- cbind(V(gr)$x, V(gr)$y)
    matchedxy1 <- nearesttrap(xy1, geometryxy)
    matchedxy2 <- nearesttrap(xy2, geometryxy)
    uniquematchedxy1 <- unique(matchedxy1)
    ## weights = NULL means "use edge attribute 'weight' if present"
    tmp <- t(igraph::shortest.paths(gr, weights = NULL,
                v =  matchedxy2, to = uniquematchedxy1))
    rematch <- match(matchedxy1, uniquematchedxy1)
    tmp <- tmp[rematch,,drop = FALSE]
    if (!("weight" %in% igraph::list.edge.attributes(gr)))
        tmp <- tmp * spacing(geometry)
    dimnames(tmp) <- rn
    tmp
}
