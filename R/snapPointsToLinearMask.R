############################################################################################
## package 'secrlinear'
## snapPointsToLinearMask.R
## last changed 2022-11-12
############################################################################################

snapPointsToLinearMask <- function (xy, mask) {
    gr <- attr(mask, 'graph')
    geometryxy <- data.frame(x = V(gr)$x, y = V(gr)$y)
    matchedxy <- nearesttrap(xy, geometryxy)
    tempxy <- geometryxy[matchedxy,,drop = FALSE]
    mostattributes(tempxy) <- attributes(xy)
    tempxy
}
