############################################################################################
## package 'secrlinear'
## asgraph.R
## last changed 2022-11-12, 2024-10-22
############################################################################################

asgraph <- function (mask) {
    
    ## "mask" is a provisional mask including line termini that will be used for the graph
    ## but dropped from mask points
    ## determine connection by Euclidean distance between points
    tempdist <- as.matrix(dist(mask))
    spacingfactor <- attr(mask, 'spacingfactor')
    tempdist[tempdist >= (spacing(mask) * spacingfactor)] <- NA   # >= 2024-10-22
    tempdist[upper.tri(tempdist, diag = TRUE)] <- NA
    ## value is the number of edges to create between a pair of vertices
    ## use only the lower triangle of distance matrix for undirected graph
    tempdist[!is.na(tempdist)] <- 1
    tempdist[is.na(tempdist)] <- 0
    graph <- graph.adjacency(tempdist, mode = 'lower')

    ## force within-line spacings to actual separation along network,
    ## known because we made it so with along.line
    ed <- get.edges(graph, E(graph))
    x <- mask$x
    y <- mask$y
    LineID <- covariates(mask)$LineID
    Terminal <- covariates(mask)$Terminal
    if (is.null(Terminal))
        terminal <- FALSE
    else
        terminal <- Terminal[ed[,1]] | Terminal[ed[,2]]
    nonconsecutive <- abs(apply(ed,1,diff)) > 1
    same <- (LineID[ed[,1]] == LineID[ed[,2]])
    lengths <- ((x[ed[,1]]- x[ed[,2]])^2  + (y[ed[,1]]- y[ed[,2]])^2)^0.5
    lengths[same & !terminal] <- spacing(mask)
    
    ## add vertex attributes - these really are needed because termini involved
    V(graph)$LineID <- LineID
    V(graph)$x <- x
    V(graph)$y <- y
    
    ## add edge attribute (required)
    E(graph)$weight <- lengths
    
    ## drop edges between nonconsecutive points within a line
    notOK <- same & nonconsecutive & !terminal
    graph[from = ed[notOK,1], to = ed[notOK,2]] <- NULL
    graph
}

## buildTopo = function(lines) {
## Another approach - just kept for future reference
## Barry Rowlingson
## https://rstudio-pubs-static.s3.amazonaws.com/1572_7599552b60454033a0d5c5e6d2e34ffb.html
##     g = gIntersection(lines, lines)
##     edges = do.call(rbind, lapply(g@lines[[1]]@Lines, function(ls) {
##         as.vector(t(ls@coords))
##     }))
##     lengths = sqrt((edges[, 1] - edges[, 3])^2 + (edges[, 2] - edges[, 4])^2)
##
##     froms = paste(edges[, 1], edges[, 2])
##     tos = paste(edges[, 3], edges[, 4])
##
##     graph = graph.edgelist(cbind(froms, tos), directed = FALSE)
##     E(graph)$weight = lengths
##
##     xy = do.call(rbind, strsplit(V(graph)$name, " "))
##
##     V(graph)$x = as.numeric(xy[, 1])
##     V(graph)$y = as.numeric(xy[, 2])
##     return(graph)
## }
