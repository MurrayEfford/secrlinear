############################################################################################
## package 'secrlinear'
## utility.R
## 2022-11-12 separate files for several functions
############################################################################################

replacedefaults <- function (default, user) replace(default, names(user), user)

showedges <- function (mask, plt = TRUE, add = FALSE, type = c('all', 'noskips', 'skips'),
                       lengths = c(0,Inf), ...) {
    type <- match.arg(type)
    gr <- attr(mask, 'graph')
    if (!is.igraph(gr))
        stop("mask does not have valid graph attribute")
    ed <- get.edges(gr, E(gr))
    x <- V(gr)$x
    y <- V(gr)$y
    LineID <- V(gr)$LineID
    OK <- (E(gr)$weight >= lengths[1]) & (E(gr)$weight <= lengths[2])
    if (type != 'all') {
        mixed <- V(gr)$LineID[ed[,1]] != V(gr)$LineID[ed[,2]]
        if (type == 'skips')
            OK <- OK & mixed
        else
            OK <- OK & !mixed
    }
    start <- ed[OK,1]
    finish <- ed[OK,2]
    LineID1 <- LineID[start]
    LineID2 <- LineID[finish]
    x1 <- x[start]
    y1 <- y[start]
    x2 <- x[finish]
    y2 <- y[finish]
    ed <- data.frame(start = start, finish = finish,
                     line1 = LineID1, line2 = LineID2,
                     x1 = x1, y1 = y1, x2 = x2, y2 = y2,
                     weight = E(gr)$weight[OK])
    if (plt) {
        if (!add) plot(mask)
        segments(x1, y1, x2, y2, ... )
        invisible (ed)
    }
    else
        ed
}
#------------------------------------------------------------------------------------------

replot <- function(mask, xlim=NULL, ylim=NULL, ...) {
    if (is.null(xlim) | is.null(ylim)) {
        cat ("click on opposite corners \n")
        bb <- as.data.frame(locator(2))
        if (nrow(bb)<2) return(NULL)
        xlim <- sort(bb[,1])
        ylim <- sort(bb[,2])
    }
    eqscplot(0,0, xlim=xlim, ylim=ylim, xlab='', ylab='', axes=F, type='n' )
    plot(mask, add = TRUE, ...)
    NULL
}
#------------------------------------------------------------------------------------------

deleteedges <- function(mask, replot = TRUE, ...) {
    gr <- attr(mask, 'graph')
    x <- V(gr)$x
    y <- V(gr)$y
    usr <- par()$usr
    cat ("click on both ends \n")
    repeat {
        xy <- as.data.frame(locator(2))
        if (nrow(xy) < 2)
            break
        else {
            matched <- nearesttrap(xy, cbind(x,y))
            matched <- sort(matched)
            gr[matched[1], matched[2]] <- NULL
            cat("Edge between ", matched[1], " and ", matched[2], " deleted\n")
            segments(x[matched[1]], y[matched[1]], x[matched[2]], y[matched[2]], col='white', lwd=3)
        }
    }
    attr(mask, 'graph') <- gr
    if (replot) {
        replot (mask, xlim = usr[1:2], ylim = usr[3:4])
        showedges (mask, ...)
    }
    invisible(mask)
}
#------------------------------------------------------------------------------------------

addedges <- function(mask, replot = TRUE, ...) {
    gr <- attr(mask, 'graph')
    x <- V(gr)$x
    y <- V(gr)$y
    grxy <- cbind(x,y)
    usr <- par()$usr
    cat ("click on both ends \n")
    repeat {
        xy <- as.data.frame(locator(2))
        if (nrow(xy) < 2)
            break
        else {
            matched <- nearesttrap(xy, grxy)
            matched <- sort(matched)
            gr[matched[1], matched[2], attr="weight"] <- edist(grxy[matched[1],,drop=F],
                                                               grxy[matched[2],,drop=F])
            cat("Edge added between ", matched[1], " and ", matched[2], "\n")
            segments(x[matched[1]], y[matched[1]], x[matched[2]], y[matched[2]], col='green', lwd=3)
        }
    }
    attr(mask, 'graph') <- gr
    if (replot) {
        replot (mask, xlim = usr[1:2], ylim = usr[3:4])
        showedges (mask, ...)
    }
    invisible(mask)
}
#------------------------------------------------------------------------------------------

cleanskips <- function (mask) {
    skips <- showedges(mask, type = 'skips', plt = FALSE)
    if (nrow(skips) > 0) {
        skips <- split(skips, paste(skips$line1, skips$line2, sep = '.'))
        getbadedges <-  function(x) {
            notOK <- (1:nrow(x)) != which.min(x$weight)  ## not shortest
            if (any(notOK))
                as.matrix(x[notOK, c('start','finish'), drop = FALSE])
            else
                matrix(nrow=0,ncol=2)
        }
        badedge <- lapply(skips, getbadedges)
        badedges <- do.call(rbind, badedge)
        if (nrow(badedges)>0) {
            gr <- attr(mask, 'graph')
            gr[from = badedges[,1], to = badedges[,2]] <- NULL
            attr(mask, 'graph') <- gr
        }
    }
    mask
}
#------------------------------------------------------------------------------------------

cleanskipsgraph <- function (gr) {
    ed <- get.edges(gr, E(gr))
    LineID <- V(gr)$LineID
    OK <- LineID[ed[,1]] != LineID[ed[,2]]
    start <- ed[OK,1]
    finish <- ed[OK,2]
    weight <- E(gr)$weight[OK]
    skips <- data.frame(start = start, finish = finish,
                     line1 = LineID[start], line2 = LineID[finish],
                     weight = weight)
    if (nrow(skips) > 0) {
        skips <- split(skips, paste(skips$line1,skips$line2,sep='.'))
        getbadedges <-  function(x) {
            notOK <- (1:nrow(x)) != which.min(x$weight)  ## not shortest
            if (any(notOK))
                as.matrix(x[notOK, c('start','finish'), drop = FALSE])
            else
                matrix(nrow=0,ncol=2)
        }
        badedge <- lapply(skips, getbadedges)
        badedges <- do.call(rbind, badedge)
        gr[from = badedges[,1], to = badedges[,2]] <- NULL
    }
    gr
}
#------------------------------------------------------------------------------------------
## suppose we have a SpatialLines object and want a SpatialLinesDataFrame
## this should do it
## df <- data.frame(z = c(1,2), row.names= sapply(slot(Sl, "lines"), function(x) slot(x, "ID")))
## Sldf <- SpatialLinesDataFrame(Sl, data = df)
